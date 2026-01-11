import 'package:apd110_sakshidali/core/constants/theme/app_theme.dart';
import 'package:apd110_sakshidali/features/auth/screens/welcom_Screen.dart';
import 'package:flutter/material.dart';

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
      home: const WelcomeScreen(),
    );
  }
}
