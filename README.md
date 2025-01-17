# localasm

We have godbolt at home - a local assembly output viewer, integrated with the zig build system

# Installation and usage

localasm currently only supports 0.14.0-dev.

1\. Run `zig fetch` to add the localasm package to your `build.zig.zon` manifest:

```sh
zig fetch --save git+https://github.com/inspectorboat/localasm
```

2\. (Optional) Add a special declaration to the root file of the module you would like to analyze:

```zig
pub const functions_to_analyze = .{ square, fib };
```
If this declaration is not present, localasm will instead emit assembly for all functions in the root source file.

3\. Use localasm to add build steps in your `build.zig` script:

```zig
pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const module = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    localasm.addAssemblyOutput(b, module, .{ .target = target });
    
    // Optional: Analyze multiple modules
    const other_module = b.createModule(.{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
    });

    localasm.addAssemblyOutput(b, other_module, .{
        // Defaults to .ReleaseFast if left out
        .optimize = .ReleaseSafe,
        .target = b.graph.host,

        // Enable a step to output raw assembly without cleaning - extremely noisy, off by default
        .enable_raw_asm_step = true,
        // Renames the step - defaults to rawasm. Useful if you want to analyze multiple modules (hence multiple addAssemblyOutput calls)
        .raw_asm_step_name = "lib_rawasm",
        .raw_asm_file_name = "lib_rawasm.s",

        // Enable a step to output clean assembly - on by default
        .enable_clean_asm_step = true,
        .clean_asm_step_name = "lib_asm",
        .clean_asm_file_name = "lib_asm.s",

        // Enable a step that sends cleaned assembly to llvm-mca for analysis - on by default
        .enable_mca_step = true,
        .mca_step_name = "lib_mca",
        .mca_file_name = "lib_mca.txt",
    });
}
```

4\. Run `zig build asm` to get your assembly output:

```sh
cat zig-out\asm\asm.s

main.square:
	push	rbp
	mov	rbp, rsp
	mov	eax, ecx
	imul	eax, ecx
	pop	rbp
	ret
```

5\. (Optional) Run `zig build mca` to feed the assembly output into llvm-mca:

```sh
cat zig-out\asm\mca.txt

Iterations:        100
Instructions:      2900
Total Cycles:      3484
Total uOps:        4800

Dispatch Width:    6
uOps Per Cycle:    1.38
IPC:               0.83
Block RThroughput: 8.0
```

Any arguments passed to `zig build mca` will be forwarded to llvm-mca. For example, use `zig build mca -- --timeline` to enable a timeline view of program execution.

This step requires llvm-mca to be installed, which can be acquired at [releases.llvm.org](https://releases.llvm.org/).

# Why not just use godbolt?

- Due to zig's lazy analysis, getting non-`export` functions to get emitted is a pain - you have to use a hack like `const foo: *const anyopaque = @ptrCast(&function);`, which gets irritating to type every time. localasm does this for you automatically by wrapping the module you pass into `addAssemblyOutput`, and also filters out the dummy constants emitted.
- If any code is split into multiple files, has library dependencies, or is part of a larger project, getting it into godbolt can difficult. Integrating with the zig build system solves this.
- Running locally means you get to use your personal editor setup, which I personally find to be a large improvement to godbolt's rather cramped UI.

# Known limitations

- Currently, only x86 assembly cleanup is suppported. Compiler-explorer has a [repository](https://github.com/compiler-explorer/asm-parser/blob/main/setup.sh) that already handles assembly parsing, but it is written in C++. If anybody would feels inclined to port it to [allyourcodebase](https://github.com/allyourcodebase), please let me know and I will integrate it into this package.