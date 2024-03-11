import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/authentication/presentation/pages/login_screen.dart';
import 'package:life_makers/features/authentication/presentation/widgets/change_password_widgets/change_passsword_image.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../core/utils/app-color.dart';
import '../../../../core/utils/app-string.dart';
import '../../../../core/utils/app_fonts.dart';
import '../widgets/password_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is changePasswordLoading) {
            loading = true;
          } else if (state is changePasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('تم تغيير الرقم السري بنجاح'),
              duration: Duration(seconds: 2),
            ));
            Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  duration: const Duration(milliseconds: 400),
                  child: BlocProvider.value(
                    value: context.read<SignUpCubit>(),
                    child: LoginScreen(),
                  ),
                ));
          } else if (state is changePasswordFailure) {
          }
        },
        builder: (context, state) {
          final changePasswordCubit = context.read<SignUpCubit>();
          return Scaffold(
            backgroundColor: Colors.white,
            body: Form(
              key: _formKey,
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const ChangePasswordImage(),
                      createNewPassword,
                      SizedBox(
                          height: 52.h
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          children: [
                            PasswordTextField(
                              controller: passwordController,
                              hintText: AppStrings.password,
                              obscureText: changePasswordCubit
                                  .isPasswordVisible,
                              prefixIcon: GestureDetector(
                                onTap: () {
                                  changePasswordCubit
                                      .togglePasswordVisibility();
                                },
                                child: changePasswordCubit.isPasswordVisible
                                    ? Padding(
                                  padding: EdgeInsets.only(top: 3.h),
                                  child: Icon(
                                    Icons.remove_red_eye_outlined,
                                    size: 24.r,
                                    color: AppColors.prefixIconColor,
                                  ),
                                )
                                    : Padding(
                                  padding: EdgeInsets.only(top: 3.h),
                                  child: Icon(
                                    Icons.remove_red_eye,
                                    size: 24.r,
                                    color: AppColors.prefixIconColor,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'يرجى إدخال كلمة المرور';
                                }
                                if (value.length < 7) {
                                  return 'يجب أن تكون كلمة المرور على الأقل 7 أحرف';
                                }
                                if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
                                  return 'يجب أن تحتوي كلمة المرور على حرف أبجدي على الأقل';
                                }
                                if (!RegExp(r'\d').hasMatch(value)) {
                                  return 'يجب أن تحتوي كلمة المرور على رقم واحد على الأقل';
                                }
                                if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                                    .hasMatch(value)) {
                                  return 'يجب أن تحتوي كلمة المرور على حرف خاص واحد على الأقل';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 23.h,
                            ),
                            PasswordTextField(
                              controller: confirmPasswordController,
                              hintText: AppStrings.confirmPassword,
                              obscureText:
                              changePasswordCubit.isConfirmPasswordVisible,
                              prefixIcon: GestureDetector(
                                onTap: () {
                                  changePasswordCubit
                                      .toggleConfirmPasswordVisibility();
                                },
                                child:
                                changePasswordCubit.isConfirmPasswordVisible
                                    ? Padding(
                                  padding: EdgeInsets.only(top: 3.h),
                                  child: Icon(
                                    Icons.remove_red_eye_outlined,
                                    size: 24.r,
                                    color: AppColors.prefixIconColor,
                                  ),
                                )
                                    : Padding(
                                  padding: EdgeInsets.only(top: 3.h),
                                  child: Icon(
                                    Icons.remove_red_eye,
                                    size: 24.r,
                                    color: AppColors.prefixIconColor,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppStrings.pleaseConfirmPassword;
                                } else if (confirmPasswordController.text !=
                                    passwordController.text) {
                                  return 'الرقم السري غير مماثل للرقم السري في الأعلى';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                changePasswordCubit.ChangePassword(
                                    passwordController.text,
                                    confirmPasswordController.text);
                              }
                            },
                            child: Container(
                              width: 420.w,
                              height: 63.h,
                              decoration: BoxDecoration(
                                color: AppColors.orangeBorderColor,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Center(
                                child: loading == true
                                    ? Transform.scale(
                                  scale: 0.4,
                                  child: CircularProgressIndicator(
                                    color: AppColors.white,
                                  ),
                                )
                                    : Text(
                                  AppStrings.confirm,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontFamily: FontFamilies.alexandria,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  get createNewPassword =>
      Text(
        AppStrings.createNewPassowrd,
        textDirection: TextDirection.rtl,
        style: TextStyle(
            color: AppColors.gradientColor1,
            fontWeight: FontWeight.w500,
            fontFamily: FontFamilies.alexandria,
            fontSize: 13.5),
      );
}
