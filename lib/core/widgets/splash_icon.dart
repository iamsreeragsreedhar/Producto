import 'package:flutter/material.dart';

class SplashIcon extends StatelessWidget {
  const SplashIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 210,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        gradient: const LinearGradient(
          colors: [Color(0xFF9B5CF6), Color(0xFF4C1D95)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8B5CF6).withValues(alpha: 0.25),
            blurRadius: 35,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: const Stack(
        alignment: Alignment.center,
        children: [
        
          Positioned(
            bottom: 38,
            child: Icon(Icons.shopping_cart_outlined, color: Colors.white, size: 110),
          ),
        ],
      ),
    );
  }
}
