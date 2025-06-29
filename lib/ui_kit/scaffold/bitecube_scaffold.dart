import 'package:flutter/material.dart';

class BitecubeScaffold extends StatelessWidget {
  const BitecubeScaffold({
    required this.title,
    required this.body,
    super.key,
    this.actions,
    this.leading,
    this.leadingWidth,
    this.footerButtons,
  });

  final String title;
  final Widget body;
  final List<Widget>? actions;
  final Widget? leading;
  final double? leadingWidth;
  final List<Widget>? footerButtons;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: leading,
        leadingWidth: leadingWidth,
        actions: actions,
        centerTitle: true,
        title: Text(title),
      ),
      persistentFooterButtons: footerButtons,
      body: Padding(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),
        child: body,
      ),
    );
  }
}
