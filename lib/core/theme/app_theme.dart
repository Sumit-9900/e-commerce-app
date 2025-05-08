import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: Color.fromRGBO(255, 255, 255, 100),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(),
  );
}
