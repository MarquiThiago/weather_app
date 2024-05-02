import 'package:flutter/material.dart';

class BoxSpacer extends StatelessWidget {
  const BoxSpacer({
    this.size,
    super.key,
  });

  final double? size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size ?? 16.0, width: size ?? 16.0);
  }
}
