import 'package:flutter/material.dart';

class BitecubeSnackBar {
  BitecubeSnackBar(this.context, this.content);

  final BuildContext context;
  final String content;

  void show() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(content)),
    );
  }
}
