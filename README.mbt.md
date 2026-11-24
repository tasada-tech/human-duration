# farside_riveter/human_duration

A tiny MoonBit library that parses and formats human-readable durations.

```moonbit nocheck
///|
let ms = @human_duration.parse("1h30m") // Some(5_400_000)

///|
let text = @human_duration.format(5_400_000) // "1h 30m"
```

## Supported units

`w` week, `d` day, `h` hour, `m` minute, `s` second, `ms` millisecond.
Spaces and uppercase letters are allowed; input must consume completely.

## Development

```sh
moon check
moon test
moon fmt
```
