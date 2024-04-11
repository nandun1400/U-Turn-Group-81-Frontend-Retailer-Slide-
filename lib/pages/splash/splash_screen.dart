import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';

import '../../global/global_settings.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.repeat(reverse: true);
    Timer(
      Duration(seconds: globalData.splashTime), // Adjust the duration of the splash screen as needed
          () => Navigator.pushReplacementNamed(context, '/login'),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C329D), // Background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120, // Adjust width as needed
              height: 120, // Adjust height as needed
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/splash/img.png'), // Image path
                  fit: BoxFit.cover, // Adjust as needed
                ),
                borderRadius: BorderRadius.circular(10.0), // Adjust as needed
              ),
            ),
            SizedBox(height: 24.0), // Gap between image and text
            Text(
              'U TURN',
              style: TextStyle(
                fontSize: 56.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 24.0), // Gap between text and paragraph
            Text(
              'Turning heads, turning journeys',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
