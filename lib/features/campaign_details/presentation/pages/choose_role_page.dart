import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/core/widgets/custom_snack_bar.dart';
import 'package:life_makers/features/campaign_details/presentation/pages/choose_role_second_page.dart';
import 'package:life_makers/features/home_page/cubit/seasonal_campaigns/model/seasonal_campaigns_model.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../core/utils/app-assets.dart';
import '../../../../core/utils/app-color.dart';
import '../../../../core/utils/app-string.dart';
import '../../../../core/utils/app_fonts.dart';
import '../widgets/choose_role_button.dart';

class ChooseRolePage extends StatefulWidget {
    ChooseRolePage({super.key, this.campaignDetails});
  final Campains? campaignDetails;

  @override
  State<ChooseRolePage> createState() => _ChooseRolePageState();
}

class _ChooseRolePageState extends State<ChooseRolePage> {
  int? selectedId;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400.h,
      width: 435.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.r),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 55,
            decoration: BoxDecoration(
                color: AppColors.orangeBorderColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(7.r),
                  topRight: Radius.circular(7.r),
                )),
            child: Stack(
              textDirection: TextDirection.rtl,
              children: [
                const Center(
                  child: Text(
                    AppStrings.chooseTheRole,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      fontFamily: FontFamilies.alexandria,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: Padding(
                        padding: EdgeInsets.only(right: 16.w, top: 24.h),
                        child: SvgPicture.asset(AppAssets.closeDrawerICon),
                      )),
                )
              ],
            ),
          ),
          SizedBox(
            height: 250.h,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisExtent: 40.h),
                itemBuilder: (context, index) {
                  return RadioMenuButton(
                      value: widget.campaignDetails?.tasks?[index].id,
                      groupValue: selectedId,
                      onChanged: (val) {
                        setState(() {
                          selectedId =
                          widget.campaignDetails?.tasks![index].id!;
                          if (kDebugMode) {
                            print(selectedId);
                          }
                        });
                      },
                      child: Text(
                        '${widget.campaignDetails?.tasks?[index].task?.name}',style: TextStyle(
                          fontFamily: 'Alexandria'
                      ),));
                },
                itemCount: widget.campaignDetails?.tasks?.length,
                shrinkWrap: true,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: ChooseButton(
                onTap: () {
                  if(selectedId==null)
                  {
                    CustomSnackBars.showInfoSnackBar(title: 'قم باختيار مهمة للحملة');
                  }
                  else {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        duration: const Duration(milliseconds: 500),
                        child: ChooseRoleSecondPage(
                          selectedRoleId: selectedId!,
                          campaignDetails: widget.campaignDetails,
                        ),
                      ),
                    );
                  }
                },
                text: AppStrings.choose),
          ),
        ],
      ),
    );
  }
}
