const std = @import("std");

pub fn benchmark(
    io: std.Io,
    comptime function: anytype,
    args: anytype,
    iterations: usize,
    ops_per_iter: usize,
) void {
    if (iterations == 0) {
        std.debug.print("benchmark skipped: iterations is zero\n", .{});
        return;
    }

    inline for (args) |arg| {
        std.mem.doNotOptimizeAway(arg);
    }

    const start: std.Io.Clock.Timestamp = .now(io, .cpu_thread);

    for (0..iterations) |_| {
        std.mem.doNotOptimizeAway(@call(.never_inline, function, args));
        inline for (args) |arg| {
            std.mem.doNotOptimizeAway(arg);
        }
    }

    const elapsed_ns: i128 = start.untilNow(io).raw.nanoseconds;
    const elapsed_ns_u128: u128 =
        if (elapsed_ns > 0) @intCast(elapsed_ns) else 0;

    const total_ops: u128 =
        @as(u128, iterations) * @as(u128, ops_per_iter);

    const elapsed_seconds: f64 =
        @as(f64, @floatFromInt(elapsed_ns_u128)) / 1_000_000_000.0;

    const ns_per_op: f64 =
        if (total_ops != 0)
            @as(f64, @floatFromInt(elapsed_ns_u128)) /
                @as(f64, @floatFromInt(total_ops))
        else
            0.0;

    const ops_per_second: f64 =
        if (elapsed_seconds > 0.0)
            @as(f64, @floatFromInt(total_ops)) / elapsed_seconds
        else
            0.0;

    std.debug.print(
        \\benchmark results:
        \\  iterations:   {d}
        \\  ops/iter:     {d}
        \\  total ops:    {d}
        \\  total time:   {d} ns ({d:.6} s)
        \\  ns/op:        {d:.3}
        \\  ops/sec:      {d:.3}
        \\
    , .{
        iterations,
        ops_per_iter,
        total_ops,
        elapsed_ns_u128,
        elapsed_seconds,
        ns_per_op,
        ops_per_second,
    });
}

