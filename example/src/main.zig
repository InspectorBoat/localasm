const std = @import("std");
const size = 176;
const mask_len = 17;

// If functions_to_analyze does not exist, all functions found will be analyzed instead
pub const functions_to_analyze = .{ square, fib };

// Since this function is not in functions_to_analyze, it will not be emitted into assembly
pub fn main() !void {
    std.debug.print("{}\n", .{square(100)});
}

pub fn square(n: i32) i32 {
    return n * n;
}

pub noinline fn fib(n: usize) usize {
    return switch (n) {
        0 => 0,
        1 => 1,
        else => fib(n - 2) + fib(n - 1),
    };
}
