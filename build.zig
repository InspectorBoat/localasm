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
}

pub const AssemblyOutputOptions = struct {
    optimize: std.builtin.OptimizeMode = .ReleaseFast,
    target: std.Build.ResolvedTarget,

    // Directory to install generated assembly and analysis files to
    install_dir: std.Build.InstallDir = .{ .custom = "asm" },

    // whether to enable a step that outputs raw assembly (extremely noisy)
    enable_raw_asm_step: bool = false,
    raw_asm_step_name: []const u8 = "rawasm",
    raw_asm_file_name: []const u8 = "rawasm.s",

    // whether to enable the step that outputs assembly stripped of unused labels and directives
    enable_clean_asm_step: bool = true,
    clean_asm_step_name: []const u8 = "asm",
    clean_asm_file_name: []const u8 = "asm.s",

    // whether to enable a step that sends the assembly to llvm-mca for analysis
    enable_mca_step: bool = true,
    mca_step_name: []const u8 = "mca",
    mca_file_name: []const u8 = "mca.txt",
};

pub fn addAssemblyOutput(b: *std.Build, module: *std.Build.Module, options: AssemblyOutputOptions) void {
    const localasm = b.dependency("localasm", .{});

    const assembly_helper = b.addStaticLibrary(.{
        .name = "assembly_helper",
        .root_module = b.createModule(.{
            .root_source_file = localasm.path("assembly_helper.zig"),
            .optimize = options.optimize,
            .target = options.target,
            .imports = &.{.{ .name = "main", .module = module }},
            .omit_frame_pointer = true,
        }),
    });

    const raw_asm = assembly_helper.getEmittedAsm();

    // Create program to clean up assembly file
    const asm_cleaner = localasm.artifact("assembly_cleaner");

    // Clean up assembly file
    const clean_asm = b.addRunArtifact(asm_cleaner);
    clean_asm.setStdIn(.{ .lazy_path = raw_asm });

    // Install cleaned assembly file
    if (options.enable_clean_asm_step) {
        const cleaned_asm_step = b.step(options.clean_asm_step_name, "Install cleaned assembly output");
        cleaned_asm_step.dependOn(&b.addInstallFileWithDir(
            clean_asm.captureStdOut(),
            options.install_dir,
            options.clean_asm_file_name,
        ).step);
    }

    // Install raw assembly output
    if (options.enable_raw_asm_step) {
        const raw_asm_step = b.step(options.raw_asm_step_name, "Install raw assembly output");
        raw_asm_step.dependOn(&b.addInstallFileWithDir(
            raw_asm,
            options.install_dir,
            options.raw_asm_file_name,
        ).step);
    }

    // Install llvm-mca analysis
    if (options.enable_mca_step) {
        // Clean assembly, but this time add .intel_syntax to the beginning so llvm-mca can recognize it
        const clean_asm_with_intel_directive = b.addRunArtifact(asm_cleaner);
        clean_asm_with_intel_directive.setStdIn(.{ .lazy_path = raw_asm });
        clean_asm_with_intel_directive.addArg("--intelsyntaxdirective");

        // Run llvm-mca analysis, while forward arguments to it
        const run_mca = b.addSystemCommand(&.{"llvm-mca"});
        run_mca.setStdIn(.{ .lazy_path = clean_asm_with_intel_directive.captureStdOut() });
        if (b.args) |args| {
            run_mca.addArgs(args);
        }

        const mca_analysis = run_mca.captureStdOut();
        const install_mca_analysis = b.addInstallFileWithDir(
            mca_analysis,
            options.install_dir,
            options.mca_file_name,
        );

        const mca_step = b.step(options.mca_step_name, "Install llvm-mca analysis");
        mca_step.dependOn(&install_mca_analysis.step);
    }
}
