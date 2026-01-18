import 'package:apd110_sakshidali/spashScreen.dart';
import 'package:flutter/material.dart';
import 'package:apd110_sakshidali/core/constants/theme/app_theme.dart';

void main() {
  runApp(const MarketReachApp());
}

class MarketReachApp extends StatelessWidget {
  const MarketReachApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MarketReach',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home:  SplashScreen(), // 👈 START FROM SPLASH
    );
  }
}
