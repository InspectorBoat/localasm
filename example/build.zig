const std = @import("std");
const localasm = @import("localasm");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe_mod = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
        .imports = &.{.{
            .name = "localasm",
            .module = b.dependency("localasm", .{}).module("localasm"),
        }},
    });

    const exe = b.addExecutable(.{
        .name = "example",
        .root_module = exe_mod,
    });

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);

    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    localasm.addAssemblyOutput(
        b,
        b.addLibrary(.{
            .linkage = .dynamic,
            .name = "assembly_helper",
            .root_module = exe_mod,
            .use_llvm = true,
        }),
        .{ .target = target, .enable_raw_asm_step = true },
    );
}
