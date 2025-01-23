import 'package:Movie_App/view/loginpage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    //  animation controller and animation for loading...
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _navigateToHome();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 4), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Loginpage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo container
          Center(
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 184, 176, 176)
                        .withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 10,
                  ),
                ],
                image: const DecorationImage(
                  image: AssetImage("assets/images/logo.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 40,
          ),

          // Glowing loading text
          AnimatedBuilder(
            animation: _glowAnimation,
            builder: (context, child) {
              return Text(
                "Loading . . .",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(_glowAnimation.value - 1),
                  shadows: [
                    Shadow(
                      color: Colors.white,
                      blurRadius: _glowAnimation.value * 10,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
