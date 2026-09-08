const width = 256;
const std = @import("std");
const bench = @import("bench.zig");
const oracle = @import("oracle.zig");

pub fn main(init: std.process.Init) !void {
    var data: [256][256]u8 align(64) = @splat(@splat(1));
    var out: [256][256]u8 align(64) = undefined;
    bench.compareBenchmark(
        init.io,
        transpose256x256Simd,
        .{ &data, &out },
        transpose256x256SimdUnroll,
        .{ &data, &out },
        5_000,
        10_000,
        256 * 256,
    );
    // bench.benchmark(
    //     init.io,
    //     transpose256x256,
    //     .{ &data, &out },
    //     100_000,
    //     256 * 256,
    // );
    // bench.benchmark(
    //     init.io,
    //     transpose256x256Simd,
    //     .{ &data, &out },
    //     500_000,
    //     256 * 256,
    // );
    // bench.benchmark(
    //     init.io,
    //     transpose256x256SimdUnroll,
    //     .{ &data, &out },
    //     500_000,
    //     256 * 256,
    // );
    // bench.benchmark(
    //     init.io,
    //     oracle.transpose_oracle,
    //     .{&data},
    //     100_000,
    //     256 * 256,
    // );
}
pub fn transpose256x256(
    src: *align(16) const [width][width]u8,
    dst: *align(16) [width][width]u8,
) void {
    const block_width = 16;
    for (0..width / block_width) |x| {
        for (0..width / block_width) |z| {
            transposeBlock16(src, dst, x * block_width, z * block_width);
        }
    }
}
pub fn transposeBlock16(
    src: *align(16) const [width][width]u8,
    dst: *align(16) [width][width]u8,
    row: usize,
    col: usize,
) void {
    for (row.., 0..16) |x, _| {
        for (col.., 0..16) |z, _| {
            dst[z][x] = src[x][z];
        }
    }
}

pub fn transpose256x256Simd(
    src: *align(16) const [width][width]u8,
    dst: *align(16) [width][width]u8,
) void {
    const block_width = 8;
    for (0..width / block_width) |x| {
        for (0..width / block_width) |z| {
            transposeBlock8Simd(src, dst, x * block_width, z * block_width);
        }
    }
}

pub fn transpose256x256SimdUnroll(
    src: *align(16) const [width][width]u8,
    dst: *align(16) [width][width]u8,
) void {
    const block_width = 8;
    for (0..width / block_width) |x| {
        inline for (0..width / block_width) |z| {
            transposeBlock8Simd(src, dst, x * block_width, z * block_width);
        }
    }
}

pub fn transposeBlock8Simd(
    src: *align(16) const [width][width]u8,
    dst: *align(16) [width][width]u8,
    row: usize,
    col: usize,
) void {
    var block: [8][8]u8 = undefined;
    for (row.., 0..8) |x, i| {
        block[i] = src[x][col..][0..8].*;
    }

    const block_vec: @Vector(64, u8) = @bitCast(block);
    const permute_mask: @Vector(64, u8) = .{
        0, 8,  16, 24, 32, 40, 48, 56,
        1, 9,  17, 25, 33, 41, 49, 57,
        2, 10, 18, 26, 34, 42, 50, 58,
        3, 11, 19, 27, 35, 43, 51, 59,
        4, 12, 20, 28, 36, 44, 52, 60,
        5, 13, 21, 29, 37, 45, 53, 61,
        6, 14, 22, 30, 38, 46, 54, 62,
        7, 15, 23, 31, 39, 47, 55, 63,
    };

    const block_transposed: [8][8]u8 = @bitCast(@shuffle(u8, block_vec, undefined, permute_mask));
    for (col.., 0..8) |x, i| {
        dst[x][row..][0..8].* = block_transposed[i];
    }
}

test "transpose correctness" {
    var correct_result: [256][256]u8 align(64) = oracle.makeData();
    oracle.transpose_oracle(&correct_result);

    const in0: [256][256]u8 align(64) = oracle.makeData();

    var out0: [256][256]u8 align(64) = @splat(@splat(0));
    transpose256x256(&in0, &out0);
    try std.testing.expectEqual(correct_result, out0);

    out0 = @splat(@splat(0));
    transpose256x256Simd(&in0, &out0);
    try std.testing.expectEqual(correct_result, out0);
}
