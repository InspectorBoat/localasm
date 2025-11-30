const std = @import("std");

const LineType = enum {
    empty,
    directive,
    label,
    instruction,
    @"export",
    dummy_export,
};

pub fn main() !void {
    var outbuf: [64]u8 = undefined;
    var inbuf: [64]u8 = undefined;
    var stdout = std.fs.File.stdout().writer(&outbuf);
    var stdin = std.fs.File.stdin().reader(&inbuf);

    var arena: std.heap.ArenaAllocator = .init(std.heap.page_allocator);
    const alloc = arena.allocator();

    var args = try std.process.argsWithAllocator(alloc);
    _ = args.next();

    const add_intel_directive = if (args.next()) |arg|
        std.mem.eql(u8, arg, "--intelsyntaxdirective")
    else
        false;

    var lines: std.ArrayListUnmanaged(struct { type: LineType, text: []const u8 }) = .empty;
    var used_labels: std.StringHashMapUnmanaged(void) = .empty;
    var eof = false;
    while (!eof) {
        var line: std.Io.Writer.Allocating = .init(alloc);
        defer line.deinit();

        _ = stdin.interface.streamDelimiter(&line.writer, '\n') catch |err| switch (err) {
            error.EndOfStream => eof = true,
            else => return err,
        };
        if (!eof) std.debug.assert(try stdin.interface.takeByte() == '\n');

        const line_text = line.written();
        const line_type = classifyLine(
            std.mem.trimLeft(u8, line_text, "\t"),
        );

        if (line_type == .instruction) {
            var search_index: usize = 0;
            while (std.mem.indexOfScalar(u8, line_text[search_index..], '.')) |index| {
                if (index == line_text.len - 1) break;

                const end_index = blk: for (line_text[index + 1 ..], index + 1..) |char, i| {
                    if (!std.ascii.isAlphanumeric(char) and char != '_') break :blk i - 1;
                } else line_text.len - 1;

                try used_labels.put(alloc, line_text[index .. end_index + 1], void{});
                search_index = end_index + 1;
                if (search_index >= end_index) break;
            }
        }
        try lines.append(alloc, .{ .type = line_type, .text = try line.toOwnedSlice() });
    }
    if (add_intel_directive) _ = try stdout.interface.writeAll(".intel_syntax noprefix\n");
    var in_used_label = false;
    var in_export = false;
    for (lines.items) |line| {
        switch (line.type) {
            .empty => {},
            .directive => {
                if ((in_used_label or in_export) and isValidDirective(line.text)) {
                    _ = try stdout.interface.writeAll(line.text);
                    _ = try stdout.interface.writeAll("\n");
                }
            },
            .label => {
                in_export = false;
                const stripped = std.mem.trimLeft(u8, line.text, "\t");
                if (used_labels.contains(stripped[0 .. stripped.len - 1])) {
                    _ = try stdout.interface.writeAll(line.text);
                    _ = try stdout.interface.writeAll("\n");

                    in_used_label = true;
                } else {
                    in_used_label = false;
                }
            },
            .instruction => {
                _ = try stdout.interface.writeAll(line.text);
                _ = try stdout.interface.writeAll("\n");
            },
            .@"export" => {
                in_export = true;

                _ = try stdout.interface.writeAll("\n");
                _ = try stdout.interface.writeAll(line.text);
                _ = try stdout.interface.writeAll("\n");
            },
            .dummy_export => {
                in_export = false;
            },
        }
    }
    _ = try stdout.interface.flush();
}

pub fn isValidDirective(line: []const u8) bool {
    // https://github.com/compiler-explorer/asm-parser/pull/46/commits/f504e3c7354506ee4fb120665f4491b014840d5d
    // /^\s*\.(string|asciz|ascii|base64|[1248]?byte|short|x?word|long|quad|value|zero)/
    const valid_directives: []const []const u8 = &.{
        ".string",
        ".asciz",
        ".ascii",
        ".base64",
        ".1byte",
        ".2byte",
        ".4byte",
        ".8byte",
        ".byte",
        ".short",
        ".xword",
        ".word",
        ".long",
        ".quad",
        ".value",
        ".zero",
    };
    const stripped = std.mem.trimLeft(u8, line, "\t");

    for (valid_directives) |valid_directive| {
        if (std.mem.startsWith(u8, stripped, valid_directive)) return true;
    } else return false;
}

pub fn classifyLine(line: []const u8) LineType {
    if (line.len == 0) return .empty;
    const first = line[0];
    const last = line[line.len - 1];
    if (last == ':')
        return .label
    else if (first == '.')
        return .directive
    else if (last == ':')
        if (std.mem.startsWith(u8, line, "\"export_helper_dummy#"))
            return .dummy_export
        else
            return .@"export"
    else
        return .instruction;
}

test classifyLine {
    try std.testing.expectEqual(.empty, classifyLine(""));

    try std.testing.expectEqual(.label, classifyLine(".foobar:"));

    try std.testing.expectEqual(.label, classifyLine("foobar:"));

    try std.testing.expectEqual(.label, classifyLine("\"quux\":"));

    try std.testing.expectEqual(.label, classifyLine("\"quux\":"));

    try std.testing.expectEqual(.instruction, classifyLine("mov r14, r13"));

    try std.testing.expectEqual(.empty, classifyLine("#APP"));
}
