import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../core/utils/app-color.dart';
import '../../../../core/utils/app-string.dart';
import '../../../../core/utils/app_fonts.dart';
import '../pages/login_screen.dart';

class loginToAccountText extends StatelessWidget {
  const loginToAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 400),
            child:  LoginScreen()));
      },
      child: const Text(
        AppStrings.loggingIn,
        style: TextStyle(
          decoration: TextDecoration.underline,
          color: AppColors.gradientColor1,
          fontFamily: FontFamilies.alexandria,
          fontWeight: FontWeight.w500,
          fontSize: 11,
        ),
      ),
    );
  }
}
