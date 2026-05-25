import 'package:flutter/material.dart';

class AppColors {
  // Dark mode colors - Deep & Premium
  static const Color darkPrimary = Color(0xFF020617); // Very deep navy
  static const Color darkSecondary = Color(0xFF0F172A);
  static const Color darkTextPrimary = Colors.white;
  static const Color darkTextSecondary = Color(0xFF94A3B8); // Slate gray
  static const Color darkAccent = Color(0xFF38BDF8); // Sky blue
  static const Color darkBorder = Color(0xFF1E293B);

  // Light mode colors - Clean & Airy
  static const Color lightPrimary = Color(0xFFF8FAFC); // Off-white
  static const Color lightSecondary = Colors.white;
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF475569);
  static const Color lightAccent = Color(0xFF6366F1); // Indigo
  static const Color lightBorder = Color(0xFFE2E8F0);

  // Shared Gradients
  static const Gradient accentGradient = LinearGradient(
    colors: [Color(0xFF38BDF8), Color(0xFF818CF8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

ThemeData getLightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.lightPrimary,
    scaffoldBackgroundColor: AppColors.lightPrimary,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.lightTextPrimary),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: AppColors.lightTextPrimary,
        fontSize: 20,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.lightTextPrimary),
      bodyMedium: TextStyle(color: AppColors.lightTextSecondary),
    ),
  );
}

ThemeData getDarkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.darkPrimary,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 20,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkTextPrimary),
      bodyMedium: TextStyle(color: AppColors.darkTextSecondary),
    ),
  );
}
