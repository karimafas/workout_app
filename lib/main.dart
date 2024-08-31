import 'package:flutter/material.dart';
import 'package:magic_workout_app/core/router/app_router.dart';
import 'package:magic_workout_app/core/styles/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Workout App',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}
