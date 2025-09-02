const std = @import("std");
const c = @import("c.zig");
const constants = @import("constants.zig");
const State = @import("state.zig").State;

pub const Encoder = extern struct {
    inner: c.xed_encoder_request_t,

    const Self = @This();

    pub fn encode(self: *Self, itext: []u8) constants.Error![]u8 {
        var olen: c_uint = undefined;
        const err = c.xed_encode(&self.inner, itext.ptr, @intCast(itext.len), &olen);

        if (constants.toError(err)) |e| {
            return e;
        }

        return itext[0..olen];
    }

    pub fn getIclass(self: *const Self) c.xed_iclass_enum_t {
        return c.xed_encoder_request_get_iclass(&self.inner);
    }

    pub fn setIclass(self: *Self, iclass: c.xed_iclass_enum_t) void {
        c.xed_encoder_request_set_iclass(&self.inner, iclass);
    }

    pub fn setEffectiveOperandWidth(self: *Self, width_bits: c_uint) void {
        c.xed_encoder_request_set_effective_operand_width(&self.inner, width_bits);
    }

    pub fn setEffectiveAddressSize(self: *Self, width_bits: c_uint) void {
        c.xed_encoder_request_set_effective_address_size(&self.inner, width_bits);
    }

    pub fn setReg(self: *Self, operand: c.xed_operand_enum_t, reg: c.xed_reg_enum_t) void {
        c.xed_encoder_request_set_reg(&self.inner, operand, reg);
    }

    pub fn setOperandOrder(self: *Self, operand_index: c_uint, name: c.xed_operand_enum_t) void {
        c.xed_encoder_request_set_operand_order(&self.inner, operand_index, name);
    }

    pub fn getOperandOrder(self: *Self, operand_index: c_uint) c.xed_operand_enum_t {
        return c.xed_encoder_request_get_operand_order(&self.inner, operand_index);
    }

    pub fn operandOrderEntries(self: *Self) c_uint {
        return c.xed_encoder_request_operand_order_entries(&self.inner);
    }

    pub fn setRelbr(self: *Self) void {
        c.xed_encoder_request_set_relbr(&self.inner);
    }

    pub fn setAbsbr(self: *Self) void {
        c.xed_encoder_request_set_absbr(&self.inner);
    }

    pub fn setBranchDisplacement(self: *Self, brdisp: i64, nbytes: c_uint) void {
        c.xed_encoder_request_set_branch_displacement(&self.inner, brdisp, nbytes);
    }

    pub fn setPtr(self: *Self) void {
        c.xed_encoder_request_set_ptr(&self.inner);
    }

    pub fn setUimm0(self: *Self, uimm: u64, nbytes: c_uint) void {
        c.xed_encoder_request_set_uimm0(&self.inner, uimm, nbytes);
    }

    pub fn setUimm0Bits(self: *Self, uimm: u64, nbits: c_uint) void {
        c.xed_encoder_request_set_uimm0_bits(&self.inner, uimm, nbits);
    }

    pub fn setUimm1(self: *Self, uimm: u8) void {
        c.xed_encoder_request_set_uimm1(&self.inner, uimm);
    }

    pub fn setSimm(self: *Self, simm: i32, nbytes: c_uint) void {
        c.xed_encoder_request_set_simm(&self.inner, simm, nbytes);
    }

    pub fn setMemoryDisplacement(self: *Self, memdisp: i64, nbytes: c_uint) void {
        c.xed_encoder_request_set_memory_displacement(&self.inner, memdisp, nbytes);
    }

    pub fn setAgen(self: *Self) void {
        c.xed_encoder_request_set_agen(&self.inner);
    }

    pub fn setMem0(self: *Self) void {
        c.xed_encoder_request_set_mem0(&self.inner);
    }

    pub fn setMem1(self: *Self) void {
        c.xed_encoder_request_set_mem1(&self.inner);
    }

    pub fn setMemoryOperandLength(self: *Self, nbytes: c_uint) void {
        c.xed_encoder_request_set_memory_operand_length(&self.inner, nbytes);
    }

    pub fn setSeg0(self: *Self, seg_reg: c.xed_reg_enum_t) void {
        c.xed_encoder_request_set_seg0(&self.inner, seg_reg);
    }

    pub fn setSeg1(self: *Self, seg_reg: c.xed_reg_enum_t) void {
        c.xed_encoder_request_set_seg1(&self.inner, seg_reg);
    }

    pub fn setBase0(self: *Self, base_reg: c.xed_reg_enum_t) void {
        c.xed_encoder_request_set_base0(&self.inner, base_reg);
    }

    pub fn setBase1(self: *Self, base_reg: c.xed_reg_enum_t) void {
        c.xed_encoder_request_set_base1(&self.inner, base_reg);
    }

    pub fn setIndex(self: *Self, index_reg: c.xed_reg_enum_t) void {
        c.xed_encoder_request_set_index(&self.inner, index_reg);
    }

    pub fn setScale(self: *Self, scale: c_uint) void {
        c.xed_encoder_request_set_scale(&self.inner, scale);
    }

    pub fn operandsConst(self: *const Self) *const c.xed_operand_values_t {
        return c.xed_encoder_request_operands_const(&self.inner);
    }

    pub fn operands(self: *Self) *c.xed_operand_values_t {
        return c.xed_encoder_request_operands(&self.inner);
    }

    pub fn zeroOperandOrder(self: *Self) void {
        c.xed_encoder_request_zero_operand_order(&self.inner);
    }

    pub fn zeroSetMode(self: *Self, dstate: State) void {
        c.xed_encoder_request_zero_set_mode(&self.inner, &dstate.inner);
    }

    pub fn zero(self: *Self) void {
        c.xed_encoder_request_zero(&self.inner);
    }

    pub fn print(self: *const Self, text: []u8) []u8 {
        c.xed_encode_request_print(&self.inner, text.ptr, @intCast(text.len));
        return std.mem.span(@as([*:0]u8, @ptrCast(text.ptr)));
    }
};

test "encoder" {
    std.testing.refAllDeclsRecursive(Encoder);
}
