const std = @import("std");

pub const Panic = struct {
    pub noinline fn call(msg: []const u8, _: ?*std.builtin.StackTrace, _: ?usize) noreturn {
        asm volatile (""
            :
            : [msg] "r" (msg.ptr),
        );
        @trap();
    }

    pub fn sentinelMismatch(expected: anytype, found: @TypeOf(expected)) noreturn {
        _ = found;
        call("sentinel mismatch", null, null);
    }

    pub fn unwrapError(ert: ?*std.builtin.StackTrace, err: anyerror) noreturn {
        _ = ert;
        _ = &err;
        call("attempt to unwrap error", null, null);
    }

    pub fn outOfBounds(index: usize, len: usize) noreturn {
        _ = index;
        _ = len;
        call("index out of bounds", null, null);
    }

    pub fn startGreaterThanEnd(start: usize, end: usize) noreturn {
        _ = start;
        _ = end;
        call("start index is larger than end index", null, null);
    }

    pub fn inactiveUnionField(active: anytype, accessed: @TypeOf(active)) noreturn {
        _ = accessed;
        call("access of inactive union field", null, null);
    }
    pub const messages = std.debug.SimplePanic.messages;
};

comptime {
    const file = @import("main");
    if (@hasDecl(file, "functions_to_analyze")) {
        for (file.functions_to_analyze, 0..) |function, i| {
            const dummy: *const anyopaque = @ptrCast(&function);
            @export(&dummy, .{ .name = "export_helper_dummy#" ++ std.fmt.comptimePrint("{}", .{i}) });
        }
    } else {
        for (std.meta.declarations(file), 0..) |decl, i| {
            if (std.mem.eql(u8, decl.name, "main")) continue;
            const decl_type = @TypeOf(@field(file, decl.name));
            const type_info = @typeInfo(decl_type);
            if (type_info == .@"fn") {
                const dummy: *const anyopaque = @ptrCast(&@field(file, decl.name));
                @export(&dummy, .{ .name = "export_helper_dummy#" ++ std.fmt.comptimePrint("{}", .{i}) });
            }
        }
    }
}
