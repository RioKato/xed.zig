const std = @import("std");
pub const c = @import("c.zig");
pub usingnamespace @import("constants.zig");
pub const State = @import("state.zig").State;
pub const helper = @import("helper.zig");

pub fn init() void {
    c.xed_tables_init();
}

const Decoder = @import("decoder.zig").Decoder;
const Encoder = @import("encoder.zig").Encoder;

pub const Instruction = extern union {
    decoder: Decoder,
    encoder: Encoder,

    const Self = @This();

    const Options = struct {
        mode: enum { decoder, encoder },
        state: ?State = null,
    };

    pub fn create(options: Options) Self {
        var self: Self = undefined;

        switch (options.mode) {
            .decoder => {
                if (options.state) |state| {
                    self.decoder.zeroSetMode(state);
                } else {
                    self.decoder.zero();
                }
            },

            .encoder => {
                if (options.state) |state| {
                    self.encoder.zeroSetMode(state);
                } else {
                    self.encoder.zero();
                }
            },
        }

        return self;
    }
};

test "root" {
    try std.testing.expect(@sizeOf(Decoder) == @sizeOf(Encoder));
    std.testing.refAllDecls(Decoder);
    std.testing.refAllDecls(Encoder);
}
