import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/features/membership_controll/screens/membership_third_step.dart';
import 'package:page_transition/page_transition.dart';
import '../../../core/utils/app-assets.dart';
import '../../../core/utils/app-color.dart';


class MemberShipSecondStep extends StatefulWidget {
  const MemberShipSecondStep({Key? key}) : super(key: key);

  @override
  State<MemberShipSecondStep> createState() => _MemberShipSecondStepState();
}

class _MemberShipSecondStepState extends State<MemberShipSecondStep> {

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
              onTap: (){
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
              top:45,
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
          ],
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(

          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              const Padding(
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

              StatefulBuilder(builder: (context,setState){
                return SingleChildScrollView(

                  physics: const BouncingScrollPhysics(),

                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Radio(
                    activeColor: AppColors.orangeColor    ,
                    onChanged: (int ?val){
                          selectedPayment=val!;
                          setState((){});
                        },
                        value: 0, groupValue: selectedPayment,
                      ),
                      Image.asset('assets/images/fawry.png',width: 50,height: 10),

                      Radio(
                        activeColor: AppColors.orangeColor    ,

                        onChanged: (int ?val){
                          selectedPayment=val!;                        setState((){});

                        },
                        value: 1, groupValue: selectedPayment,
                      ),
                      Image.asset('assets/images/meza.png',width: 50,height: 10),
                      Radio(
                        activeColor: AppColors.orangeColor    ,

                        onChanged: (int ?val){
                          selectedPayment=val!;
                          setState((){});

                        },
                        value: 2, groupValue: selectedPayment,
                      ),
                      Image.asset('assets/images/visa.png',width: 50,height: 10),
                      Radio(
                        activeColor: AppColors.orangeColor    ,

                        onChanged: (int ?val){
                          selectedPayment=val!;
                          setState((){});

                        },
                        value: 3, groupValue: selectedPayment,
                      ),
                      Image.asset('assets/images/vodafone.png',width: 50,height: 10),
                    ],
                  ),
                );
              }),
              const Align(
                alignment: Alignment.topRight,
                child: Text(
                  'اسم حامل البطاقة',
                  style: TextStyle(
                    fontFamily: 'Alexandria',
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(top: 14,bottom: 18),
                child: TextFormField(
                  cursorWidth: 1,
                  decoration: InputDecoration(

                      hintText: 'يرجي إدخال اسم حامل البطاقة',
                      // alignLabelWithHint: false,
                      hintStyle:const TextStyle(
                        fontFamily: 'Alexandria',
                        fontSize: 9,
                        fontWeight: FontWeight.w400,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SvgPicture.asset('assets/svg/card.svg'),
                      ),
                      prefixIconConstraints:const BoxConstraints(
                        maxWidth: 45,
                        maxHeight: 25

                      ),

                      border: OutlineInputBorder(

                        borderSide: const BorderSide(
                          color: Color(0xff2673d166)
                        ),
                        borderRadius: BorderRadius.circular(5),
                      )),
                ),
              ),

              const Align(
                alignment: Alignment.topRight,
                child: Text(
                  'رقم البطاقة',
                  style: TextStyle(
                    fontFamily: 'Alexandria',
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(top: 14,bottom: 18),
                child: TextFormField(
                  cursorWidth: 1,
                  decoration: InputDecoration(

                      hintText: 'يرجي إدخال رقم البطاقة',
                      // alignLabelWithHint: false,
                      hintStyle:const TextStyle(
                        fontFamily: 'Alexandria',
                        fontSize: 9,
                        fontWeight: FontWeight.w400,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SvgPicture.asset('assets/svg/card.svg'),
                      ),
                      prefixIconConstraints:const BoxConstraints(
                          maxWidth: 45,
                          maxHeight: 25

                      ),

                      border: OutlineInputBorder(

                        borderSide: const BorderSide(
                            color: Color(0xff2673d166)
                        ),
                        borderRadius: BorderRadius.circular(5),
                      )),
                ),
              ),

              Row(
                children: [
                  Flexible(
                    child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'تاريخ الانتهاء',
                          style: TextStyle(
                            fontFamily: 'Alexandria',
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 5,),
                        TextFormField(
                          cursorWidth: 1,
                          decoration: InputDecoration(

                              hintText: 'تاريخ الانتهاء',
                              // alignLabelWithHint: false,
                              hintStyle:const TextStyle(
                                fontFamily: 'Alexandria',
                                fontSize: 9,
                                fontWeight: FontWeight.w400,
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: SvgPicture.asset('assets/svg/card.svg'),
                              ),
                              prefixIconConstraints:const BoxConstraints(
                                  maxWidth: 45,
                                  maxHeight: 25

                              ),

                              border: OutlineInputBorder(

                                borderSide: const BorderSide(
                                    color: Color(0xff2673d166)
                                ),
                                borderRadius: BorderRadius.circular(5),
                              )),
                        ),

                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'رمز التحقق',
                          style: TextStyle(
                            fontFamily: 'Alexandria',
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 5,),
                        TextFormField(
                          cursorWidth: 1,
                          decoration: InputDecoration(

                              hintText: 'تاريخ الانتهاء',
                              // alignLabelWithHint: false,
                              hintStyle:const TextStyle(
                                fontFamily: 'Alexandria',
                                fontSize: 9,
                                fontWeight: FontWeight.w400,
                              ),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: SvgPicture.asset('assets/svg/card.svg'),
                              ),
                              prefixIconConstraints:const BoxConstraints(
                                  maxWidth: 45,
                                  maxHeight: 25

                              ),

                              border: OutlineInputBorder(

                                borderSide: const BorderSide(
                                    color: Color(0xff2673d166)
                                ),
                                borderRadius: BorderRadius.circular(5),
                              )),
                        ),

                      ],
                    ),
                  ),
                 ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 25, right: 25,top: 15),
        child: ElevatedButton(

          style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)
          ),
            elevation: 0,
            backgroundColor: AppColors.orangeColor,
            minimumSize: const Size(double.infinity, 55),
          ),
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 500),
                child: const MemberShipThirdStep(),
              ),
            );
          },
          child: const Text(
            'دفع',
            style: TextStyle(
              fontFamily: 'Alexandria',
              fontWeight: FontWeight.w500,
              color: Colors.white
              ,
              fontSize: 11,
            ),
          ),
        ),
      ),
    );
  }
}
