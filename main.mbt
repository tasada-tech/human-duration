///|
/// Entry point demonstrating the human_duration library.
fn main {
  let samples = ["1h30m", "2d 4h", "500ms", "1w", "bad"]
  for sample in samples {
    match @human_duration.parse(sample) {
      Some(ms) =>
        println("\{sample} -> \{ms} ms -> \{@human_duration.format(ms)}")
      None => println("\{sample} -> invalid")
    }
  }
}
