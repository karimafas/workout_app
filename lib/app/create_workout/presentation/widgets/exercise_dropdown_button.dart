import 'package:flutter/material.dart';
import 'package:magic_workout_app/app/home/data/enums/exercise.dart';
import 'package:magic_workout_app/core/extensions/build_context_extension.dart';

class ExerciseDropdownButton extends StatelessWidget {
  const ExerciseDropdownButton({
    required this.onChanged,
    required this.selectedExercise,
    super.key,
  });

  final Function(Exercise?) onChanged;
  final Exercise selectedExercise;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: context.colorScheme.tertiary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            style: context.textTheme.bodyMedium!
                .copyWith(color: context.colorScheme.surface),
            items: Exercise.values
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e.label,
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: context.colorScheme.tertiary,
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: onChanged,
            value: selectedExercise,
            borderRadius: BorderRadius.circular(15),
            iconEnabledColor: context.colorScheme.surface,
            selectedItemBuilder: (BuildContext ctxt) {
              return Exercise.values
                  .map(
                    (e) => DropdownMenuItem(
                      value: selectedExercise,
                      child: Text(
                        selectedExercise.label,
                        style: TextStyle(
                          color: context.colorScheme.surface,
                        ),
                      ),
                    ),
                  )
                  .toList();
            },
          ),
        ),
      ),
    );
  }
}
