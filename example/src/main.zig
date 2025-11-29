const std = @import("std");
const localasm = @import("localasm");

comptime {
    localasm.referenceFunctions(.{ square, fib, @"memcpy@PLT" });
}
// Since this function is not in functions_to_analyze, it will not be emitted into assembly
// pub fn main() !void {
//     std.debug.print("{}\n", .{square(100)});
// }

pub const panic = localasm.labeled_panic;

pub fn square(n: i32) i32 {
    @setRuntimeSafety(true);
    return n * n;
}

pub fn @"memcpy@PLT"() void {}

pub noinline fn fib(n: usize) usize {
    return switch (n) {
        0 => 0,
        1 => 1,
        else => fib(n - 2) + fib(n - 1),
    };
}