pub fn compareBenchmark(
    io: std.Io,
    f1: anytype,
    args1: anytype,
    f2: anytype,
    args2: anytype,
    batch_count: usize,
    batch_size: usize,
    ops_per_iter: usize,
) void {
    if (batch_count == 0 or batch_size == 0 or ops_per_iter == 0) {
        std.debug.print(
            "batch_count, batch_size, and ops_per_iter must be greater than zero\n",
            .{},
        );
        return;
    }

    const Statistics = struct {
        count: usize = 0,
        mean: f64 = 0.0,
        m2: f64 = 0.0,

        fn add(self: *@This(), value: f64) void {
            self.count += 1;

            const n: f64 = @floatFromInt(self.count);
            const delta = value - self.mean;

            self.mean += delta / n;
            self.m2 += delta * (value - self.mean);
        }

        fn standardError(self: @This()) f64 {
            if (self.count < 2) return 0.0;

            const n: f64 = @floatFromInt(self.count);
            const variance =
                self.m2 / @as(f64, @floatFromInt(self.count - 1));

            return @sqrt(variance / n);
        }

        fn confidenceHalfWidth95(self: @This()) f64 {
            return 1.96 * self.standardError();
        }
    };

    var f1_stats = Statistics{};
    var f2_stats = Statistics{};
    var difference_stats = Statistics{};

    for (0..batch_count) |batch| {
        var f1_ns: i96 = 0;
        var f2_ns: i96 = 0;

        // Alternate batch order.
        if ((batch & 1) == 0) {
            var start: std.Io.Clock.Timestamp = .now(io, .cpu_process);

            for (0..batch_size) |_| {
                @call(.auto, f1, args1);
            }

            f1_ns = start.untilNow(io).raw.toNanoseconds();

            start = .now(io, .cpu_process);

            for (0..batch_size) |_| {
                @call(.auto, f2, args2);
            }

            f2_ns = start.untilNow(io).raw.toNanoseconds();
        } else {
            var start: std.Io.Clock.Timestamp = .now(io, .cpu_process);

            for (0..batch_size) |_| {
                @call(.auto, f2, args2);
            }

            f2_ns = start.untilNow(io).raw.toNanoseconds();

            start = .now(io, .cpu_process);

            for (0..batch_size) |_| {
                @call(.auto, f1, args1);
            }

            f1_ns = start.untilNow(io).raw.toNanoseconds();
        }

        // One statistical sample per batch, normalized to one invocation.
        const batch_size_f64: f64 = @floatFromInt(batch_size);

        const f1_ns_per_iter =
            @as(f64, @floatFromInt(f1_ns)) / batch_size_f64;
        const f2_ns_per_iter =
            @as(f64, @floatFromInt(f2_ns)) / batch_size_f64;

        f1_stats.add(f1_ns_per_iter);
        f2_stats.add(f2_ns_per_iter);

        // Paired sample: positive means f1 took longer than f2.
        difference_stats.add(f1_ns_per_iter - f2_ns_per_iter);
    }

    // for (0..batch_count) |batch| {
    //     var f1_best_ns: i96 = std.math.maxInt(i96);
    //     var f2_best_ns: i96 = std.math.maxInt(i96);

    //     // Alternate which function's batch runs first.
    //     if ((batch & 1) == 0) {
    //         for (0..batch_size) |_| {
    //             const start: std.Io.Clock.Timestamp =
    //                 .now(io, .cpu_process);

    //             @call(.auto, f1, args1);

    //             const elapsed =
    //                 start.untilNow(io).raw.toNanoseconds();

    //             if (elapsed < f1_best_ns) {
    //                 f1_best_ns = elapsed;
    //             }
    //         }

    //         for (0..batch_size) |_| {
    //             const start: std.Io.Clock.Timestamp =
    //                 .now(io, .cpu_process);

    //             @call(.auto, f2, args2);

    //             const elapsed =
    //                 start.untilNow(io).raw.toNanoseconds();

    //             if (elapsed < f2_best_ns) {
    //                 f2_best_ns = elapsed;
    //             }
    //         }
    //     } else {
    //         for (0..batch_size) |_| {
    //             const start: std.Io.Clock.Timestamp =
    //                 .now(io, .cpu_process);

    //             @call(.auto, f2, args2);

    //             const elapsed =
    //                 start.untilNow(io).raw.toNanoseconds();

    //             if (elapsed < f2_best_ns) {
    //                 f2_best_ns = elapsed;
    //             }
    //         }

    //         for (0..batch_size) |_| {
    //             const start: std.Io.Clock.Timestamp =
    //                 .now(io, .cpu_process);

    //             @call(.auto, f1, args1);

    //             const elapsed =
    //                 start.untilNow(io).raw.toNanoseconds();

    //             if (elapsed < f1_best_ns) {
    //                 f1_best_ns = elapsed;
    //             }
    //         }
    //     }

    //     const f1_ns_per_iter: f64 = @floatFromInt(f1_best_ns);
    //     const f2_ns_per_iter: f64 = @floatFromInt(f2_best_ns);

    //     // One sample per batch.
    //     f1_stats.add(f1_ns_per_iter);
    //     f2_stats.add(f2_ns_per_iter);

    //     // Paired sample for comparing the two functions.
    //     difference_stats.add(f1_ns_per_iter - f2_ns_per_iter);
    // }

    const ops: f64 = @floatFromInt(ops_per_iter);
    const billion = 1_000_000_000.0;

    const f1_ns_iter_ci = f1_stats.confidenceHalfWidth95();
    const f2_ns_iter_ci = f2_stats.confidenceHalfWidth95();

    const f1_ops_per_sec = billion * ops / f1_stats.mean;
    const f2_ops_per_sec = billion * ops / f2_stats.mean;

    const f1_ns_per_op = f1_stats.mean / ops;
    const f2_ns_per_op = f2_stats.mean / ops;

    std.debug.print(
        \\Benchmark results
        \\  batches: {d}
        \\  calls per batch: {d}
        \\  operations per call: {d}
        \\
        \\f1:
        \\  ns/iteration:   {d:.3} +/- {d:.3}
        \\  operations/sec: {d:.3}
        \\  ns/operation:   {d:.3}
        \\
        \\f2:
        \\  ns/iteration:   {d:.3} +/- {d:.3}
        \\  operations/sec: {d:.3}
        \\  ns/operation:   {d:.3}
        \\
        \\Paired difference, f1 - f2: {d:.3} +/- {d:.3} ns/iteration
        \\
    , .{
        batch_count,
        batch_size,
        ops_per_iter,

        f1_stats.mean,
        f1_ns_iter_ci,
        f1_ops_per_sec,
        f1_ns_per_op,

        f2_stats.mean,
        f2_ns_iter_ci,
        f2_ops_per_sec,
        f2_ns_per_op,

        difference_stats.mean,
        difference_stats.confidenceHalfWidth95(),
    });

    if (f1_stats.mean < f2_stats.mean) {
        std.debug.print("f1 is faster based on the measured mean.\n", .{});
    } else if (f2_stats.mean < f1_stats.mean) {
        std.debug.print("f2 is faster based on the measured mean.\n", .{});
    } else {
        std.debug.print("Both functions have the same measured mean.\n", .{});
    }
}
