import 'package:flutter/material.dart';
import 'package:magic_workout_app/core/styles/app_colors.dart';

final appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.lightGreen,
    primary: AppColors.lightGreen,
    secondary: AppColors.darkGreen,
    surface: AppColors.black,
    brightness: Brightness.dark,
  ),
);
