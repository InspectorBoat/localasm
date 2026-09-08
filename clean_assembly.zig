const std = @import("std");

const LineType = enum {
    empty,
    directive,
    label,
    instruction,
    dummy_export,
    dummy_export_end,
    comment,
};

pub const std_options: std.Options = .{ .log_level = .err };

pub const Options = struct {
    add_intel_directive: bool = false,
    debug_line_types: bool = false,
    input: union(enum) { file: std.Io.File.Reader, stdin: std.Io.File.Reader },

    pub fn deinit(self: @This(), io: std.Io) void {
        switch (self.input) {
            .file => |reader| {
                reader.file.close(io);
            },
            else => {},
        }
    }

    pub fn inputHandle(self: *@This()) *std.Io.Reader {
        switch (self.input) {
            .file, .stdin => |*reader| return &reader.interface,
        }
    }
};

pub fn processArgs(io: std.Io, arena: std.mem.Allocator, args: std.process.Args, input_buf: []u8) !Options {
    var options: Options = .{ .input = undefined };
    var have_input = false;
    for ((try args.toSlice(arena))[1..]) |arg| {
        if (std.mem.eql(u8, arg, "--intelsyntaxdirective")) {
            options.add_intel_directive = true;
        } else if (std.mem.eql(u8, arg, "--debuglinetypes")) {
            options.debug_line_types = true;
        } else {
            if (have_input) return error.MultipleInputFiles;
            if (std.mem.eql(u8, arg, "-")) {
                options.input = .{ .stdin = std.Io.File.stdin().reader(io, input_buf) };
            } else {
                options.input = .{ .file = (try std.Io.Dir.cwd().openFile(io, arg, .{})).reader(io, input_buf) };
            }
            have_input = true;
        }
    }
    if (!have_input) options.input = .{ .stdin = std.Io.File.stdin().reader(io, input_buf) };
    return options;
}

pub fn readLeaky(alloc: std.mem.Allocator, input: *std.Io.Reader) ![]const []const u8 {
    const input_raw = try input.allocRemaining(alloc, .unlimited);
    var line_iterator = std.mem.splitScalar(u8, input_raw, '\n');
    var lines: std.ArrayList([]const u8) = .empty;
    while (line_iterator.next()) |line| {
        try lines.append(alloc, line);
    }
    return lines.items;
}

const LineAndType = struct {
    type: LineType,
    text: []const u8,
    pub fn trimmed(self: @This()) []const u8 {
        return std.mem.trim(u8, self.text, "\t ");
    }
};

/// TODO: make memory usage patterns not dogshit
pub fn main(init: std.process.Init) !void {
    var output_buffer: [64]u8 = undefined;
    var input_buffer: [64]u8 = undefined;

    var options = try processArgs(init.io, init.arena.allocator(), init.minimal.args, &input_buffer);
    defer options.deinit(init.io);

    const input = options.inputHandle();
    var output_writer = std.Io.File.stdout().writer(init.io, &output_buffer);
    const output = &output_writer.interface;

    var lines_and_types: std.ArrayList(LineAndType) = .empty;

    const lines = try readLeaky(init.arena.allocator(), input);

    // first, classify all lines as directive, label, instruction, empty, or dummy
    for (lines) |line| {
        const line_type = classifyLine(std.mem.trimStart(u8, line, "\t"));

        try lines_and_types.append(init.arena.allocator(), .{ .type = line_type, .text = line });
    }

    var exported_functions: std.StringHashMapUnmanaged(void) = .empty;
    try findExportedFunctions(lines_and_types.items, &exported_functions, init.arena.allocator());

    var used_labels: std.StringHashMapUnmanaged(void) = .empty;
    try findUsedLabels(lines_and_types.items, &exported_functions, &used_labels, init.arena.allocator());

    if (options.add_intel_directive) _ = try output.writeAll(".intel_syntax noprefix\n");
    // print constant directives following used labels;
    var in_used_label = false;
    for (lines_and_types.items) |line| {
        if (options.debug_line_types) {
            try output.writeAll(switch (line.type) {
                .directive => "drect",
                .dummy_export => "dummy",
                .dummy_export_end => "dummy",
                .empty => "empty",
                .instruction => "instr",
                .label => "label",
                .comment => "comment",
            });
            _ = try output.writeAll("\t");
            try output.writeAll(line.text);
            _ = try output.writeAll("\n");
            continue;
        }
        switch (line.type) {
            .label => {
                const stripped = std.mem.trimStart(u8, line.text, "\t");
                const is_used_label = used_labels.contains(stripped[0 .. stripped.len - 1]);
                const is_exported_function = exported_functions.contains(stripped[0 .. stripped.len - 1]);
                in_used_label = is_used_label;
                if (is_used_label or is_exported_function) {
                    _ = try output.writeAll(line.text);
                    _ = try output.writeAll("\n");
                }
            },
            .instruction => {
                _ = try output.writeAll(line.text);
                _ = try output.writeAll("\n");
            },
            .directive => {
                if (in_used_label and isValidDirective(line.text)) {
                    _ = try output.writeAll(line.text);
                    _ = try output.writeAll("\n");
                }
            },
            .empty, .dummy_export, .dummy_export_end, .comment => {},
        }
    }
    _ = try output.flush();
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
    const stripped = std.mem.trimStart(u8, line, "\t");

    for (valid_directives) |valid_directive| {
        if (std.mem.startsWith(u8, stripped, valid_directive)) return true;
    } else return false;
}

