const std = @import("std");
const c = @import("c.zig");
const constants = @import("constants.zig");

pub const State = extern struct {
    inner: c.xed_state_t,

    const Self = @This();

    pub fn create(arg_arg_mmode: c.xed_machine_mode_enum_t, arg_arg_stack_addr_width: c.xed_address_width_enum_t) Self {
        var self: Self = undefined;
        self.init2(arg_arg_mmode, arg_arg_stack_addr_width);
        return self;
    }

    pub fn init2(self: *Self, arg_arg_mmode: c.xed_machine_mode_enum_t, arg_arg_stack_addr_width: c.xed_address_width_enum_t) void {
        c.xed_state_init2(&self.inner, arg_arg_mmode, arg_arg_stack_addr_width);
    }

    pub fn zero(self: *Self) void {
        c.xed_state_zero(&self.inner);
    }

    pub fn getMachineMode(self: *const Self) c.xed_machine_mode_enum_t {
        return c.xed_state_get_machine_mode(&self.inner);
    }

    pub fn long64Mode(self: *const Self) bool {
        return c.xed_state_long64_mode(&self.inner) != 0;
    }

    pub fn realMode(self: *const Self) bool {
        return c.xed_state_real_mode(&self.inner) != 0;
    }

    pub fn modeWidth16(self: *const Self) bool {
        return c.xed_state_mode_width_16(&self.inner) != 0;
    }

    pub fn modeWidth32(self: *const Self) bool {
        return c.xed_state_mode_width_32(&self.inner) != 0;
    }

    pub fn setMachineMode(self: *Self, arg_arg_mode: c.xed_machine_mode_enum_t) void {
        c.xed_state_set_machine_mode(&self.inner, arg_arg_mode);
    }

    pub fn getAddressWidth(self: *const Self) c.xed_address_width_enum_t {
        return c.xed_state_get_address_width(&self.inner);
    }

    pub fn setStackAddressWidth(self: *Self, arg_arg_addr_width: c.xed_address_width_enum_t) void {
        c.xed_state_set_stack_address_width(&self.inner, arg_arg_addr_width);
    }

    pub fn getStackAddressWidth(self: *const Self) c.xed_address_width_enum_t {
        return c.xed_state_get_stack_address_width(&self.inner);
    }
};
