import 'package:ecommerce_app/core/theme/app_colors.dart';
import 'package:ecommerce_app/core/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
      appBarTheme: AppBarTheme(
        color: Colors.transparent,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: DeviceUtils.isTablet(context) ? 32 : 22,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.fillColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      cardTheme: CardThemeData(color: Colors.white),
      chipTheme: ChipThemeData(
        labelStyle: const TextStyle(color: Colors.black),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: Colors.grey,
        circularTrackColor: AppColors.scaffoldBackgroundColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.scaffoldBackgroundColor,
          elevation: 2,
          iconColor: Colors.black,
        ),
      ),
      textTheme: GoogleFonts.montserratTextTheme().copyWith(),
    );
  }
}
