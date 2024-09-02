import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:magic_workout_app/core/extensions/build_context_extension.dart';
import 'package:magic_workout_app/generated/locale_keys.g.dart';

class EmptyWorkoutList extends StatelessWidget {
  const EmptyWorkoutList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          Icons.sports_gymnastics_rounded,
          color: context.colorScheme.primary,
        ),
        const SizedBox(height: 15),
        Text(
          LocaleKeys.home_no_workouts_added.tr(),
          style: context.textTheme.bodySmall,
        )
      ],
    );
  }
}
