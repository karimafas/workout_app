import 'package:flutter/material.dart';
import 'package:magic_workout_app/core/extensions/build_context_extension.dart';
import 'package:magic_workout_app/core/widgets/app_floating_button.dart';

class SetCard extends StatelessWidget {
  const SetCard({
    required this.name,
    required this.repetitions,
    required this.weightInKg,
    required this.onDelete,
    super.key,
  });

  final String name;
  final int repetitions;
  final double weightInKg;
  final Function() onDelete;

  @override
  Widget build(BuildContext context) {
    final boldMedium = context.textTheme.bodyMedium!.copyWith(
      fontWeight: FontWeight.bold,
      color: context.colorScheme.surface,
    );
    final boldSmall = context.textTheme.bodySmall!.copyWith(
      fontWeight: FontWeight.bold,
      color: context.colorScheme.surface,
    );
    final small = context.textTheme.bodySmall!.copyWith(
      color: context.colorScheme.surface,
    );

    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: AppFloatingButton(
            icon: Icons.delete_rounded,
            color: context.colorScheme.secondary,
            size: 38,
          ),
        ),
      ),
      key: UniqueKey(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 60,
        decoration: BoxDecoration(
          color: context.colorScheme.tertiary,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: boldMedium,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RichText(
                  textAlign: TextAlign.end,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '$repetitions ',
                        style: boldSmall,
                      ),
                      TextSpan(
                        text: 'repetitions',
                        style: small,
                      ),
                    ],
                  ),
                ),
                RichText(
                  textAlign: TextAlign.end,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '$weightInKg',
                        style: boldSmall,
                      ),
                      TextSpan(
                        text: 'kg',
                        style: small,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
