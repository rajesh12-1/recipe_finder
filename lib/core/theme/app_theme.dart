import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Primary Warm Orange/Red
  static const Color primaryColor = Color(0xFFFF7043);
  static const Color secondaryColor = Color(0xFFFFAB91);
  static const Color scaffoldLight = Color(0xFFF5F5F5);
  static const Color scaffoldDark = Color(0xFF121212);
  
  static const Color cardLight = Colors.white;
  static const Color cardDark = Color(0xFF1E1E1E);

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldLight,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.light,
        surface: cardLight,
      ),
      textTheme: GoogleFonts.latoTextTheme(),
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        color: scaffoldLight,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
        titleTextStyle: GoogleFonts.playfairDisplay(
          color: Colors.black87,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.grey.shade200,
        selectedColor: primaryColor,
        secondarySelectedColor: primaryColor,
        labelStyle: TextStyle(color: Colors.black87),
        secondaryLabelStyle: TextStyle(color: Colors.white),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldDark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
        surface: cardDark,
      ),
      textTheme: GoogleFonts.latoTextTheme(ThemeData.dark().textTheme),
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        color: scaffoldDark,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white70),
        titleTextStyle: GoogleFonts.playfairDisplay(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.grey.shade800,
        selectedColor: primaryColor,
        secondarySelectedColor: primaryColor,
        labelStyle: TextStyle(color: Colors.white70),
        secondaryLabelStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
