import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({required this.icon, this.onTap});
  final IconData icon;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    shape: const CircleBorder(),
    child: InkWell(
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: SizedBox(width: 42, height: 42, child: Icon(icon, size: 20)),
    ),
  );
}
