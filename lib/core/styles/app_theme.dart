import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magic_workout_app/core/styles/app_colors.dart';

const poppinsFont = GoogleFonts.poppins;
final appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.lightGreen,
    primary: AppColors.lightGreen,
    secondary: AppColors.darkGreen,
    surface: AppColors.black,
    tertiary: AppColors.white,
    brightness: Brightness.dark,
  ),
  textTheme: TextTheme(
    titleLarge: poppinsFont(
      fontWeight: FontWeight.bold,
      fontSize: 30,
      color: AppColors.white,
    ),
    bodyMedium: poppinsFont(
      fontSize: 18,
      color: AppColors.white,
    ),
    bodySmall: poppinsFont(
      fontSize: 14,
      color: AppColors.white,
    ),
  ),
);
