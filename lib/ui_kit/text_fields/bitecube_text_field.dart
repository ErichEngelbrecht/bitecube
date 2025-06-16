import 'package:bitecube/l10n/l10n.dart';
import 'package:flutter/material.dart';

class BitecubeTextField extends StatelessWidget {
  const BitecubeTextField({
    required this.onChanged,
    required this.label,
    super.key,
    this.controller,
    this.keyboardType,
    this.maxLength,
    this.onTap,
    this.readOnly = false,
    this.isOptional = false,
  });

  final ValueChanged<String> onChanged;
  final String label;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool isOptional;
  final bool readOnly;
  final VoidCallback? onTap;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (isOptional || (value != null && value.isNotEmpty)) {
          return null;
        }
        return '${context.l10n.please_enter} ${label.toLowerCase()}';
      },
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType,
      onChanged: onChanged,
      maxLength: maxLength,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text(label),
      ),
    );
  }
}
