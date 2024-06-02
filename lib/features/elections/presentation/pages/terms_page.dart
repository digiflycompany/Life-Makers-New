import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/features/elections/presentation/pages/elections_screen.dart';
import 'package:life_makers/features/elections/presentation/widgets/custom_term.dart';
import 'package:life_makers/features/elections/presentation/widgets/terms_button.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../core/utils/app-assets.dart';
import '../../../../core/utils/app-string.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/title_text.dart';

class TermsPage extends StatefulWidget {
  const TermsPage({super.key});

  @override
  State<TermsPage> createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, 50.h),
          child: CustomAppBar(AppStrings.volunteerBoardOfDirectorsElections)),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(children: [
            SizedBox(
              height: 57.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Container(
                width: double.infinity,
                height: 574.h,
                decoration: BoxDecoration(
                  color: AppColors.greyColor6,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Stack(
                  children: [
                    Align(
                        alignment: AlignmentDirectional.bottomStart,
                        child: Padding(
                          padding: EdgeInsets.only(left: 25.w),
                          child:
                              Image.asset(AppAssets.electionsBackgroundImage),
                        )),
                    Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 70.h,
                          decoration: BoxDecoration(
                              color: AppColors.blueColor,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(12.r),
                                topLeft: Radius.circular(12.r),
                              )),
                          child: Center(
                            child: Text(
                              AppStrings.electionsTerms,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: FontFamilies.alexandria,
                                  fontSize: 11.5,
                                  height: 2.h),
                              textDirection: TextDirection.rtl,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 40.h),
                          child: Column(
                            children: [
                              CustomTerm(
                                text: 'خطوات العملية الانتخابية :',
                                height: 1.h,

                              ),  CustomTerm(
                                text: AppStrings.term1,
                                height: 21.h,
                              ),
                              SizedBox(
                                height: 21.h,
                              ),
                              CustomTerm(
                                text: AppStrings.term2,
                                height: 14.h,
                              ),
                              SizedBox(
                                height: 35.h,
                              ),
                              CustomTerm(
                                text: AppStrings.term3,
                                height: 0.h,
                              ),
                              CustomTerm(
                                text: AppStrings.term4,
                                height: 35.h,
                              ),

                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: TermsButton(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 530),
                      child: const ElectionsScreen()));
            },
            text: AppStrings.electionsButton),
      ),
    );
  }

  get title => TitleText(text: AppStrings.volunteerBoardOfDirectorsElections);
  get popUpIcon => InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: SvgPicture.asset(
          AppAssets.popUpIcon,
        ),
      );
  get header => Row(
        children: [
          SizedBox(
            width: 105.w,
          ),
          title,
          SizedBox(
            width: 62.w,
          ),
          popUpIcon,
        ],
      );
}
