import 'package:flutter/material.dart';

class GradientCircle extends StatelessWidget {
  final double size;
  final List<Color> colors;

  const GradientCircle({super.key, required this.size, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
