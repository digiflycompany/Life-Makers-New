import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:life_makers/core/utils/app-color.dart';
 import 'package:page_transition/page_transition.dart';
import '../../../core/utils/app-assets.dart';
import '../../membership_controll/screens/membership_first_step.dart';


class CompleteEditAccountScreen extends StatefulWidget {
  const CompleteEditAccountScreen({Key? key}) : super(key: key);

  @override
  State<CompleteEditAccountScreen> createState() =>
      _CompleteEditAccountScreenState();
}

class _CompleteEditAccountScreenState extends State<CompleteEditAccountScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController governorateController = TextEditingController();
  final TextEditingController centerController = TextEditingController();
  final TextEditingController yourCurrentPositionController =
      TextEditingController();
  final TextEditingController detailedAddressController =
      TextEditingController();
  final TextEditingController nationalIDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 300),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(AppAssets.unionGreyImg,
                width: double.infinity, fit: BoxFit.cover),
            Positioned(
              top: 50,
              right: 12,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child:  Container(
                    width: 40.w,
                    height: 40.h,
                    child: Transform.scale(
                        scale: 0.45,
                        child: SvgPicture.asset(AppAssets.popUpIcon,))),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Text('تعديل الحساب',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Alexandria',
                  )),
            )
          ],
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'ما هو دورك الحالي في صناع الحياة * ',
                        style: buildLabelStyle(),
                      ),
                      TextField(
                          controller: nameController,
                          cursorColor: AppColors.blueColor,
                          cursorWidth: 1,
                          maxLines: 1,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            // labelText: 'الاسم * ',
                            labelStyle: buildLabelStyle(),
                            focusedBorder: buildUnderlineInputBorder(),
                          )),
                    ],
                  )),
                  const SizedBox(width: 34),
                  Flexible(
                      child: Column(
                    children: [
                      Text(
                        'ما هو اخر توقيت  قمت بهذا الدور* ',
                        style: buildLabelStyle(),
                      ),
                      TextField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          cursorColor: AppColors.blueColor,
                          cursorWidth: 1,
                          decoration: InputDecoration(
                            labelStyle: buildLabelStyle(),
                            focusedBorder: buildUnderlineInputBorder(),
                          )),
                    ],
                  )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'المشروعات، الحملات، اللجان التي شاركت بها خلال فترة تطوعك *',
                          style: buildLabelStyle(),
                        ),
                        TextField(
                            controller: nameController,
                            cursorColor: AppColors.blueColor,
                            cursorWidth: 1,
                            maxLines: 1,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              // labelText: 'الاسم * ',
                              labelStyle: buildLabelStyle(),
                              focusedBorder: buildUnderlineInputBorder(),
                            )),
                      ],
                    )),
                    const SizedBox(width: 34),
                    Flexible(
                        child: Column(
                      children: [
                        Text(
                          ' ما هي المعسكرات التي شاركت فيها؟ * ',
                          style: buildLabelStyle(),
                        ),
                        TextField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            cursorColor: AppColors.blueColor,
                            cursorWidth: 1,
                            decoration: InputDecoration(
                              labelStyle: buildLabelStyle(),
                              focusedBorder: buildUnderlineInputBorder(),
                            )),
                      ],
                    )),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                      child: TextField(
                          controller: nameController,
                          cursorColor: AppColors.blueColor,
                          cursorWidth: 1,
                          maxLines: 1,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            labelText: 'اسم منسق محافظتك *',
                            labelStyle: buildLabelStyle(),
                            focusedBorder: buildUnderlineInputBorder(),
                          ))),
                  const SizedBox(width: 34),
                  Flexible(
                      child: TextField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          cursorColor: AppColors.blueColor,
                          cursorWidth: 1,
                          decoration: InputDecoration(
                            labelStyle: buildLabelStyle(),
                            labelText: 'الجامعة *',
                            focusedBorder: buildUnderlineInputBorder(),
                          ))),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                        child: TextField(
                            controller: nameController,
                            cursorColor: AppColors.blueColor,
                            cursorWidth: 1,
                            maxLines: 1,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: 'التخصص * ',
                              // labelText: 'الاسم * ',
                              labelStyle: buildLabelStyle(),
                              focusedBorder: buildUnderlineInputBorder(),
                            ))),
                    const SizedBox(width: 34),
                    Flexible(
                        child: TextField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.phone,
                            controller: emailController,
                            cursorColor: AppColors.blueColor,
                            cursorWidth: 1,
                            decoration: InputDecoration(
                              labelText: 'سنة التخرج *',
                              labelStyle: buildLabelStyle(),
                              focusedBorder: buildUnderlineInputBorder(),
                            ))),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                        child: TextField(
                            controller: nameController,
                            cursorColor: AppColors.blueColor,
                            cursorWidth: 1,
                            maxLines: 1,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: 'الوظيفة الحالية * ',
                              // labelText: 'الاسم * ',
                              labelStyle: buildLabelStyle(),
                              focusedBorder: buildUnderlineInputBorder(),
                            ))),
                    const SizedBox(width: 34),
                    Flexible(
                        child: TextField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            cursorColor: AppColors.blueColor,
                            cursorWidth: 1,
                            decoration: InputDecoration(
                              labelText: 'مشترك في مشروع الجامعة؟ *',
                              labelStyle: buildLabelStyle(),
                              focusedBorder: buildUnderlineInputBorder(),
                            ))),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                        child: TextField(
                            enabled: false,
                            controller: nameController,
                            cursorColor: AppColors.blueColor,
                            cursorWidth: 1,
                            maxLines: 1,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              labelText: 'صورة البطاقة وجه * ',
                              suffixIconConstraints: const BoxConstraints(
                                  maxWidth: 12, maxHeight: 12),
                              suffixIcon: SvgPicture.asset(
                                  AppAssets.uploadIcon,
                                  width: 12, height: 12, fit: BoxFit.fill),
                              labelStyle: buildLabelStyle(),
                              focusedBorder: buildUnderlineInputBorder(),
                            ))),
                    const SizedBox(width: 34),
                    Flexible(
                        child: TextField(
                            enabled: false,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                            cursorColor: AppColors.blueColor,
                            cursorWidth: 1,
                            decoration: InputDecoration(
                              suffixIconConstraints: const BoxConstraints(
                                  maxWidth: 12, maxHeight: 12),
                              suffixIcon: SvgPicture.asset(AppAssets.uploadIcon,
                                  width: 12, height: 12, fit: BoxFit.fill),
                              labelText: 'صورة البطاقة ظهر؟ *',
                              labelStyle: buildLabelStyle(),
                              focusedBorder: buildUnderlineInputBorder(),
                            ))),
                  ],
                ),
              ),
            ],
          ),
        ),

      ),
      bottomNavigationBar:    Padding(
        padding: EdgeInsets.only(left: 25.w,right: 25.w,bottom: 50.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    duration: const Duration(milliseconds: 500),
                    child: const MemberShipFirstStep(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppColors.orangeColor,
                  fixedSize: Size(80.w, 30.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              child: const Text(
                'حفظ',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Alexandria',
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  UnderlineInputBorder buildUnderlineInputBorder() {
    return const UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xffD9D9D9)),
    );
  }

  TextStyle buildLabelStyle([Color? color]) {
    return TextStyle(
      color: color ?? const Color(0xffBDBDBD),
      fontWeight: FontWeight.w400,
      fontSize: 10,
      fontFamily: 'Alexandria',
    );
  }
}
