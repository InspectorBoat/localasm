const std = @import("std");

const b74a082f27dda9192b2a26683f0031: i32 = 0;

pub fn referenceFunctions(functions: anytype) void {
    var pointers: []const *const anyopaque = &.{@ptrCast(&b74a082f27dda9192b2a26683f0031)};
    for (functions, 0..) |function, i| {
        _ = i;
        const dummy: *const anyopaque = @ptrCast(&function);
        pointers = pointers ++ .{dummy};
    }
    const pointers_array = pointers[0..].*;
    @export(&pointers_array, .{
        .name = "dummy_export",
    });
}

/// similar to std.debug.no_panic, but marked noinline so the type of panic is still discernable
pub const labeled_panic = struct {
    pub fn call(msg: []const u8, _: ?usize) noreturn {
        asm volatile (""
            :
            : [msg] "r" (msg.ptr),
        );
        @trap();
    }

    pub noinline fn sentinelMismatch(_: anytype, _: anytype) noreturn {
        @branchHint(.cold);
        @trap();
    }

    pub noinline fn unwrapError(_: anyerror) noreturn {
        @branchHint(.cold);
        @trap();
    }

    pub noinline fn outOfBounds(_: usize, _: usize) noreturn {
        @branchHint(.cold);
        @trap();
    }

    pub noinline fn startGreaterThanEnd(_: usize, _: usize) noreturn {
        @branchHint(.cold);
        @trap();
    }

    pub noinline fn inactiveUnionField(_: anytype, _: anytype) noreturn {
        @branchHint(.cold);
        @trap();
    }

    pub noinline fn sliceCastLenRemainder(_: usize) noreturn {
        @branchHint(.cold);
        @trap();
    }

    pub noinline fn reachedUnreachable() noreturn {
        @branchHint(.cold);
        @trap();
    }

    pub noinline fn unwrapNull() noreturn {
        @branchHint(.cold);
        @trap();
    }

    pub noinline fn castToNull() noreturn {
        @branchHint(.cold);
        @trap();
    }

    pub noinline fn incorrectAlignment() noreturn {
        @branchHint(.cold);
        @trap();
    }

    pub noinline fn invalidErrorCode() noreturn {
        @branchHint(.cold);
        @trap();
    }

    pub noinline fn unexpectedErrorCode(_: anyerror) noreturn {
        @branchHint(.cold);
        @trap();
    }

    pub noinline fn integerOutOfBounds() noreturn {
        @branchHint(.cold);
        @trap();
    }

    pub noinline fn integerOverflow() noreturn {
        @branchHint(.cold);
        @trap();
    }

    pub noinline fn shlOverflow() noreturn {
        @branchHint(.cold);
        @trap();
    }

    pub noinline fn shrOverflow() noreturn {
        @branchHint(.cold);
        @trap();
    }

    pub noinline fn divideByZero() noreturn {
        @branchHint(.cold);
        @trap();
    }

    pub noinline fn exactDivisionRemainder() noreturn {
        @branchHint(.cold);
        @trap();
    }

    pub noinline fn integerPartOutOfBounds() noreturn {
        @branchHint(.cold);
        @trap();
    }

    pub noinline fn corruptSwitch() noreturn {
        @branchHint(.cold);
        @trap();
    }

    pub noinline fn shiftRhsTooBig() noreturn {
        @branchHint(.cold);
        @trap();
    }

    pub noinline fn invalidEnumValue() noreturn {
        @branchHint(.cold);
        @trap();
    }

    pub noinline fn forLenMismatch() noreturn {
        @branchHint(.cold);
        @trap();
    }

    pub noinline fn copyLenMismatch() noreturn {
        @branchHint(.cold);
        @trap();
    }

    pub noinline fn memcpyAlias() noreturn {
        @branchHint(.cold);
        @trap();
    }

    pub noinline fn noreturnReturned() noreturn {
        @branchHint(.cold);
        @trap();
    }

    pub noinline fn loadUninstantiableType() noreturn {
        @branchHint(.cold);
        @trap();
    }
};
