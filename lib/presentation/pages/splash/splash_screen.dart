// presentation/pages/splash/splash_screen.dart
import 'package:flutter/material.dart';

// You might want to add your logo or any other loading indicator
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // or your logo
      ),
    );
  }
}
