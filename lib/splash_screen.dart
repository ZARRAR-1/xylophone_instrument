// Splash Screen
import 'package:flutter/material.dart';
import 'package:xylophone_instrument/xylophone.dart';
import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => XylophoneApp()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 39, 94, 1),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Image.asset(
            'assets/logo/splash_icon.png',
          ),
        ),
      ),
    );
  }
}
