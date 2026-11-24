///|
test "parse single units" {
  assert_eq(@human_duration.parse("500ms"), Some(500))
  assert_eq(@human_duration.parse("2s"), Some(2_000))
  assert_eq(@human_duration.parse("3m"), Some(180_000))
  assert_eq(@human_duration.parse("4h"), Some(14_400_000))
  assert_eq(@human_duration.parse("2d"), Some(172_800_000))
  assert_eq(@human_duration.parse("1w"), Some(604_800_000))
}

///|
test "parse compound units" {
  assert_eq(@human_duration.parse("1h30m"), Some(5_400_000))
  assert_eq(@human_duration.parse("2d 3h 4m 5s 6ms"), Some(183_845_006))
  assert_eq(@human_duration.parse(" 1H 15M "), Some(4_500_000))
}

///|
test "parse invalid input" {
  assert_eq(@human_duration.parse(""), None)
  assert_eq(@human_duration.parse("abc"), None)
  assert_eq(@human_duration.parse("10"), None)
  assert_eq(@human_duration.parse("10x"), None)
  assert_eq(@human_duration.parse("1h30"), None)
}

///|
test "format durations" {
  assert_eq(@human_duration.format(0), "0ms")
  assert_eq(@human_duration.format(5_400_000), "1h 30m")
  assert_eq(@human_duration.format(90_061), "1m 30s 61ms")
  assert_eq(@human_duration.format(604_800_000), "1w")
  assert_eq(@human_duration.format(1_000), "1s")
}
