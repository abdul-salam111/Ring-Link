import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/colors.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColorLight,
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: AppColors.primaryColor),
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.dmSans(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineMedium: GoogleFonts.dmSans(
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineSmall: GoogleFonts.dmSans(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      bodyLarge: GoogleFonts.dmSans(
        fontSize: 18.0,
        color: Colors.black,
      ),
      bodyMedium: GoogleFonts.dmSans(
        fontSize: 16.0,
        color: Colors.black,
      ),
      bodySmall: GoogleFonts.dmSans(
        fontSize: 14.0,
        color: Colors.black,
      ),
      displayLarge: GoogleFonts.dmSans(
        fontSize: 12.0,
        color: Colors.black,
      ),
      displayMedium: GoogleFonts.dmSans(
        fontSize: 10.0,
        color: Colors.black,
      ),
      displaySmall: GoogleFonts.dmSans(
        fontSize: 8.0,
        color: Colors.black,
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    appBarTheme:
        AppBarTheme(backgroundColor: AppColors.scaffoldBackgroundColorDark),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: AppColors.primaryColor),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColorDark,
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.dmSans(
          fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
      headlineMedium: GoogleFonts.dmSans(
          fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white),
      headlineSmall: GoogleFonts.dmSans(
          fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
      bodyLarge: GoogleFonts.dmSans(fontSize: 18.0, color: Colors.white70),
      bodyMedium: GoogleFonts.dmSans(fontSize: 16.0, color: Colors.white70),
      bodySmall: GoogleFonts.dmSans(fontSize: 14.0, color: Colors.white70),
      displayLarge: GoogleFonts.dmSans(fontSize: 12.0, color: Colors.white70),
      displayMedium: GoogleFonts.dmSans(fontSize: 10.0, color: Colors.white70),
      displaySmall: GoogleFonts.dmSans(fontSize: 8.0, color: Colors.white70),
    ),
  );
}
