import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';
import '../../../core/utils/app-assets.dart';
import '../../../core/utils/app-color.dart';
import '../../../core/widgets/thanks_screen.dart';

class MemberShipThirdStep extends StatefulWidget {
  const MemberShipThirdStep({Key? key}) : super(key: key);

  @override
  State<MemberShipThirdStep> createState() => _MemberShipThirdStepState();
}

class _MemberShipThirdStepState extends State<MemberShipThirdStep> {
  int? selectedPayment;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 300),
        child: Stack(
          alignment: Alignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(AppAssets.unionGreyImg,
                  width: double.infinity, fit: BoxFit.fill),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 0, bottom: 10),
              child: Text('ظبط العضوية',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Alexandria')),
            ),
            Positioned(
              top: 43,
              right: 11,
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
          ],
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(

          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xffFBC472),
                ),
                width: double.infinity,
                child: Image.asset(
                  'assets/images/membership.png',
                ),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  child: Text(
                    'يرجى اادخال بيانات الدفع، لدفع رسوم الكارنيه',
                    style: TextStyle(
                      fontFamily: 'Alexandria',
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              StatefulBuilder(builder: (context, setState) {
                return SingleChildScrollView(

                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Radio(
                        activeColor: AppColors.orangeBorderColor,
                        onChanged: (int? val) {
                          selectedPayment = val!;
                          setState(() {});
                        },
                        value: 0,
                        groupValue: selectedPayment,
                      ),
                      Image.asset('assets/images/fawry.png',
                          width: 50, height: 10),
                      Radio(
                        activeColor: AppColors.orangeBorderColor,
                        onChanged: (int? val) {
                          selectedPayment = val!;
                          setState(() {});
                        },
                        value: 1,
                        groupValue: selectedPayment,
                      ),
                      Image.asset('assets/images/meza.png',
                          width: 50, height: 10),
                      Radio(
                        activeColor: AppColors.orangeBorderColor,
                        onChanged: (int? val) {
                          selectedPayment = val!;
                          setState(() {});
                        },
                        value: 2,
                        groupValue: selectedPayment,
                      ),
                      Image.asset('assets/images/visa.png',
                          width: 50, height: 10),
                      Radio(
                        activeColor: AppColors.orangeBorderColor,
                        onChanged: (int? val) {
                          selectedPayment = val!;
                          setState(() {});
                        },
                        value: 3,
                        groupValue: selectedPayment,
                      ),
                      Image.asset('assets/images/vodafone.png',
                          width: 50, height: 10),
                    ],
                  ),
                );
              }),
              Center(
                child: Container(
                  width: 205,
                  height: 220,
                  decoration: BoxDecoration(
                    color: const Color(0xff510C76),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.only(top: 30, right: 30, left: 30),
                  margin: const EdgeInsets.only(bottom: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 136,
                        height: 142,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset('assets/images/qrCode.png'),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'اقرأ الكود للدفع',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Alexandria',
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SvgPicture.asset('assets/svg/tie.svg'),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const Text(
                'من القائمة الرئيسية بالمحفظة:',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Alexandria',
                  fontWeight: FontWeight.w700,
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    CircleAvatar(radius: 5,backgroundColor: AppColors.orangeBorderColor),
                 SizedBox(width: 10),
                    Text(
                      'اختار ( شراء - Purchase )',
                      style: TextStyle(
                        fontSize: 9,
                        fontFamily: 'Alexandria',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(radius: 5,backgroundColor: AppColors.orangeBorderColor),
               SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      'قم بعمل( مسح - Scan) للـ QR Code عن طريق المحفظة الذكية الخاصة بكمن أي بنك إلى محفظة صناع الحياة - Life Makers علي بنك CIB',
                      style: TextStyle(
                        fontSize: 9,
                        fontFamily: 'Alexandria',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    CircleAvatar(radius: 5,backgroundColor: AppColors.orangeBorderColor),
                    SizedBox(width: 10),
                    Text(
                      'أو أدخل رقم التاجر (Life Makers)',
                      style: TextStyle(
                        fontSize: 9,
                        fontFamily: 'Alexandria',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const Row(
                children: [
                  CircleAvatar(radius: 5,backgroundColor: AppColors.orangeBorderColor),
                  SizedBox(width: 10),
                  Text(
                    'أو أدخل رقم ميزة (102731204)',
                    style: TextStyle(
                      fontSize: 9,
                      fontFamily: 'Alexandria',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.only(bottom: 20, left: 25, right: 25, top: 15),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            elevation: 0,
            backgroundColor: AppColors.orangeBorderColor,
            minimumSize: const Size(double.infinity, 55),
          ),
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 500),
                child: const ThanksScreen(),
              ),
            );
          },
          child: const Text(
            'دفع',
            style: TextStyle(
              fontFamily: 'Alexandria',
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 11,
            ),
          ),
        ),
      ),
    );
  }
}
