import 'package:flutter/material.dart';

class BitecubeDropDownField extends StatelessWidget {
  const BitecubeDropDownField({
    required this.entries,
    required this.onSelected,
    super.key,
    this.initialSelection,
  });

  final List<DropdownMenuEntry<String>> entries;
  final ValueChanged<String?> onSelected;
  final String? initialSelection;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      dropdownMenuEntries: entries,
      onSelected: onSelected,
      expandedInsets: EdgeInsets.zero,
      initialSelection: initialSelection,
    );
  }
}
