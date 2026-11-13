const std = @import("std");
const localasm = @import("localasm");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const mod = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
        .imports = &.{.{
            .name = "localasm",
            .module = b.dependency("localasm", .{}).module("localasm"),
        }},
    });

    const lib = b.addLibrary(.{
        .linkage = .dynamic,
        .name = "assembly_helper",
        .root_module = mod,
        .use_llvm = true,
    });

    const @"asm" = localasm.addAsm(
        b,
        lib,
        .bin,
        "asm.s",
    );
    b.step("asm", "Install assembly output").dependOn(&@"asm".step);

    const mca = localasm.addMca(
        b,
        lib,
        null,
        .bin,
        "mca.txt",
    );
    b.step("mca", "Install llvm-mca output").dependOn(&mca.step);

    const @"test" = b.addTest(.{ .root_module = mod });
    const run_test = b.addRunArtifact(@"test");
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_test.step);
}
