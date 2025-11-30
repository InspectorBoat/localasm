const std = @import("std");

pub fn build(b: *std.Build) void {
    const asm_cleaner = b.addExecutable(.{
        .name = "assembly_cleaner",
        .root_module = b.addModule("assembly_cleaner", .{
            .root_source_file = b.path("clean_assembly.zig"),
            .target = b.graph.host,
            .optimize = .ReleaseFast,
        }),
    });
    b.installArtifact(asm_cleaner);

    const test_asm_cleaner = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("clean_assembly.zig"),
            .target = b.graph.host,
            .optimize = .Debug,
        }),
    });

    _ = b.step("test", "Run unit tests")
        .dependOn(&b.addRunArtifact(test_asm_cleaner).step);

    _ = b.addModule("localasm", .{
        .root_source_file = b.path("assembly_helper.zig"),
    });
}

pub const AssemblyOutputOptions = struct {
    /// Directory to install generated assembly and analysis files to
    install_dir: std.Build.InstallDir = .{ .custom = "asm" },

    /// Output raw assembly (extremely noisy, disabled by default)
    raw_asm_step_info: ?struct {
        name: []const u8 = "rawasm",
        output_file: []const u8 = "rawasm.s",
    } = null,

    /// Output assembly stripped of unused labels and directives
    clean_asm_step_info: ?struct {
        name: []const u8 = "asm",
        output_file: []const u8 = "asm.s",
    } = .{},

    /// Send cleaned assembly to llvm-mca for analysis
    mca_step_info: ?struct {
        name: []const u8 = "mca",
        ouput_file: []const u8 = "mca.txt",
        /// Pass arguments to llvm-mca
        args: ?[]const []const u8 = null,
        command_path: []const u8 = "llvm-mca",
    } = .{},
};

pub fn addAssemblyOutput(b: *std.Build, compile: *std.Build.Step.Compile, options: AssemblyOutputOptions) void {
    const localasm = b.lazyDependency("localasm", .{}) orelse return;

    if (compile.use_llvm == null orelse !compile.use_llvm.?) {
        std.log.warn("use_llvm should be enabled, as self-hosted backend cannot emit assembly (yet)", .{});
    }

    const raw_asm = compile.getEmittedAsm();

    // Install raw assembly output
    if (options.raw_asm_step_info) |raw_asm_step_info| {
        const raw_asm_step = b.step(raw_asm_step_info.name, "Install raw assembly output");
        raw_asm_step.dependOn(
            &b.addInstallFileWithDir(
                raw_asm,
                options.install_dir,
                raw_asm_step_info.output_file,
            ).step,
        );
    }

    // Get program to clean up assembly file - used for both clean_asm and mca steps
    const asm_cleaner = localasm.artifact("assembly_cleaner");

    // Install cleaned assembly file
    if (options.clean_asm_step_info) |clean_asm_step_info| {
        // Clean up assembly file
        const run_asm_cleaner = b.addRunArtifact(asm_cleaner);
        run_asm_cleaner.setStdIn(.{ .lazy_path = raw_asm });

        const clean_asm_step = b.step(clean_asm_step_info.name, "Install cleaned assembly output");
        clean_asm_step.dependOn(
            &b.addInstallFileWithDir(
                run_asm_cleaner.captureStdOut(),
                options.install_dir,
                clean_asm_step_info.output_file,
            ).step,
        );
    }

    // Install llvm-mca analysis
    if (options.mca_step_info) |mca_step_info| {
        // Clean assembly, but this time add .intel_syntax to the beginning so llvm-mca can recognize it
        const run_asm_cleaner = b.addRunArtifact(asm_cleaner);
        run_asm_cleaner.setStdIn(.{ .lazy_path = raw_asm });
        run_asm_cleaner.addArg("--intelsyntaxdirective");

        // Run llvm-mca analysis
        const run_mca = b.addSystemCommand(&.{mca_step_info.command_path});
        run_mca.setStdIn(.{ .lazy_path = run_asm_cleaner.captureStdOut() });
        if (mca_step_info.args) |args| {
            run_mca.addArgs(args);
        }

        const mca_analysis = run_mca.captureStdOut();
        const install_mca_analysis = b.addInstallFileWithDir(
            mca_analysis,
            options.install_dir,
            mca_step_info.ouput_file,
        );

        const mca_step = b.step(mca_step_info.name, "Install llvm-mca analysis");
        mca_step.dependOn(&install_mca_analysis.step);
    }
}
