const std = @import("std");
const localasm = @import("localasm");
const bench = @import("bench.zig");
const transpose = @import("transpose.zig");
const oracle = @import("oracle.zig");

pub const panic = localasm.labeled_panic;

comptime {
    localasm.referenceFunctions(.{ block_unroll_reduce_dependency_chain, block_unroll });
}

const run_length = 15;

pub fn main(init: std.process.Init) !void {
    if (true) {
        return transpose.main(init);
    }

    var data: [256][16]u16 align(64) = @splat(@splat(1));
    var out: [256][256]u8 align(64) = undefined;
    bench.compareBenchmark(
        init.io,
        block_unroll_dual_reduce_dependency_chain,
        .{ &data, &out },
        block_unroll_reduce_dependency_chain,
        .{ &data, &out },
        50_000,
        100,
        256 * 256,
    );

    // bench.benchmark(init.io, wide_vectors, .{ &data, &out }, 5_000_000, 256 * 256);
    // bench.benchmark(init.io, no_unroll, .{ &data, &out }, 5_000_000, 256 * 256);
    // bench.benchmark(init.io, block_unroll, .{ &data, &out }, 5_000_000, 256 * 256);
    // bench.benchmark(init.io, full_unroll_reduce_dependency_chain, .{ &data, &out }, 5_000_000, 256 * 256);
    // bench.benchmark(init.io, block_unroll_reduce_dependency_chain, .{ &data, &out }, 5_000_000, 256 * 256);
    // bench.benchmark(init.io, block_unroll_dual, .{ &data, &out }, 5_000_000, 256 * 256);
    // bench.benchmark(init.io, block_unroll_dual_reduce_dependency_chain, .{ &data, &out }, 5_000_000, 256 * 256);

}

test "sliding sum correctness" {
    const data: [256][16]u16 align(64) = oracle.makeDataPacked();

    var out0: [256][256]u8 align(64) = @splat(@splat(0));
    oracle.sum_oracle(&data, &out0);

    var out1: [256][256]u8 align(64) = @splat(@splat(0));
    wide_vectors(&data, &out1);
    try std.testing.expectEqual(out0, out1);

    out1 = @splat(@splat(0));
    no_unroll(&data, &out1);
    try std.testing.expectEqual(out0, out1);

    out1 = @splat(@splat(0));
    full_unroll_reduce_dependency_chain(&data, &out1);
    try std.testing.expectEqual(out0, out1);

    out1 = @splat(@splat(0));
    block_unroll(&data, &out1);
    try std.testing.expectEqual(out0, out1);

    out1 = @splat(@splat(0));
    block_unroll_reduce_dependency_chain(&data, &out1);
    try std.testing.expectEqual(out0, out1);

    out1 = @splat(@splat(0));
    block_unroll_dual(&data, &out1);
    try std.testing.expectEqualDeep(out0, out1);

    out1 = @splat(@splat(0));
    block_unroll_dual_reduce_dependency_chain(&data, &out1);
    try std.testing.expectEqual(out0, out1);
}

test {
    _ = transpose;
}

pub noinline fn wide_vectors(
    data: *align(64) const [256][16]u16,
    out: *align(64) [256][256]u8,
) void {
    var sum: @Vector(256, u8) = @splat(0);
    for (0..run_length) |x| {
        sum += @intFromBool(@as(@Vector(256, bool), @bitCast(data[x])));
    }
    for (0..256 - run_length) |x| {
        out[x] = sum;
        const new_row: @Vector(256, u8) = @intFromBool(@as(@Vector(256, bool), @bitCast(data[x + run_length])));
        const old_row: @Vector(256, u8) = @intFromBool(@as(@Vector(256, bool), @bitCast(data[x])));
        sum += new_row;
        sum -= old_row;
    }
    out[256 - run_length] = sum;
}

pub noinline fn no_unroll(
    data: *align(64) const [256][16]u16,
    out: *align(64) [256][256]u8,
) void {
    for (0..4) |z| {
        var sum: @Vector(64, u8) = @splat(0);
        var previous_rows: [run_length]@Vector(64, u8) = undefined;
        for (0..run_length) |x| {
            previous_rows[x] = @intFromBool(@as(@Vector(64, bool), @bitCast(data[x][z * 4 ..][0..4].*)));
            sum += previous_rows[x];
        }
        for (0..256 - run_length) |x| {
            out[x][z * 64 ..][0..64].* = sum;
            const row_to_overwrite = x % run_length;
            const new_row: @Vector(64, u8) = @intFromBool(@as(@Vector(64, bool), @bitCast(data[x + run_length][z * 4 ..][0..4].*)));
            sum += new_row;
            sum -= previous_rows[row_to_overwrite];
            previous_rows[row_to_overwrite] = new_row;
        }
        out[256 - run_length][z * 64 ..][0..64].* = sum;
    }
}

