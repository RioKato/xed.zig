# xed.zig

## install

```sh
zig fetch --save=xed git+https://github.com/RioKato/xed.zig.git
```

```zig
pub fn build(b: *std.Build) void {

    // ...

    const xed = b.dependency("xed", .{
        .target = target,
        .optimize = optimize,
    }).module("xed");

    exe_mod.addImport("xed", xed);

    // ...
}
```
