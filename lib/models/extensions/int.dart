extension IntegerConverter on int {
  String? toTimeOfDay() {
    try {
      final dateTime = DateTime.fromMillisecondsSinceEpoch(this * 100);

      return '${dateTime.hour}:${dateTime.minute}';
    } on Exception catch (_) {
      return null;
    }
  }

  DateTime? toDateTime() {
    try {
      return DateTime.fromMillisecondsSinceEpoch(this * 100);
    } on Exception catch (_) {
      return null;
    }
  }
}
