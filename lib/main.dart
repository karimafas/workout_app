import 'package:flutter/material.dart';
import 'package:magic_workout_app/core/router/app_router.dart';
import 'package:magic_workout_app/core/service_locator/service_locator.dart';
import 'package:magic_workout_app/core/styles/app_theme.dart';

Future<void> main() async {
  await ServiceLocator.registerSingletons();
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
