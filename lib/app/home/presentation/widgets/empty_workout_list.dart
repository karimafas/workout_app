import 'package:flutter/material.dart';
import 'package:magic_workout_app/core/extensions/build_context_extension.dart';

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
          "You haven't added any workouts yet...",
          style: context.textTheme.bodySmall,
        )
      ],
    );
  }
}
