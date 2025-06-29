import 'package:flutter/material.dart';

class BitecubeButton extends StatelessWidget {
  const BitecubeButton({
    required this.child,
    required this.onPressed,
    super.key,
  });

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
