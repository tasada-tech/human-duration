# human-duration

A small, dependency-free [MoonBit](https://www.moonbitlang.com/) library for parsing and formatting human-readable durations.

Turn strings like `1h30m`, `2d 4h`, or `500ms` into milliseconds, and turn milliseconds back into a compact readable form.

## Features

- **Parse** a duration string into total milliseconds (`Int32`).
- **Format** milliseconds into a compact human-readable string.
- Supports six units: `w` (week), `d` (day), `h` (hour), `m` (minute), `s` (second), `ms` (millisecond).
- Case-insensitive, allows spaces between components, and requires the entire input to be consumed — invalid input returns `None` rather than a partial result.
- Zero dependencies, Apache-2.0 licensed.

## Install

Add the module to your MoonBit project:

```sh
moon add farside_riveter/human_duration
```

## Usage

```moonbit nocheck
///|
fn main {
  // parse returns Option[Int32]: Some(milliseconds) or None
  let ms = @human_duration.parse("1h30m")   // Some(5_400_000)
  let bad = @human_duration.parse("1h30")   // None (missing unit)

  // format returns String
  let text = @human_duration.format(5_400_000) // "1h 30m"

  match ms {
    Some(v) => println(@human_duration.format(v))
    None => println("invalid duration")
  }
}
```

Run the bundled demo:

```sh
moon run cmd/main
```

Example output:

```text
1h30m -> 5400000 ms -> 1h 30m
2d 4h -> 183600000 ms -> 2d 4h
500ms -> 500 ms -> 500ms
1w -> 604800000 ms -> 1w
bad -> invalid
```

## API

### `parse(input : String) -> Int32?`

Parses the whole string as a sequence of `<number><unit>` parts and returns the total in milliseconds.

- Units: `w` = 604,800,000 ms, `d` = 86,400,000 ms, `h` = 3,600,000 ms, `m` = 60,000 ms, `s` = 1,000 ms, `ms` = 1 ms.
- Upper/lowercase and embedded spaces are accepted (`" 1H 15M "` is valid).
- Returns `None` for empty input, missing units, unknown units, or trailing garbage.

### `format(ms : Int32) -> String`

Formats milliseconds using the largest units first and omits zero components. `0` formats as `"0ms"`.

- `5_400_000` → `"1h 30m"`
- `90_061` → `"1m 30s 61ms"`
- `604_800_000` → `"1w"`

## Development

```sh
moon check    # type-check the module
moon test     # run the test suite
moon fmt      # format sources
moon build    # build the module
```

The repository includes a GitHub Actions workflow that runs `moon check` and `moon test` on pushes and pull requests.

## Project information

- Repository: <https://github.com/tasada-tech/human-duration>
- Module name: `farside_riveter/human_duration`
- Author: farside_riveter (月背铆钉师)
- License: Apache-2.0 — see [LICENSE](LICENSE).
