import 'package:flutter/material.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/features/authentication/presentation/widgets/small_text.dart';

class WelcomeBackText extends StatelessWidget {
  const WelcomeBackText({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: AlignmentDirectional.centerStart,
        child: SmallText(
          text: AppStrings.welcomeBack,
        ));
  }
}
