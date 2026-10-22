import 'package:flutter/material.dart';

class AppColors {
  static const peach = Color(0xFFFFC8B8);
  static const peachDark = Color(0xFFF5A891);
  static const cream = Color(0xFFFFF4E6);
  static const bg = Color(0xFFFFFBF6);
  static const textDark = Color(0xFF4A3F3A);
  static const textLight = Color(0xFF9C8E85);

  static const bgDark = Color(0xFF1E1B1A);
  static const cardDark = Color(0xFF2C2826);
  static const textLightDark = Color(0xFFE0D8D3);
  static const textMutedDark = Color(0xFF9C8E85);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: bg,
      colorScheme: ColorScheme.fromSeed(seedColor: peachDark),
      fontFamily: 'Poppins',
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: textDark),
        bodyMedium: TextStyle(color: textDark),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bgDark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: peachDark,
        brightness: Brightness.dark,
      ),
      fontFamily: 'Poppins',
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: textLightDark),
        bodyMedium: TextStyle(color: textLightDark),
      ),
    );
  }
}