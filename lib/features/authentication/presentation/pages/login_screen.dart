import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/core/widgets/custom_snack_bar.dart';
import 'package:life_makers/core/widgets/spacer.dart';
import 'package:life_makers/features/authentication/cubit/login_cubit/login_cubit.dart';
import 'package:life_makers/features/authentication/cubit/login_cubit/login_states.dart';
import 'package:life_makers/features/authentication/presentation/widgets/createAccountText.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_circular.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_widgets/forget_password_text.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_widgets/login_email_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_widgets/logging_in_text.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_widgets/login_image.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_widgets/login_password_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_widgets/sign_in_as_visitor.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_widgets/sign_up_text.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_widgets/welcome_back_text.dart';
import 'package:life_makers/features/home_page/presentation/pages/drawer_page.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../core/utils/app-color.dart';
import '../../../../core/utils/app-string.dart';
import '../../../../core/utils/app_fonts.dart';
import '../widgets/auth_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginCubit loginCubit;


  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    loginCubit = context.read<LoginCubit>();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          LoginSuccessful(context, usernameController.text);
        } else if (state is LoginFailure) {
          CustomSnackBars.showErrorToast(title: state.error);
        }
      },
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child:Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          LoginImage(),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: context.width20),
                            child: Column(
                              children: [
                                WelcomeBackText(),
                                LoggingInText(),
                                LoginEmailTextField(),
                                VerticalSpace(context.height20),
                                LoginPasswordTextField(),
                                VerticalSpace(context.height4),
                                ForgetPasswordText(),
                                state is LoginLoading?LoginCircular():AuthButton(
                                  text: AppStrings.enter,
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      final username = usernameController.text;
                                      final password = passwordController.text;
                                      loginCubit.login(username, password);
                                    }
                                  },
                                ),
                                SignUpText(),
                                SignInAsVisitor(),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          );
        },
      ),
    );
  }

  void LoginSuccessful(BuildContext context, String username) async {
    PreferencesHelper.saveIsVisitor(isVisitor: false);
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 100),
            child: DrawerPage()),
            (vale) => false);

  }
  get donNotHaveAccountText => const Text(
        AppStrings.doNotHaveAccount,
        style: TextStyle(
            color: AppColors.smallTextColor,
            fontFamily: FontFamilies.alexandria,
            fontWeight: FontWeight.w500,
            fontSize: 11),
      );
  get signUpText => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        textDirection: TextDirection.rtl,
        children: [
          donNotHaveAccountText,
          SizedBox(
            width: 4.w,
          ),
          CreateAccountText(),
        ],
      );
  get visitorButton => InkWell(
    onTap: (){
      PreferencesHelper.saveIsVisitor(isVisitor: true);
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 100),
              child:  DrawerPage()),
              (value)=>true);
    },
    child: Text(AppStrings.enterAsVisitor, style: TextStyle(
        color: AppColors.black,
        fontFamily: FontFamilies.alexandria,
        fontWeight: FontWeight.w500,
        fontSize: 11),),
  );
}
