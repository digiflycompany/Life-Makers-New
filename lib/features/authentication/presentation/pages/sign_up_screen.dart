import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/core/widgets/custom_snack_bar.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/authentication/presentation/widgets/auth_button.dart';
import 'package:life_makers/features/authentication/presentation/widgets/email_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/login_to_account_text.dart';
import 'package:life_makers/features/authentication/presentation/widgets/password_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/username_text_feild.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../core/utils/app-assets.dart';
import '../../../../core/utils/app-color.dart';
import '../../../../core/utils/app-string.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../home_page/presentation/pages/drawer_page.dart';
import '../../data/models/area_model.dart';
import '../../data/models/city_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // final _formKey = GlobalKey<FormState>();
  String? selectedCityName;
  String? selectedAreaName;
  late SignUpCubit signUpCubit;
  final TextEditingController controller = TextEditingController();
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController textEditingController2 = TextEditingController();

  final TextEditingController cityDropdownController = TextEditingController();

  final TextEditingController areaDropdownController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController whatsappController = TextEditingController();

  final TextEditingController idNumberController = TextEditingController();

  final TextEditingController workController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController previousExperienceController =
      TextEditingController();

  bool isConfirmed = false;

  bool otpSent = false;

  bool resend = false;

  @override
  void initState() {
    super.initState();
    signUpCubit = context.read<SignUpCubit>();
    signUpCubit.fetchCityData();
    // if(Platform.isAndroid)
    //   FirebaseCustomNotification.setUpFirebase();
   }

  @override
  Widget build(BuildContext context) {
    void _handleSignUp() {
      signUpCubit.SignUp(
        nameController.text,
        usernameController.text,
        passwordController.text,
        emailController.text,
        phoneController.text,
        whatsappController.text,
        idNumberController.text,
        workController.text,
        addressController.text,
        cityDropdownController.text,
        areaDropdownController.text,
        previousExperienceController.text,
      );
    }

    return BlocConsumer<SignUpCubit, SignUpState>(listener: (context, state) {
      if (state is SignUpSuccess) {
        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 400),
                child: DrawerPage()));
      } else if (state is OtpSendSuccess) {
        otpSent = true;
      } else if (state is OtpSubmitSuccess) {
        isConfirmed = true;
      } else if (state is OtpResend) {
        resend = true;
      } else if (state is OtpResendCycleState) {
        otpSent = false;
        phoneController.clear();
      }
    }, builder: (context, state) {
      return Scaffold(
          body: Form(
        // key: _formKey,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 23.w),
            child: Column(
              children: [
                logoImg,
                signingUpText,
                SizedBox(
                  height: 15.h,
                ),
                signIn,
                SizedBox(
                  height: 16.h,
                ),
                nameTextField,
                SizedBox(
                  height: 23.h,
                ),
                userNameTextField,
                SizedBox(
                  height: 23.h,
                ),
                PasswordTextField(
                  controller: passwordController,
                  hintText: AppStrings.password,
                  obscureText: signUpCubit.isPasswordVisible,
                  prefixIcon: GestureDetector(
                    onTap: () {
                      signUpCubit.togglePasswordVisibility();
                    },
                    child: signUpCubit.isPasswordVisible
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
                    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
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
                  obscureText: signUpCubit.isConfirmPasswordVisible,
                  prefixIcon: GestureDetector(
                    onTap: () {
                      signUpCubit.toggleConfirmPasswordVisibility();
                    },
                    child: signUpCubit.isConfirmPasswordVisible
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
                      return AppStrings.pleaseConfirmPassword;
                    } else if (confirmPasswordController.text !=
                        passwordController.text) {
                      return 'الرقم السري غير مماثل للرقم السري في الأعلى';
                    }

                    return null;
                  },
                ),
                SizedBox(
                  height: 23.h,
                ),
                emailTextField,
                SizedBox(
                  height: 23.h,
                ),
                whatsAppTextField,
                SizedBox(
                  height: 23.h,
                ),
                idTextField,
                SizedBox(
                  height: 23.h,
                ),
                workTextField,
                SizedBox(
                  height: 23.h,
                ),
                locationTextField,
                SizedBox(
                  height: 23.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 14.h),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.black26),
                        ),
                        child: Center(
                          child: DropdownButton2<String>(
                            underline: const SizedBox.shrink(),
                            alignment: Alignment.centerRight,
                            items: signUpCubit.areasList
                                .map((Areas area) => DropdownMenuItem<String>(
                                      value: area.name ??
                                          "", // Assuming city.name is a String
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          area.name ?? "",
                                          textDirection: TextDirection.rtl,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontFamily: 'Alexandria'),
                                        ),
                                      ),
                                    ))
                                .toSet()
                                .toList(),
                            onChanged: (String? areaName) {
                              // Update the selected city name
                              selectedAreaName = areaName;

                              // Find the corresponding city object based on the selected city name
                              final selectedArea =
                                  signUpCubit.areasList.firstWhere(
                                (area) => area.name == areaName,
                                orElse: () => signUpCubit.areasList
                                    .first, // Default to the first city
                              );

                              // Update your state or perform actions with the selected city
                              areaDropdownController.text =
                                  selectedArea.name ?? "";
                              signUpCubit.fetchAreaData();
                            },
                            isExpanded: true,
                            hint: Text(
                              selectedAreaName ?? 'المركز',
                              style: TextStyle(
                                  color: AppColors.smallTextColor,
                                  fontFamily: FontFamilies.alexandria,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700),
                            ), // Set the selected value
                            style: TextStyle(
                              fontFamily: FontFamilies.alexandria,
                              fontSize: 12,
                              height: 1.0,
                              color: Colors.black,
                            ),
                            buttonStyleData: ButtonStyleData(
                              //padding: EdgeInsets.only(right: 10.w),
                              height: 40,
                              width: 160.w,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 200,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border:
                                      Border.all(color: Colors.transparent)),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                            dropdownSearchData: DropdownSearchData(
                              searchController: textEditingController2,
                              searchInnerWidgetHeight: 50,
                              searchInnerWidget: Container(
                                height: 50,
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 4,
                                  right: 8,
                                  left: 8,
                                ),
                                child: TextFormField(
                                  expands: true,
                                  maxLines: null,
                                  controller: textEditingController2,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    hintTextDirection: TextDirection.rtl,
                                    hintText: 'ابحث عن مركز....',
                                    hintStyle: const TextStyle(fontSize: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              searchMatchFn: (item, searchValue) {
                                final myItem = signUpCubit.areasList.firstWhere(
                                    (element) => element.name == item.value);
                                return myItem.name!.contains(searchValue) ||
                                    item.value.toString().contains(searchValue);
                              },
                            ),
                            onMenuStateChange: (isOpen) {
                              if (!isOpen) {
                                textEditingController2.clear();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 14.h, right: 7.w),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.black26),
                        ),
                        child: Center(
                          child: DropdownButton2<String>(
                            underline: SizedBox.shrink(),
                            isExpanded: true,
                            items: signUpCubit.citiesList
                                .map((Cities city) => DropdownMenuItem<String>(
                                      value: city.name ??
                                          "", // Assuming city.name is a String
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          city.name ?? "",
                                          textDirection: TextDirection.rtl,
                                          maxLines:
                                              2, // Set text direction to RTL
                                        ),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (String? cityName) {
                              selectedCityName = cityName;
                              selectedAreaName = null;
                              setState(() {});
                              // Find the corresponding city object based on the selected city name
                              final selectedCity =
                                  signUpCubit.citiesList.firstWhere(
                                (city) => city.name == cityName,
                                orElse: () => signUpCubit.citiesList
                                    .first, // Default to the first city
                              );
                              cityDropdownController.text =
                                  selectedCity.name ?? "";
                              signUpCubit.cityId =
                                  selectedCity.id?.toInt() ?? 0;
                              signUpCubit.fetchAreaData();
                            },
                            hint: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                selectedCityName ?? 'المحافظة',
                                style: TextStyle(
                                    color: AppColors.smallTextColor,
                                    fontFamily: FontFamilies.alexandria,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700),
                              ),
                            ), // Set the selected value
                            style: TextStyle(
                              fontFamily: FontFamilies.alexandria,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                            buttonStyleData: ButtonStyleData(
                              height: 40,
                              width: 160.w,
                            ),

                            dropdownStyleData: DropdownStyleData(
                              maxHeight: 200,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border:
                                      Border.all(color: Colors.transparent)),
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                            dropdownSearchData: DropdownSearchData(
                              searchController: textEditingController,
                              searchInnerWidgetHeight: 50,
                              searchInnerWidget: Container(
                                height: 50,
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 4,
                                  right: 8,
                                  left: 8,
                                ),
                                child: TextFormField(
                                  expands: true,
                                  maxLines: null,
                                  controller: textEditingController,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 8,
                                    ),
                                    hintTextDirection: TextDirection.rtl,
                                    hintText: 'ابحث عن محافظة....',
                                    hintStyle: const TextStyle(fontSize: 12),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              searchMatchFn: (item, searchValue) {
                                final myItem = signUpCubit.citiesList
                                    .firstWhere((element) =>
                                        element.name == item.value);
                                return myItem.name!.contains(searchValue) ||
                                    item.value.toString().contains(searchValue);
                              },
                            ),
                            onMenuStateChange: (isOpen) {
                              if (!isOpen) {
                                textEditingController.clear();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 23.h,
                ),
                experienceTextField,
                SizedBox(height: 23.h),
                phoneTextField,
                SizedBox(height: 11.h),
                if (otpSent == false)
                  GestureDetector(
                    onTap: () {
                      if (phoneController.isNotNull &&
                          phoneController.toString().length >= 11) {
                        signUpCubit.OtpCheck(phoneController.text);
                      }
                    },
                    child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: 155.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                    color: AppColors.orangeBorderColor,
                                    borderRadius: BorderRadius.circular(5.r)),
                                child: state is OtpSendLoading
                                    ? Center(
                                        child: Transform.scale(
                                          scale: 0.5,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: Text(
                                          'ارسال رمز التأكيد',
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily:
                                                  FontFamilies.alexandria,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 11.5),
                                        ),
                                      )),
                          ],
                        )),
                  ),
                if (otpSent == true && isConfirmed == false)
                  GestureDetector(
                    onTap: () {
                      signUpCubit.OtpSubmit(controller.text);
                    },
                    child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: resend == true ? 0.h : 12.h),
                              child: Column(
                                children: [
                                  Container(
                                    width: 155.w,
                                    height: 67.h,
                                    decoration: BoxDecoration(
                                        color: AppColors.orangeBorderColor,
                                        borderRadius:
                                            BorderRadius.circular(5.r)),
                                    child: state is OtpSubmitLoading
                                        ? Center(
                                            child: Transform.scale(
                                              scale: 0.4,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        : Center(
                                            child: Text(
                                              'تم ارسال الرمز \nادخل الرمز صحيحا للتأكيد',
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily:
                                                    FontFamilies.alexandria,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 9.5,
                                                height: 2.h,
                                              ),
                                            ),
                                          ),
                                  ),
                                  SizedBox(
                                    height: 18.h,
                                  ),
                                  if (resend)
                                    Padding(
                                      padding: EdgeInsets.only(left: 6.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        onTap: () {
                                          signUpCubit.resendOtpCycle();
                                        },
                                        child: Text(
                                          'تغيير الرقم/ إعادة الإرسال',
                                          style: TextStyle(
                                              color:
                                                  AppColors.orangeBorderColor,
                                              fontWeight: FontWeight.w800,
                                              fontFamily:
                                                  FontFamilies.alexandria,
                                              fontSize: 11),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                OtpTextField(
                                  textStyle: TextStyle(
                                      color: AppColors.orangeBorderColor,
                                      fontWeight: FontWeight.w600),
                                  cursorColor: AppColors.orangeBorderColor,
                                  fieldWidth: 35,
                                  numberOfFields: 4,
                                  focusedBorderColor:
                                      AppColors.orangeBorderColor,
                                  borderColor: Color(0xFF512DA8),
                                  //set to true to show as box or false to show as dash
                                  showFieldAsBox: true,
                                  //runs when a code is typed in
                                  onCodeChanged: (String code) {
                                    //handle validation or checks here
                                  },
                                  //runs when every textfield is filled
                                  onSubmit: (String verificationCode) {
                                    controller.text = verificationCode;
                                  }, // end onSubmit
                                ),
                                SizedBox(
                                  height: 17.h,
                                ),
                                Row(
                                  textDirection: TextDirection.rtl,
                                  children: [
                                    Text(
                                      'إعادة إرسال الرمز بعد',
                                      style: TextStyle(
                                          color: AppColors.orangeBorderColor,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: FontFamilies.alexandria,
                                          fontSize: 11),
                                    ),
                                    SizedBox(
                                      width: 7.w,
                                    ),
                                    TimerCountdown(
                                      descriptionTextStyle: TextStyle(
                                          color: AppColors.orangeBorderColor,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: FontFamilies.alexandria,
                                          fontSize: 11),
                                      timeTextStyle: TextStyle(
                                          color: AppColors.orangeBorderColor,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: FontFamilies.alexandria,
                                          fontSize: 11),
                                      format: CountDownTimerFormat.secondsOnly,
                                      endTime: DateTime.now().add(
                                        Duration(
                                          seconds: 25,
                                        ),
                                      ),
                                      onEnd: () {
                                        signUpCubit.resendOtp();
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )),
                  ),
                if (isConfirmed == true && otpSent == true)
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("تم التأكيد بالفعل"),
                        duration: Duration(seconds: 2),
                      ));
                    },
                    child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 155.w,
                              height: 67.h,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5.r)),
                              child: Center(
                                child: Text(
                                  AppStrings.confirmed,
                                  textDirection: TextDirection.rtl,
                                  maxLines: 2,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: FontFamilies.alexandria,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.5,
                                    height: 1.2.h,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                SizedBox(
                  height: 25.h,
                ),
                state is SignUpLoading
                    ? Container(
                        width: 420.w,
                        height: 63.h,
                        decoration: BoxDecoration(
                          color: AppColors.orangeBorderColor,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                            child: Transform.scale(
                          scale: 0.5,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )),
                      )
                    : AuthButton(
                        text: AppStrings.createAccount,
                        onTap: () {
                          // if (_formKey.currentState!.validate()) {
                          if (isConfirmed == true && otpSent == true) {
                            _handleSignUp();
                          } else if (isConfirmed == false || otpSent == false) {
                            CustomSnackBars.showErrorToast(
                                title: 'برجاء تأكيد رقم الهاتف');
                            // }
                          }
                        },
                      ),
                SizedBox(
                  height: 30.h,
                ),
              ],
            ),
          ),
        ),
      ));
    });
  }

  get logoImg => Padding(
        padding: EdgeInsets.only(top: 15.h),
        child: Center(child: SvgPicture.asset(AppAssets.signupFinalSvg)),
      );

  get signingUpText => const Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Text(
          AppStrings.signingUp,
          style: TextStyle(
              color: AppColors.blueColor,
              fontFamily: FontFamilies.alexandria,
              fontSize: 15),
        ),
      );

  get haveAnAccountText => const Text(
        AppStrings.haveAnAccount,
        style: TextStyle(
            color: AppColors.smallTextColor,
            fontFamily: FontFamilies.alexandria,
            fontWeight: FontWeight.w500,
            fontSize: 11),
      );

  get signIn => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            haveAnAccountText,
            SizedBox(
              width: 4.3.w,
            ),
            loginToAccountText(),
          ],
        ),
      );

  get nameTextField => RegularTextField(
        controller: nameController,
        hintText: AppStrings.name,
        obscureText: false,
        img: AppAssets.usernameIcon,
        validator: (value) {
          if (value!.isEmpty) {
            return AppStrings.pleaseEnterName;
          } else if (nameController.text.isNumericOnly) {
            return 'name must contain letters';
          }
          return null;
        },
      );

  get userNameTextField => UsernameTextField(
        controller: usernameController,
        hintText: AppStrings.username,
        obsecureText: false,
        img: AppAssets.usernameIcon,
        validator: (value) {
          if (value!.isEmpty) {
            return AppStrings.pleaseEnterUserName;
          } else if (usernameController.text.isNumericOnly) {
            return 'username must contain letters';
          }
          return null;
        },
      );

  get emailTextField => RegularTextField(
        max: 40,
        controller: emailController,
        hintText: AppStrings.email,
        obscureText: false,
        img: AppAssets.mailIcon,
        iconWidth: 14.w,
        iconHeight: 14.h,
        validator: (value) {
          if (value!.isEmpty) {
            return AppStrings.pleaseEnterEmail;
          }
          return null;
        },
      );

  get phoneTextField => RegularTextField(
        max: 11,
        readOnly: otpSent == true ? true : false,
        keyboardType: TextInputType.number,
        controller: phoneController,
        hintText: AppStrings.phoneNumber,
        obscureText: false,
        img: AppAssets.phoneIcon,
        validator: (value) {
          if (value!.isEmpty) {
            if (phoneController.text.length < 11) {
              return AppStrings.pleaseEnterPhone;
            }
          } else if (value.length != 11) {
            return 'أدخل رقم هاتف صحيح';
          }
          return null;
        },
      );

  get whatsAppTextField => RegularTextField(
        max: 11,
        keyboardType: TextInputType.number,
        controller: whatsappController,
        hintText: AppStrings.whatsAppNumber,
        obscureText: false,
        img: AppAssets.whatsAppIcon,
        validator: (value) {
          if (value!.isEmpty) {
            return AppStrings.pleaseEnterWhatsapp;
          } else if (value.length != 11) {
            return 'أدخل رقم واتساب صحيح';
          }
          return null;
        },
      );

  get idTextField => RegularTextField(
        max: 14,
        keyboardType: TextInputType.number,
        controller: idNumberController,
        hintText: AppStrings.idNumber,
        obscureText: false,
        img: AppAssets.idCardIcon,
        iconHeight: 17.h,
        iconWidth: 17.w,
        validator: (value) {
          if (value!.isEmpty) {
            return AppStrings.pleaseEnterId;
          } else if (value.length != 14) {
            return 'أدخل رقم قومي صحيح';
          }
          return null;
        },
      );

  get workTextField => RegularTextField(
        max: 60,
        controller: workController,
        hintText: AppStrings.work,
        obscureText: false,
        img: AppAssets.workIcon,
        validator: (value) {
          if (value!.isEmpty) {
            return AppStrings.pleaseEnterWork;
          }
          return null;
        },
      );

  get locationTextField => RegularTextField(
        max: 60,
        controller: addressController,
        hintText: AppStrings.address,
        obscureText: false,
        img: AppAssets.locationIcon,
        iconHeight: 18.h,
        validator: (value) {
          if (value!.isEmpty) {
            return AppStrings.pleaseEnterAddress;
          }
          return null;
        },
      );

  get experienceTextField => RegularTextField(
        max: 60,
        controller: previousExperienceController,
        hintText: AppStrings.experience,
        obscureText: false,
        img: AppAssets.experienceIcon,
        validator: (value) {
          if (value!.isEmpty) {
            return AppStrings.pleaseEnterPreviousExperience;
          }
          return null;
        },
      );

  get signUpButton => AuthButton(
        text: AppStrings.createAccount,
        onTap: () {},
      );
}
