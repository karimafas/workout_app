import 'package:flutter/material.dart';
import 'package:magic_workout_app/core/assets/app_image.dart';
import 'package:magic_workout_app/core/constants/date_format_constants.dart';
import 'package:magic_workout_app/core/extensions/build_context_extension.dart';
import 'package:magic_workout_app/core/widgets/app_floating_button.dart';

class WorkoutCard extends StatelessWidget {
  const WorkoutCard({
    required this.name,
    required this.numberOfSets,
    required this.averageWeight,
    required this.createdAt,
    required this.onDelete,
    super.key,
  });

  final String name;
  final int numberOfSets;
  final double averageWeight;
  final DateTime createdAt;
  final Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      background: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: AppFloatingButton(
            icon: Icons.delete_rounded,
            color: context.colorScheme.tertiary,
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: context.colorScheme.primary,
        ),
        height: 110,
        width: double.infinity,
        child: Row(
          children: [
            Image.asset(
              AppImage.deadlift.path,
              height: 35,
            ),
            const SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.surface,
                  ),
                ),
                const SizedBox(height: 3),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '$numberOfSets ',
                        style: context.textTheme.bodySmall!.copyWith(
                          color: context.colorScheme.surface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'sets • ',
                        style: context.textTheme.bodySmall!.copyWith(
                          color: context.colorScheme.surface,
                        ),
                      ),
                      TextSpan(
                        text: averageWeight.toStringAsFixed(0),
                        style: context.textTheme.bodySmall!.copyWith(
                          color: context.colorScheme.surface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'kg avg. weight',
                        style: context.textTheme.bodySmall!.copyWith(
                          color: context.colorScheme.surface,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Created on ${commonDateFormat.format(createdAt)}',
                  style: context.textTheme.bodySmall!.copyWith(
                    color: context.colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
