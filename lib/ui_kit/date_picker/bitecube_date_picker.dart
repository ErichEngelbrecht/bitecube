import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BitecubeDatePicker extends StatefulWidget {
  const BitecubeDatePicker({
    required this.selectedDate,
    required this.onChange,
    super.key,
  });

  final DateTime selectedDate;
  final ValueChanged<DateTime> onChange;

  @override
  State<BitecubeDatePicker> createState() => _BitecubeDatePickerState();
}

class _BitecubeDatePickerState extends State<BitecubeDatePicker> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        widget.onChange.call(
          (await showDatePicker(
                context: context,
                initialDate: widget.selectedDate,
                firstDate: DateTime.now().add(
                  const Duration(days: -365),
                ),
                lastDate: DateTime.now(),
              )) ??
              widget.selectedDate,
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(DateFormat('d MMM').format(widget.selectedDate)),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 30,
          ),
        ],
      ),
    );
  }
}
