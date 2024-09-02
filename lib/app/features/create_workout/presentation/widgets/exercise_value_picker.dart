import 'package:flutter/material.dart';
import 'package:magic_workout_app/core/widgets/app_floating_button.dart';

class ExerciseValuePicker extends StatelessWidget {
  const ExerciseValuePicker({
    required this.title,
    required this.onDecrease,
    required this.onIncrease,
    super.key,
  });

  final RichText title;
  final Function() onDecrease;
  final Function() onIncrease;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppFloatingButton(
            icon: Icons.remove_rounded,
            size: 40,
            onTap: onDecrease,
          ),
          title,
          AppFloatingButton(
            icon: Icons.add_rounded,
            size: 40,
            onTap: onIncrease,
          )
        ],
      ),
    );
  }
}
