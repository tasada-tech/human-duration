///|
/// Parse a human-readable duration such as `"1h30m"`, `"2d"` or `"500ms"`.
///
/// Supported units: `w` (week), `d` (day), `h` (hour), `m` (minute),
/// `s` (second), `ms` (millisecond). Spaces and uppercase letters are allowed.
/// Returns the total number of milliseconds, or `None` if the input is invalid.
pub fn parse(input : String) -> Int32? {
  let chars = input.to_lower().trim().to_array()
  let len = chars.length()
  let mut i = 0
  let mut total = 0
  let mut matched = false
  while i < len {
    while i < len && chars[i] == ' ' {
      i = i + 1
    }
    if i >= len {
      break
    }
    let mut number = 0
    let mut has_digit = false
    while i < len && chars[i].is_digit(10) {
      number = number * 10 + (chars[i].to_int() - '0'.to_int())
      has_digit = true
      i = i + 1
    }
    if !has_digit {
      return None
    }
    if i >= len {
      return None
    }
    let mut unit_ms = 0
    if chars[i] == 'm' && i + 1 < len && chars[i + 1] == 's' {
      unit_ms = 1
      i = i + 2
    } else if chars[i] == 's' {
      unit_ms = 1_000
      i = i + 1
    } else if chars[i] == 'm' {
      unit_ms = 60_000
      i = i + 1
    } else if chars[i] == 'h' {
      unit_ms = 3_600_000
      i = i + 1
    } else if chars[i] == 'd' {
      unit_ms = 86_400_000
      i = i + 1
    } else if chars[i] == 'w' {
      unit_ms = 604_800_000
      i = i + 1
    } else {
      return None
    }
    total = total + number * unit_ms
    matched = true
  }
  if matched {
    Some(total)
  } else {
    None
  }
}

///|
/// Format milliseconds as a compact human-readable duration.
///
/// The output uses the largest units first and omits zero components.
/// For example `5_400_000` becomes `"1h 30m"` and `90_061` becomes `"1m 30s 61ms"`.
pub fn format(ms : Int32) -> String {
  if ms == 0 {
    return "0ms"
  }
  let mut remaining = ms
  let units : Array[(String, Int32)] = [
    ("w", 604_800_000),
    ("d", 86_400_000),
    ("h", 3_600_000),
    ("m", 60_000),
    ("s", 1_000),
    ("ms", 1),
  ]
  let buf = StringBuilder()
  for unit in units {
    let (name, size) = unit
    let count = remaining / size
    if count > 0 {
      if buf.to_string().length() > 0 {
        buf <+ " "
      }
      buf <+ "\{count}\{name}"
      remaining = remaining % size
    }
  }
  buf.to_string()
}
