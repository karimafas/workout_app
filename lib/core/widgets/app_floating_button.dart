import 'package:flutter/material.dart';
import 'package:magic_workout_app/core/extensions/build_context_extension.dart';

class AppFloatingButton extends StatelessWidget {
  const AppFloatingButton({
    required this.icon,
    this.onTap,
    super.key,
    this.size = 50,
    this.color,
  });

  final IconData icon;
  final Function()? onTap;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: color ?? context.colorScheme.primary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Icon(
            icon,
            color: context.colorScheme.surface,
          ),
        ),
      ),
    );
  }
}
