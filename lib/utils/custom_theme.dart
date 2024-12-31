import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get defaultTheme => ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFFCD068E),
          tertiary: const Color(0xFF000000).withValues(alpha: 0.12),
        ),
        scaffoldBackgroundColor: const Color(0xFF09073A),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.white,
            fontSize: 57,
          ),
          displayMedium: TextStyle(
            color: Colors.white,
            fontSize: 45,
          ),
          displaySmall: TextStyle(
            color: Colors.white,
            fontSize: 36,
          ),
          headlineLarge: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontFamily: "avenirLTStd",
            fontWeight: FontWeight.w800,
          ),
          headlineMedium: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontFamily: "avenirLTStd",
            fontWeight: FontWeight.w800,
          ),
          headlineSmall: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontFamily: "avenirLTStd",
            fontWeight: FontWeight.w800,
          ),
          labelLarge: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: "avenirLTStd",
          ),
          labelMedium: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: "avenirLTStd",
          ),
          labelSmall: TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontFamily: "avenirLTStd",
          ),
          bodyLarge: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: "AvenirNextLTPro",
          ),
          bodyMedium: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: "AvenirNextLTPro",
            fontWeight: FontWeight.w800,
          ),
          bodySmall: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: "AvenirNextLTPro",
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            backgroundColor: const WidgetStatePropertyAll(Color(0xFFCD068E)),
          ),
        ),
      );
}