pub noinline fn full_unroll_reduce_dependency_chain(
    data: *align(64) const [256][16]u16,
    out: *align(64) [256][256]u8,
) void {
    for (0..4) |z| {
        var sum: @Vector(64, u8) = @splat(0);
        var previous_rows: [run_length]@Vector(64, u8) = undefined;
        for (0..run_length) |x| {
            previous_rows[x] = @intFromBool(@as(@Vector(64, bool), @bitCast(data[x][z * 4 ..][0..4].*)));
            sum += previous_rows[x];
        }
        inline for (0..256 - run_length) |x| {
            out[x][z * 64 ..][0..64].* = sum;
            const row_to_overwrite = x % run_length;
            const new_row: @Vector(64, u8) = @intFromBool(@as(@Vector(64, bool), @bitCast(data[x + run_length][z * 4 ..][0..4].*)));
            sum +%= (new_row -% previous_rows[row_to_overwrite]);
            previous_rows[row_to_overwrite] = new_row;
        }
        out[256 - run_length][z * 64 ..][0..64].* = sum;
    }
}

pub noinline fn block_unroll(
    data: *align(64) const [256][16]u16,
    out: *align(64) [256][256]u8,
) void {
    for (0..4) |z| {
        var sum: @Vector(64, u8) = @splat(0);
        var previous_rows: [run_length]@Vector(64, u8) = undefined;

        inline for (0..run_length) |i| {
            const row: @Vector(64, u8) =
                @intFromBool(@as(
                    @Vector(64, bool),
                    @bitCast(data[i][z * 4 ..][0..4].*),
                ));

            previous_rows[i] = row;
            sum +%= row;
        }

        for (0..(256 - run_length) / run_length) |block| {
            inline for (0..run_length) |i| {
                const x = block * run_length + i;

                out[x][z * 64 ..][0..64].* = sum;

                const new_row: @Vector(64, u8) = @intFromBool(@as(
                    @Vector(64, bool),
                    @bitCast(data[x + run_length][z * 4 ..][0..4].*),
                ));

                sum += new_row;
                sum -= previous_rows[i];
                previous_rows[i] = new_row;
            }
        }
        // do the remainder
        inline for ((256 - run_length) / run_length * run_length..256 - run_length, 0..) |x, i| {
            out[x][z * 64 ..][0..64].* = sum;

            const new_row: @Vector(64, u8) = @intFromBool(@as(
                @Vector(64, bool),
                @bitCast(data[x + run_length][z * 4 ..][0..4].*),
            ));

            sum += new_row;
            sum -= previous_rows[i];
            previous_rows[i] = new_row;
        }
        // do the last element
        out[256 - run_length][z * 64 ..][0..64].* = sum;
    }
}

pub noinline fn block_unroll_reduce_dependency_chain(
    data: *align(64) const [256][16]u16,
    out: *align(64) [256][256]u8,
) void {
    for (0..4) |z| {
        var sum: @Vector(64, u8) = @splat(0);
        var previous_rows: [run_length]@Vector(64, u8) = undefined;

        inline for (0..run_length) |i| {
            const row: @Vector(64, u8) =
                @intFromBool(@as(
                    @Vector(64, bool),
                    @bitCast(data[i][z * 4 ..][0..4].*),
                ));

            previous_rows[i] = row;
            sum +%= row;
        }

        for (0..(256 - run_length) / run_length) |block| {
            inline for (0..run_length) |i| {
                const x = block * run_length + i;

                out[x][z * 64 ..][0..64].* = sum;

                const new_row: @Vector(64, u8) = @intFromBool(@as(
                    @Vector(64, bool),
                    @bitCast(data[x + run_length][z * 4 ..][0..4].*),
                ));

                sum +%= new_row -% previous_rows[i];
                previous_rows[i] = new_row;
            }
        }
        // do the remainder
        inline for ((256 - run_length) / run_length * run_length..256 - run_length, 0..) |x, i| {
            out[x][z * 64 ..][0..64].* = sum;

            const new_row: @Vector(64, u8) = @intFromBool(@as(
                @Vector(64, bool),
                @bitCast(data[x + run_length][z * 4 ..][0..4].*),
            ));

            sum +%= new_row -% previous_rows[i];
            previous_rows[i] = new_row;
        }
        // do the last element
        out[256 - run_length][z * 64 ..][0..64].* = sum;
    }
}

