import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Color(0xfff9f9f9),
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xfff4f4f4),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    ),
    cardTheme: CardThemeData(color: Colors.white),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Colors.grey,
      circularTrackColor: Color(0xfff9f9f9),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xfff9f9f9),
        elevation: 2,
        iconColor: Colors.black,
      ),
    ),
    textTheme: GoogleFonts.montserratTextTheme().copyWith(),
  );
}
