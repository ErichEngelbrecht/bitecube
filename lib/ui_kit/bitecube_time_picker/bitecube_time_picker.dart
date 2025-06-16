import 'package:flutter/material.dart';

Future<TimeOfDay?> showBitecubeTimePicker({
  required BuildContext context,
  DateTime? initialDateTime,
}) {
  return showDialog<TimeOfDay>(
    context: context,
    builder: (context) => TimePickerDialog(
      initialTime: TimeOfDay.fromDateTime(initialDateTime ?? DateTime.now()),
    ),
  );
}
