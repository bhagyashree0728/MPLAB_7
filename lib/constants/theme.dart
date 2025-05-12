import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Primary Colors
  static const Color primaryRed = Color(0xFFCB202D);
  static const Color secondaryRed = Color(0xFFE23744);
  static const Color lightRed = Color(0xFFFFE8E8);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF1C1C1C);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textTertiary = Color(0xFF999999);
  
  // Background Colors
  static const Color background = Color(0xFF1A1A1A);
  static const Color surface = Color(0xFFF5F5F5);
  static const Color surfaceDark = Color(0xFF2C2C2C);
  
  // Accent Colors
  static const Color accentGreen = Color(0xFF00BFA5);
  static const Color accentYellow = Color(0xFFFFB800);
  static const Color accentBlue = Color(0xFF2196F3);
  
  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFFC107);
  
  // Border Colors
  static const Color borderLight = Color(0xFFE0E0E0);
  static const Color borderDark = Color(0xFFBDBDBD);
  
  // Shadow Colors
  static const Color shadowColor = Color(0x1A000000);
  
  // Additional Colors
  static const Color goldenYellow = Color(0xFFFFB800);
  static const Color darkPurple = Color(0xFF1A237E);
  static const Color lightBlue = Color(0xFFE3F2FD);
  
  // Gradient Colors
  static const List<Color> primaryGradient = [
    primaryRed,
    secondaryRed,
  ];
  
  // Text Styles
  static const TextStyle headingText = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );
  
  static const TextStyle bodyText = TextStyle(
    fontSize: 14,
    color: textPrimary,
  );
  
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    color: textPrimary,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    color: textPrimary,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    color: textPrimary,
  );
  
  // Button Styles
  static final ButtonStyle primaryButton = ElevatedButton.styleFrom(
    backgroundColor: primaryRed,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
  
  static final ButtonStyle secondaryButton = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: primaryRed,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: const BorderSide(color: primaryRed),
    ),
  );
  
  // Input Decoration
  static InputDecoration inputDecoration({
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: textTertiary),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryRed),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  // Light theme
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryRed,
      colorScheme: ColorScheme.light(
        primary: primaryRed,
        secondary: secondaryRed,
        tertiary: lightRed,
      ),
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: primaryRed),
        displayMedium: TextStyle(color: primaryRed),
        displaySmall: TextStyle(color: primaryRed),
        headlineMedium: TextStyle(color: primaryRed),
        headlineSmall: TextStyle(color: primaryRed),
        titleLarge: TextStyle(color: primaryRed),
        titleMedium: TextStyle(color: primaryRed),
        titleSmall: TextStyle(color: primaryRed),
        bodyLarge: TextStyle(color: primaryRed),
        bodyMedium: TextStyle(color: primaryRed),
        bodySmall: TextStyle(color: primaryRed),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryRed),
        ),
      ),
    );
  }

  // Dark theme
  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: secondaryRed,
      colorScheme: ColorScheme.dark(
        primary: secondaryRed,
        secondary: lightRed,
        tertiary: primaryRed,
      ),
      scaffoldBackgroundColor: primaryRed,
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: Colors.white),
        displayMedium: TextStyle(color: Colors.white),
        displaySmall: TextStyle(color: Colors.white),
        headlineMedium: TextStyle(color: Colors.white),
        headlineSmall: TextStyle(color: Colors.white),
        titleLarge: TextStyle(color: Colors.white),
        titleMedium: TextStyle(color: Colors.white),
        titleSmall: TextStyle(color: Colors.white),
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
        bodySmall: TextStyle(color: Colors.white),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: secondaryRed),
        ),
      ),
    );
  }
} 