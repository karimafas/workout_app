import 'package:flutter/material.dart';
import 'package:magic_workout_app/core/extensions/build_context_extension.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.title,
    required this.icon,
    required this.onTap,
    this.disabled = false,
    this.isLoading = false,
    super.key,
  });

  final String title;
  final IconData icon;
  final Function() onTap;
  final bool disabled;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isLoading || disabled ? 0.3 : 1,
      child: GestureDetector(
        onTap: isLoading || disabled ? null : onTap,
        child: Container(
          width: 220,
          height: 50,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: context.colorScheme.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: isLoading
              ? Align(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                        color: context.colorScheme.surface, strokeWidth: 2.5),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.surface,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      icon,
                      color: context.colorScheme.surface,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
