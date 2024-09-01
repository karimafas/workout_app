import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/localization.dart';
import 'package:easy_localization/src/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_workout_app/main.dart';

const englishLocale = Locale('en');

class TestWidgetWrapper extends StatelessWidget {
  const TestWidgetWrapper({
    required this.widget,
    super.key,
  });

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: widget);
  }
}

Future<Widget> buildLocalisedWidget({required Widget child}) async {
  final content = await File('assets/translations/en.json').readAsString();
  final data = jsonDecode(content) as Map<String, dynamic>;
  Localization.load(
    englishLocale,
    translations: Translations(data),
  );

  return MaterialApp(home: child);
}

Future<void> pumpLocalisedApp(WidgetTester tester) async =>
    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [
          englishLocale,
        ],
        path: 'assets/translations',
        fallbackLocale: englishLocale,
        child: const MyApp(),
      ),
    );
