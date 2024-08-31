import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  void showToast(String message) =>
      ScaffoldMessenger.of(this).showSnackBar(SnackBar(
          backgroundColor: colorScheme.surface,
          content: Text(
            message,
            style: textTheme.bodySmall,
          )));
}