pub fn classifyLine(line: []const u8) LineType {
    if (line.len == 0) return .empty;
    const first = line[0];
    const last = line[line.len - 1];
    if (std.mem.eql(u8, line, ".quad\tassembly_helper.b74a082f27dda9192b2a26683f0031"))
        return .dummy_export
    else if (std.mem.startsWith(u8, line, "dummy_export = "))
        return .dummy_export_end
    else if (last == ':')
        return .label
    else if (first == '.')
        return .directive
    else if (first == '#')
        return .comment
    else
        return .instruction;
}

pub fn findExportedFunctions(lines: []const LineAndType, exported_functions: *std.StringHashMapUnmanaged(void), alloc: std.mem.Allocator) !void {
    var in_exports: bool = false;
    for (lines) |line| {
        if (in_exports) {
            if (std.mem.startsWith(u8, line.trimmed(), ".quad\t")) {
                try exported_functions.put(alloc, line.trimmed()[".quad\t".len..], {});
            } else return;
        }
        if (line.type == .dummy_export) in_exports = true;
    }
}

pub fn findUsedLabels(lines: []const LineAndType, exported_functions: *const std.StringHashMapUnmanaged(void), used_labels: *std.StringHashMapUnmanaged(void), alloc: std.mem.Allocator) !void {
    // find function lines
    var in_function = false;
    for (lines) |*line| {
        switch (line.type) {
            .label => if (exported_functions.contains(line.trimmed()[0 .. line.trimmed().len - 1])) {
                std.log.debug("start of function at {s}", .{line.text});
                std.debug.assert(!in_function);
                in_function = true;
            },
            .instruction => {
                if (in_function) {
                    var search_index: usize = 0;
                    while (std.mem.indexOfScalar(u8, line.text[search_index..], '.')) |index| {
                        if (index == line.text.len - 1) break;

                        const end_index = blk: for (line.text[index + 1 ..], index + 1..) |char, i| {
                            if (!std.ascii.isAlphanumeric(char) and char != '_') break :blk i - 1;
                        } else line.text.len - 1;

                        std.log.debug("uses label {s}", .{line.text[index .. end_index + 1]});
                        try used_labels.put(alloc, line.text[index .. end_index + 1], void{});

                        search_index = end_index + 1;
                        if (search_index >= end_index) break;
                    }
                }
            },
            .empty => {
                if (in_function) {
                    in_function = false;
                    std.log.debug("function end", .{});
                    std.log.warn("function ended before .cfi_endproc! did llvm output format change?", .{});
                }
            },
            .directive => {
                if (in_function and std.mem.eql(u8, line.trimmed(), ".cfi_endproc")) {
                    in_function = false;
                    std.log.debug("function end", .{});
                }
            },
            else => {},
        }
    }
}

test classifyLine {
    try std.testing.expectEqual(.empty, classifyLine(""));

    try std.testing.expectEqual(.label, classifyLine(".foobar:"));

    try std.testing.expectEqual(.label, classifyLine("foobar:"));

    try std.testing.expectEqual(.label, classifyLine("\"quux\":"));

    try std.testing.expectEqual(.label, classifyLine("\"quux\":"));

    try std.testing.expectEqual(.instruction, classifyLine("mov r14, r13"));

    try std.testing.expectEqual(.comment, classifyLine("#APP"));
}
