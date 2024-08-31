import 'package:flutter/widgets.dart';
import 'package:magic_workout_app/core/constants/style_constants.dart';
import 'package:magic_workout_app/core/extensions/build_context_extension.dart';
import 'package:magic_workout_app/core/widgets/screen_back_button.dart';

class ScreenWithTitle extends StatelessWidget {
  const ScreenWithTitle({
    required this.children,
    required this.title,
    this.showBackButton = false,
    super.key,
  });

  final List<Widget> children;
  final bool showBackButton;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: commonScreenPadding,
            child: Row(
              children: [
                if (showBackButton) const ScreenBackButton(),
                Text(
                  title,
                  style: context.textTheme.titleLarge,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }
}
