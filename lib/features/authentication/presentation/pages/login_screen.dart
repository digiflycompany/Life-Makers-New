import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/core/widgets/custom_snack_bar.dart';
import 'package:life_makers/features/authentication/cubit/login_cubit/login_cubit.dart';
import 'package:life_makers/features/authentication/cubit/login_cubit/login_states.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/presentation/pages/enter_phone_screen.dart';
import 'package:life_makers/features/authentication/presentation/widgets/createAccountText.dart';
import 'package:life_makers/features/authentication/presentation/widgets/email_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_circular.dart';
import 'package:life_makers/features/authentication/presentation/widgets/password_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/small_text.dart';
import 'package:life_makers/features/home_page/presentation/pages/drawer_page.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../core/utils/app-assets.dart';
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
                          SizedBox(
                            height: 15.h,
                          ),
                          loginImage,
                          SizedBox(
                            height: 12.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 23.w),
                            child: Column(
                              children: [
                                welcomeBackText,
                                SizedBox(
                                  height: 22.h,
                                ),
                                loggingInText,
                                SizedBox(
                                  height: 16.h,
                                ),
                                emailTextField,
                                SizedBox(
                                  height: 23.h,
                                ),
                                PasswordTextField(
                                  controller: passwordController,
                                  hintText: AppStrings.password,
                                  obscureText: loginCubit.isPasswordVisible,
                                  prefixIcon: GestureDetector(
                                    onTap: () {
                                      loginCubit.togglePasswordVisibility();
                                    },
                                    child: loginCubit.isPasswordVisible
                                        ? Padding(
                                            padding: EdgeInsets.only(top: 3.h),
                                            child: Transform.scale(
                                                scale: 0.49,
                                                child: SvgPicture.asset(AppAssets.hideIcon)),
                                          )
                                        : Padding(
                                            padding: EdgeInsets.only(top: 3.h),
                                            child:Transform.scale(
                                                scale: 0.49,
                                                child: SvgPicture.asset(AppAssets.showIcon)),
                                          ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppStrings.pleaseEnterYourPassword;
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 6.w),
                                  child: Align(
                                    alignment: AlignmentDirectional.topEnd,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type: PageTransitionType.fade,
                                            duration: const Duration(
                                                milliseconds: 100),
                                            child: BlocProvider.value(
                                              value:
                                                  context.read<SignUpCubit>(),
                                              child: EnterPhoneScreen(),
                                            ),
                                          ),
                                        );
                                      },
                                      style: TextButton.styleFrom(
                                          splashFactory: NoSplash.splashFactory,
                                          padding: EdgeInsets.zero,
                                          minimumSize: Size(50, 30),
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          alignment: Alignment.centerLeft),
                                      child: Text(
                                        AppStrings.forgetPassword,
                                        style: TextStyle(
                                            color: AppColors.smallTextColor,
                                            fontFamily: FontFamilies.alexandria,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 11),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 22.h,
                                ),
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
                                SizedBox(
                                  height: 22.h,
                                ),
                                signUpText,
                                SizedBox(
                                  height: 10.h,
                                ),
                                visitorButton,
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5.h
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

  get loginImage => Align(
      alignment: AlignmentDirectional.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: SvgPicture.asset(AppAssets.logoFinalSvg),
      ));
  get welcomeBackText => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: SmallText(
        text: AppStrings.welcomeBack,
      ));
  get loggingInText => const Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Text(
          AppStrings.loggingIn,
          style: TextStyle(
              color: AppColors.blueColor,
              fontFamily: FontFamilies.alexandria,
              fontSize: 15),
        ),
      );
  get emailTextField => RegularTextField(
        max: 60,
        controller: usernameController,
        img: AppAssets.mailIcon,
        hintText: AppStrings.email,
        obscureText: false,
        validator: (value) {
          if (value!.isEmpty) {
            return AppStrings.pleaseEnterYourEmail;
          }
          return null;
        },
      );
  get forgetPasswordText => Padding(
        padding: EdgeInsets.only(right: 6.w),
        child: const Align(
          alignment: AlignmentDirectional.topEnd,
          child: Text(
            AppStrings.forgetPassword,
            style: TextStyle(
                color: AppColors.smallTextColor,
                fontFamily: FontFamilies.alexandria,
                fontWeight: FontWeight.w500,
                fontSize: 11),
          ),
        ),
      );
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
