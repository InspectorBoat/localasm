const std = @import("std");
const localasm = @import("localasm");

pub const panic = localasm.labeled_panic;

comptime {
    localasm.referenceFunctions(.{ block_unroll_reduce_dependency_chain, block_unroll });
}

const run_length = 15;

/// reference implementation
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
