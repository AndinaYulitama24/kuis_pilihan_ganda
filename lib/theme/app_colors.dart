import 'package:flutter/material.dart';

class AppColors {
  static const peach = Color(0xFFFFC8B8);
  static const peachDark = Color(0xFFF5A891);
  static const mint = Color(0xFFB8E0CC);
  static const cream = Color(0xFFFFF4E6);
  static const bg = Color(0xFFFFFBF6);
  static const textDark = Color(0xFF4A3F3A);
  static const textLight = Color(0xFF9C8E85);

  static ThemeData get theme {
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
}