import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScreenBackButton extends StatelessWidget {
  const ScreenBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pop(),
      child: const Padding(
        padding: EdgeInsets.only(right: 15),
        child: Icon(
          Icons.arrow_back_rounded,
        ),
      ),
    );
  }
}
