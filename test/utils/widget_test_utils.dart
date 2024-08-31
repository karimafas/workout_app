import 'package:flutter/material.dart';

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
