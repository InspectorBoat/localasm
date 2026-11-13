const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});

    const asm_cleaner = b.addExecutable(.{
        .name = "assembly_cleaner",
        .root_module = b.addModule("assembly_cleaner", .{
            .root_source_file = b.path("clean_assembly.zig"),
            .target = target,
            .optimize = .debug,
        }),
    });
    b.installArtifact(asm_cleaner);

    const test_asm_cleaner = b.addTest(.{
        .root_module = b.createModule(.{
            .root_source_file = b.path("clean_assembly.zig"),
            .target = target,
            .optimize = .debug,
        }),
    });

    _ = b.step("test", "Run unit tests")
        .dependOn(&b.addRunArtifact(test_asm_cleaner).step);

    _ = b.addModule("localasm", .{
        .root_source_file = b.path("assembly_helper.zig"),
    });
}

pub fn addAsm(
    b: *std.Build,
    compile: *std.Build.Step.Compile,
    install_dir: std.Build.InstallDir,
    dest_rel_path: []const u8,
) *std.Build.Step.InstallFile {
    const localasm = b.dependencyFromBuildZig(@This(), .{});

    if (!(compile.use_llvm orelse (compile.root_module.optimize != .debug))) {
        std.log.err("use_llvm should be enabled, as self-hosted backend cannot emit assembly", .{});
    }

    const cleaner = b.addRunArtifact(localasm.artifact("assembly_cleaner"));
    cleaner.setStdIn(.{ .lazy_path = compile.getEmittedAsm() });

    const cleaned = b.addInstallFileWithDir(
        cleaner.captureStdOut(.{}),
        install_dir,
        dest_rel_path,
    );

    return cleaned;
}

pub fn addMca(
    b: *std.Build,
    compile: *std.Build.Step.Compile,
    mca_command: ?[]const []const u8,
    install_dir: std.Build.InstallDir,
    dest_rel_path: []const u8,
) *std.Build.Step.InstallFile {
    const localasm = b.dependencyFromBuildZig(@This(), .{});

    if (!(compile.use_llvm orelse (compile.root_module.optimize != .debug))) {
        std.log.err("use_llvm should be enabled, as self-hosted backend cannot emit assembly", .{});
    }

    const cleaner = b.addRunArtifact(localasm.artifact("assembly_cleaner"));
    cleaner.addArg("--intelsyntaxdirective");
    cleaner.setStdIn(.{ .lazy_path = compile.getEmittedAsm() });

    const mca = b.addSystemCommand(mca_command orelse &.{"llvm-mca"});
    mca.setStdIn(.{ .lazy_path = cleaner.captureStdOut(.{}) });
    _ = mca.captureStdErr(.{});
    const analysis = b.addInstallFileWithDir(
        mca.captureStdOut(.{}),
        install_dir,
        dest_rel_path,
    );

    return analysis;
}
