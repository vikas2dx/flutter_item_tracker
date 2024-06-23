import 'package:flutter/material.dart';

class SizeAwareWidget extends StatelessWidget {
  final Widget child;

  const SizeAwareWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final renderBox = context.findRenderObject() as RenderBox;
          final size = renderBox.size;
          final position = renderBox.localToGlobal(Offset.zero);
          debugPrint('Size: $size, Position: $position');
        });
        return child;
      },
    );
  }
}