pub noinline fn block_unroll_dual(
    data: *align(64) const [256][16]u16,
    out: *align(64) [256][256]u8,
) void {
    for (0..2) |z| {
        var sum0: @Vector(64, u8) = @splat(0);
        var sum1: @Vector(64, u8) = @splat(0);
        var previous_rows0: [run_length]@Vector(64, u8) = undefined;
        var previous_rows1: [run_length]@Vector(64, u8) = undefined;

        inline for (0..run_length) |i| {
            const row0: @Vector(64, u8) = @intFromBool(@as(
                @Vector(64, bool),
                @bitCast(data[i][z * 2 * 4 ..][0..4].*),
            ));
            previous_rows0[i] = row0;
            sum0 +%= row0;

            const row1: @Vector(64, u8) = @intFromBool(@as(
                @Vector(64, bool),
                @bitCast(data[i][z * 2 * 4 + 4 ..][0..4].*),
            ));
            previous_rows1[i] = row1;
            sum1 +%= row1;
        }

        for (0..(256 - run_length) / run_length) |block| {
            inline for (0..run_length) |i| {
                const x = block * run_length + i;

                out[x][z * 2 * 64 ..][0..64].* = sum0;
                const new_row0: @Vector(64, u8) = @intFromBool(@as(
                    @Vector(64, bool),
                    @bitCast(data[x + run_length][z * 2 * 4 ..][0..4].*),
                ));
                sum0 += new_row0;
                sum0 -= previous_rows0[i];
                previous_rows0[i] = new_row0;

                out[x][z * 2 * 64 + 64 ..][0..64].* = sum1;
                const new_row1: @Vector(64, u8) = @intFromBool(@as(
                    @Vector(64, bool),
                    @bitCast(data[x + run_length][z * 2 * 4 + 4 ..][0..4].*),
                ));
                sum1 += new_row1;
                sum1 -= previous_rows1[i];
                previous_rows1[i] = new_row1;
            }
        }
        // do the remainder
        inline for ((256 - run_length) / run_length * run_length..256 - run_length, 0..) |x, i| {
            out[x][z * 2 * 64 ..][0..64].* = sum0;
            const new_row0: @Vector(64, u8) = @intFromBool(@as(
                @Vector(64, bool),
                @bitCast(data[x + run_length][z * 2 * 4 ..][0..4].*),
            ));
            sum0 += new_row0;
            sum0 -= previous_rows0[i];
            previous_rows0[i] = new_row0;

            out[x][z * 2 * 64 + 64 ..][0..64].* = sum1;
            const new_row1: @Vector(64, u8) = @intFromBool(@as(
                @Vector(64, bool),
                @bitCast(data[x + run_length][z * 2 * 4 + 4 ..][0..4].*),
            ));
            sum1 += new_row1;
            sum1 -= previous_rows1[i];
            previous_rows1[i] = new_row1;
        }
        // do the last element
        out[256 - run_length][z * 2 * 64 ..][0..64].* = sum0;
        out[256 - run_length][z * 2 * 64 + 64 ..][0..64].* = sum1;
    }
}

pub noinline fn block_unroll_dual_reduce_dependency_chain(
    data: *align(64) const [256][16]u16,
    out: *align(64) [256][256]u8,
) void {
    for (0..2) |z| {
        var sum0: @Vector(64, u8) = @splat(0);
        var sum1: @Vector(64, u8) = @splat(0);
        var previous_rows0: [run_length]@Vector(64, u8) = undefined;
        var previous_rows1: [run_length]@Vector(64, u8) = undefined;

        inline for (0..run_length) |i| {
            const row0: @Vector(64, u8) = @intFromBool(@as(
                @Vector(64, bool),
                @bitCast(data[i][z * 2 * 4 ..][0..4].*),
            ));
            previous_rows0[i] = row0;
            sum0 +%= row0;

            const row1: @Vector(64, u8) = @intFromBool(@as(
                @Vector(64, bool),
                @bitCast(data[i][z * 2 * 4 + 4 ..][0..4].*),
            ));
            previous_rows1[i] = row1;
            sum1 +%= row1;
        }

        for (0..(256 - run_length) / run_length) |block| {
            inline for (0..run_length) |i| {
                const x = block * run_length + i;

                out[x][z * 2 * 64 ..][0..64].* = sum0;
                const new_row0: @Vector(64, u8) = @intFromBool(@as(
                    @Vector(64, bool),
                    @bitCast(data[x + run_length][z * 2 * 4 ..][0..4].*),
                ));
                sum0 +%= new_row0 -% previous_rows0[i];
                previous_rows0[i] = new_row0;

                out[x][z * 2 * 64 + 64 ..][0..64].* = sum1;
                const new_row1: @Vector(64, u8) = @intFromBool(@as(
                    @Vector(64, bool),
                    @bitCast(data[x + run_length][z * 2 * 4 + 4 ..][0..4].*),
                ));
                sum1 +%= new_row1 -% previous_rows1[i];
                previous_rows1[i] = new_row1;
            }
        }
        // do the remainder
        inline for ((256 - run_length) / run_length * run_length..256 - run_length, 0..) |x, i| {
            out[x][z * 2 * 64 ..][0..64].* = sum0;
            const new_row0: @Vector(64, u8) = @intFromBool(@as(
                @Vector(64, bool),
                @bitCast(data[x + run_length][z * 2 * 4 ..][0..4].*),
            ));
            sum0 +%= new_row0 -% previous_rows0[i];
            previous_rows0[i] = new_row0;

            out[x][z * 2 * 64 + 64 ..][0..64].* = sum1;
            const new_row1: @Vector(64, u8) = @intFromBool(@as(
                @Vector(64, bool),
                @bitCast(data[x + run_length][z * 2 * 4 + 4 ..][0..4].*),
            ));
            sum1 +%= new_row1 -% previous_rows1[i];
            previous_rows1[i] = new_row1;
        }
        // do the last element
        out[256 - run_length][z * 2 * 64 ..][0..64].* = sum0;
        out[256 - run_length][z * 2 * 64 + 64 ..][0..64].* = sum1;
    }
}
