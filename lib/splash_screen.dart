import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/widgets/extension.dart';
import 'package:flutter_application_1/core/widgets/gradient_circles.dart';
import 'package:flutter_application_1/core/widgets/splash_icon.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _scaleAnimation = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      context.go('/home');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -120,
              left: -100,
              child: GradientCircle(
                size: 350,
                colors: const [Color(0xFFB794F6), Color(0xFFE9D5FF)],
              ),
            ),
            Positioned(
              bottom: -140,
              right: -100,
              child: GradientCircle(
                size: 350,
                colors: const [Color(0xFFD8B4FE), Color(0xFFF3E8FF)],
              ),
            ),

            Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const Spacer(flex: 3),
                    ScaleTransition(scale: _scaleAnimation, child: SplashIcon()),
                    30.height,
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Produc',
                            style: TextStyle(
                              color: Color(0xFF0F172A),
                              fontSize: 43,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextSpan(
                            text: 'to',
                            style: TextStyle(
                              color: Color(0xFF6D28D9),
                              fontSize: 43,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    20.height,
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: Text(
                        'Discover products, explore details '
                        'and shop smarter',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          height: 1.5,
                          color: Color(0xFF475569),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    20.height,

                    const SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(
                        strokeWidth: 4,
                        valueColor: AlwaysStoppedAnimation(Color(0xFF8B5CF6)),
                        backgroundColor: Color(0xFFE9D5FF),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(bottom: 20, left: 0, right: 0, child: _buildBottomIcons()),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomIcons() {
    const iconColor = Color(0xFFAD82EB);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        Icon(Icons.headphones_outlined, color: iconColor, size: 38),
        Icon(Icons.watch_outlined, color: iconColor, size: 38),
        Icon(Icons.camera_alt_outlined, color: iconColor, size: 38),
        Icon(Icons.shopping_bag_outlined, color: iconColor, size: 38),
      ],
    );
  }
}
