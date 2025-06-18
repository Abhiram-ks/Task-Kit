import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: AppPalette.blue,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppPalette.white,
    fontFamily: GoogleFonts.roboto().fontFamily,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppPalette.white,
      selectedItemColor: AppPalette.black,
      unselectedItemColor: const Color.fromARGB(255, 86, 86, 86),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPalette.blue,
     iconTheme: IconThemeData(color: Colors.black),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppPalette.black),
      bodyMedium: TextStyle(color: AppPalette.black),
      bodySmall: TextStyle(color: AppPalette.black),
    )
  );
}