const std = @import("std");

pub noinline fn sum_oracle(data: *align(64) const [256][16]u16, out: *align(64) [256][256]u8) void {
    for (0..256 - 15 + 1) |x| {
        for (0..256) |z| {
            var sum: u8 = 0;
            for (0..15) |j| {
                const row: [256]bool = @bitCast(data[x + j]);
                sum += @intFromBool(row[z]);
            }
            out[x][z] = sum;
        }
    }
}

pub noinline fn transpose_oracle(data: *align(64) [256][256]u8) void {
    for (0..256) |x| {
        for (x + 1..256) |z| {
            const tmp = data[x][z];
            data[x][z] = data[z][x];
            data[z][x] = tmp;
        }
    }
}

pub fn makeDataPacked() [256][16]u16 {
    var rand_impl: std.Random.Pcg = .init(0x51133);
    const rand: std.Random = rand_impl.random();
    var matrix: [256][16]u16 = undefined;

    for (&matrix) |*row| {
        for (row) |*value| {
            value.* = rand.int(u16);
        }
    }

    return matrix;
}

pub fn makeData() [256][256]u8 {
    var rand_impl: std.Random.Pcg = .init(0x51133);
    const rand: std.Random = rand_impl.random();
    var matrix: [256][256]u8 = undefined;

    for (&matrix) |*row| {
        for (row) |*value| {
            value.* = rand.int(u8);
        }
    }

    return matrix;
}
