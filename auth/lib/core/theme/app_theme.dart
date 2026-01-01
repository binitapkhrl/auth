import 'package:flutter/material.dart';

class AppTheme {
  // Your Brand Colors
  static const Color primaryGold = Color(0xFFE67E22);
  static const Color surfaceWhite = Colors.white;
  static const Color errorRed = Color(0xFFBA1A1A);
  static const Color backgroundColor = Colors.white;

  static ThemeData get lightTheme {
    // Shared border radius and base border for consistency
    final borderRadius = BorderRadius.circular(12);
    final baseBorder = OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: const BorderSide(color: Color(0xFFE67E22)),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGold,
        primary: primaryGold,
        onPrimary: Colors.white,
        error: errorRed,
        surface: surfaceWhite,
        onSurface: Colors.black87,
      ),
      fontFamily: 'Libadora',

      // Custom Text Styles
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
        bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
      ),

      // Input Decoration Theme (TextFields, Login Forms, etc.)
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),

        // Default fallback border
        border: baseBorder,

        // Normal enabled state (most common)
        enabledBorder: baseBorder,

        // Focused state - thicker gold border
        focusedBorder: baseBorder.copyWith(
          borderSide: const BorderSide(color: primaryGold, width: 2),
        ),

        // Error states
        errorBorder: baseBorder.copyWith(
          borderSide: const BorderSide(color: errorRed, width: 2),
        ),
        focusedErrorBorder: baseBorder.copyWith(
          borderSide: const BorderSide(color: errorRed, width: 2),
        ),

        // Text styles inside the input
        hintStyle: const TextStyle(color: Colors.grey),
        labelStyle: const TextStyle(color: primaryGold),
        errorStyle: const TextStyle(color: errorRed),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryGold,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            fontFamily: 'Libadora',
          ),
        ),
      ),

      // Scaffold Background
      scaffoldBackgroundColor: backgroundColor,
    );
  }
}