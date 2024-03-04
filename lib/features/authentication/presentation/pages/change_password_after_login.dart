import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/edit_account/screens/edit_account_screen.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../core/utils/app-assets.dart';
import '../../../../core/utils/app-color.dart';
import '../../../../core/utils/app-string.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/widgets/custom_snack_bar.dart';
import '../widgets/password_text_field.dart';

class ChangePasswordAfterLoginScreen extends StatefulWidget {
  ChangePasswordAfterLoginScreen({super.key});

  @override
  State<ChangePasswordAfterLoginScreen> createState() => _ChangePasswordAfterLoginScreenState();
}

class _ChangePasswordAfterLoginScreenState extends State<ChangePasswordAfterLoginScreen> {
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  final TextEditingController oldPasswordController = TextEditingController();

  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController confirmNewPasswordController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    final changePasswordCubit = context.read<SignUpCubit>();
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is changePasswordAfterLoginLoading) {
          loading = true;
        } else if (state is changePasswordAfterLoginSuccess) {
          CustomSnackBars.showSuccessToast(title: AppStrings.passwordChangedSuccessfully,);
          Navigator.pushReplacement(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 530),
                child: EditAccountScreen(),
              ));
        } else if (state is changePasswordAfterLoginFailure) {
           CustomSnackBars.showErrorToast(title: state.error);
          loading =false;
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            key: _formKey,
            child: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Center(child: SvgPicture.asset(AppAssets.changePassword)),
                    SizedBox(
                        height: 35.h
                    ),
                    createNewPassword,
                    SizedBox(
                        height: 35.h
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          PasswordTextField(
                            controller: oldPasswordController,
                            hintText: AppStrings.oldPassword,
                            obscureText: changePasswordCubit.isPasswordVisible,
                            prefixIcon: GestureDetector(
                              onTap: () {
                                changePasswordCubit.togglePasswordVisibility();
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
                                return 'يرجى إدخال كلمة المرور القديمة';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 23.h,
                          ),
                          PasswordTextField(
                            controller: newPasswordController,
                            hintText: AppStrings.newPassword,
                            obscureText: changePasswordCubit.isPasswordVisible,
                            prefixIcon: GestureDetector(
                              onTap: () {
                                changePasswordCubit.togglePasswordVisibility();
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
                                return 'يرجى إدخال كلمة المرور الجديدة';
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
                            controller: confirmNewPasswordController,
                            hintText: AppStrings.confirmNewPassword,
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
                                return 'يرجى إدخال كلمة المرور مرة ثانية للتأكد منها';
                              } else if (newPasswordController.text !=
                                  confirmNewPasswordController.text) {
                                return 'الرقم السري غير مماثل للرقم السري في الأعلى';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35.h,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        child: GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              changePasswordCubit.ChangePasswordAfterLogin(
                                  oldPasswordController.text,
                                  newPasswordController.text,
                                  confirmNewPasswordController.text);
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
    );
  }

  get createNewPassword => Text(
    AppStrings.createNewPassowrd,
    textDirection: TextDirection.rtl,
    style: TextStyle(
        color: AppColors.gradientColor1,
        fontWeight: FontWeight.w500,
        fontFamily: FontFamilies.alexandria,
        fontSize: 13.5),
  );
}
