const std = @import("std");
const Decoder = @import("decoder.zig").Decoder;
const Encoder = @import("encoder.zig").Encoder;

pub fn debug(encdecoder: anytype) void {
    var text: [0x100]u8 = undefined;

    const out = switch (@TypeOf(encdecoder)) {
        Decoder => encdecoder.dump(&text),
        Encoder => encdecoder.print(&text),
        else => @compileError("encdecoder must be Decoder or Encoder"),
    };

    std.debug.print("{s}", .{out});
}
