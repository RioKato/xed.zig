const std = @import("std");

const Recipe = struct {
    units: []struct {
        file: []const u8,
        flags: []const []const u8,
    },
    includes: []const []const u8,
};

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const mod = b.addModule("xed", .{
        .root_source_file = b.path("src/root.zig"),
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });

    var gpa = std.heap.GeneralPurposeAllocator(.{}).init;
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    inline for (&.{ "c/", "compat/" }) |dir| {
        const file = @embedFile(dir ++ "recipe.json");
        const parsed = try std.json.parseFromSlice(Recipe, allocator, file, .{});
        defer parsed.deinit();

        const recipe = parsed.value;

        for (recipe.units) |unit| {
            const path = try std.mem.concat(allocator, u8, &.{ dir, unit.file });
            defer allocator.free(path);

            mod.addCSourceFile(.{
                .file = b.path(path),
                .flags = unit.flags,
            });
        }

        for (recipe.includes) |include| {
            const path = try std.mem.concat(allocator, u8, &.{ dir, include });
            defer allocator.free(path);

            mod.addIncludePath(b.path(path));
        }
    }

    const tests = b.addTest(.{
        .root_module = mod,
    });

    const run = b.addRunArtifact(tests);

    const step = b.step("test", "Run unit tests");
    step.dependOn(&run.step);
}
