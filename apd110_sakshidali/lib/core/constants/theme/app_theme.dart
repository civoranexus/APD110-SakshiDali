import 'package:apd110_sakshidali/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      // Core colors
      scaffoldBackgroundColor: AppColors.background,

      // Color Scheme (Material 3 preferred)
      colorScheme: ColorScheme.light(
        primary: AppColors.primaryTeal,
        secondary: AppColors.tealDark,
        background: AppColors.background,
        surface: AppColors.surface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onBackground: AppColors.textDark,
        onSurface: AppColors.textDark,
        error: AppColors.alert,
      ),

      // Typography
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.textDark,
        ),
        bodyLarge: TextStyle(color: AppColors.textDark),
        bodyMedium: TextStyle(color: AppColors.textDark),
      ),

      // AppBar
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.navyCore,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      // Elevated Button
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.tealDark,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),

      
      // Bottom Navigation
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primaryTeal,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
