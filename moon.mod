// Learn more about moon.mod configuration:
// https://docs.moonbitlang.com/en/latest/toolchain/moon/module.html
//
// To add a dependency, run this command in your terminal:
//   moon add moonbitlang/x
//
// Or manually declare it in `import`, for example:
// import {
//   "moonbitlang/x@0.4.6",
// }

name = "farside_riveter/human_duration"

version = "0.1.0"

readme = "README.mbt.md"

repository = "https://github.com/tasada-tech/human-duration"

license = "Apache-2.0"

keywords = [ "duration", "time", "parser" ]

preferred_target = "wasm"

description = "Parse and format human-readable durations (1h30m, 2d, 500ms) in MoonBit."
