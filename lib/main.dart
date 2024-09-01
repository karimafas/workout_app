import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magic_workout_app/app/home/presentation/bloc/home_bloc.dart';
import 'package:magic_workout_app/core/router/app_router.dart';
import 'package:magic_workout_app/core/service_locator/service_locator.dart';
import 'package:magic_workout_app/core/styles/app_theme.dart';
import 'package:magic_workout_app/generated/locale_keys.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ServiceLocator.registerSingletons();

  const enLocale = Locale('en');

  runApp(
    EasyLocalization(
      supportedLocales: const [enLocale],
      path: 'assets/translations',
      fallbackLocale: enLocale,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => HomeBloc(),
      child: MaterialApp.router(
        title: LocaleKeys.core_title.tr(),
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}
