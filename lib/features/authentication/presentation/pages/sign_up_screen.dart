import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/core/widgets/custom_snack_bar.dart';
import 'package:life_makers/core/widgets/spacer.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/authentication/presentation/widgets/auth_button.dart';
import 'package:life_makers/features/authentication/presentation/widgets/email_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/confirm_password_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/id_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/location_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/name_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/sign_in_text.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/sign_up_email_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/sign_up_logo.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/sign_up_password_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/signing_up_text.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/username_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/whats_app_text_field.dart';
import 'package:life_makers/features/authentication/presentation/widgets/sign_up_widgets/work_text_field.dart';
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


  @override
  void initState() {
    super.initState();
    signUpCubit.fetchCityData();
   }

  @override
  Widget build(BuildContext context) {
    SignUpCubit signUpCubit = context.read<SignUpCubit>();
    return BlocConsumer<SignUpCubit, SignUpState>(listener: (context, state) {
      if (state is SignUpSuccess) {
        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 400),
                child: DrawerPage()));
      } else if (state is OtpSendSuccess) {
        signUpCubit.otpSent = true;
      } else if (state is OtpSubmitSuccess) {
        signUpCubit.isConfirmed = true;
      } else if (state is OtpResend) {
        signUpCubit.resend = true;
      } else if (state is OtpResendCycleState) {
        signUpCubit.otpSent = false;
        signUpCubit.phoneController.clear();
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
                const SignUpLogo(),
                const SigningUpText(),
                const SignInText(),
                const NameTextField(),
                VerticalSpace(context.height20),
                const UsernameTextField(),
                VerticalSpace(context.height20),
                const SignUpPasswordTextField(),
                VerticalSpace(context.height20),
                const SignUpConfirmPasswordTextField(),
                VerticalSpace(context.height20),
                const SignUpEmailTextField(),
                VerticalSpace(context.height20),
                const WhatsAppTextField(),
                VerticalSpace(context.height20),
                const IdTextField(),
                VerticalSpace(context.height20),
                const WorkTextField(),
                VerticalSpace(context.height20),
                const LocationTextField(),
                VerticalSpace(context.height20),
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
                              signUpCubit.selectedAreaName = areaName;

                              // Find the corresponding city object based on the selected city name
                              final selectedArea =
                                  signUpCubit.areasList.firstWhere(
                                (area) => area.name == areaName,
                                orElse: () => signUpCubit.areasList
                                    .first, // Default to the first city
                              );

                              // Update your state or perform actions with the selected city
                              signUpCubit.areaDropdownController.text =
                                  selectedArea.name ?? "";
                              signUpCubit.fetchAreaData();
                            },
                            isExpanded: true,
                            hint: Text(
                              signUpCubit.selectedAreaName ?? 'المركز',
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
                              searchController: signUpCubit.textEditingController2,
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
                                  controller: signUpCubit.textEditingController2,
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
                                signUpCubit.textEditingController2.clear();
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
                              signUpCubit.selectedCityName = cityName;
                              signUpCubit.selectedAreaName = null;
                              setState(() {});
                              // Find the corresponding city object based on the selected city name
                              final selectedCity =
                                  signUpCubit.citiesList.firstWhere(
                                (city) => city.name == cityName,
                                orElse: () => signUpCubit.citiesList
                                    .first, // Default to the first city
                              );
                              signUpCubit.cityDropdownController.text =
                                  selectedCity.name ?? "";
                              signUpCubit.cityId =
                                  selectedCity.id?.toInt() ?? 0;
                              signUpCubit.fetchAreaData();
                            },
                            hint: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                signUpCubit.selectedCityName ?? 'المحافظة',
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
                              searchController: signUpCubit.textEditingController,
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
                                  controller: signUpCubit.textEditingController,
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
                                signUpCubit.textEditingController.clear();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                VerticalSpace(context.height20),
                experienceTextField,
                VerticalSpace(context.height20),
                phoneTextField,
                SizedBox(height: 11.h),
                if (signUpCubit.otpSent == false)
                  GestureDetector(
                    onTap: () {
                      if (signUpCubit.phoneController.isNotNull &&
                          signUpCubit.phoneController.toString().length >= 11) {
                        signUpCubit.OtpCheck(signUpCubit.phoneController.text);
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
                if (signUpCubit.otpSent == true && signUpCubit.isConfirmed == false)
                  GestureDetector(
                    onTap: () {
                      signUpCubit.OtpSubmit(signUpCubit.controller.text);
                    },
                    child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: signUpCubit.resend == true ? 0.h : 12.h),
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
                                  if (signUpCubit.resend)
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
                                    signUpCubit.controller.text = verificationCode;
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
                if (signUpCubit.isConfirmed == true && signUpCubit.otpSent == true)
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
                          if (signUpCubit.isConfirmed == true && signUpCubit.otpSent == true) {
                            signUpCubit.handleSignUp();
                          } else if (signUpCubit.isConfirmed == false || signUpCubit.otpSent == false) {
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

  get phoneTextField => RegularTextField(
        max: 11,
        readOnly: signUpCubit.otpSent == true ? true : false,
        keyboardType: TextInputType.number,
        controller: signUpCubit.phoneController,
        hintText: AppStrings.phoneNumber,
        obscureText: false,
        img: AppAssets.phoneIcon,
        validator: (value) {
          if (value!.isEmpty) {
            if (signUpCubit.phoneController.text.length < 11) {
              return AppStrings.pleaseEnterPhone;
            }
          } else if (value.length != 11) {
            return 'أدخل رقم هاتف صحيح';
          }
          return null;
        },
      );

  get experienceTextField => RegularTextField(
        max: 60,
        controller: signUpCubit.previousExperienceController,
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
}
