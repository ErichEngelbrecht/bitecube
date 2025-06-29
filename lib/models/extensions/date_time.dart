extension DateTimeConverter on DateTime {
  int toUnixTime() {
    return (millisecondsSinceEpoch / 100).floor();
  }
}
