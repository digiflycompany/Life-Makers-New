import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/core/widgets/custom_appbar.dart';
import 'package:life_makers/features/campaign_details/cubit/join_campaign_cubit.dart';
import 'package:life_makers/features/campaign_details/presentation/pages/member_campaign_details.dart';
import 'package:life_makers/features/home_page/presentation/widgets/news_button.dart';
import 'package:life_makers/services/cubit/global_cubit_state.dart';
import '../../../../core/utils/app-color.dart';
import '../../../../core/utils/app-string.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../seasonal_campaigns/model/seasonal_campaigns_model.dart';

class ChooseRoleSecondPage extends StatefulWidget {
  ChooseRoleSecondPage(
      {super.key, required this.selectedRoleId, required this.campaignDetails});

  final int selectedRoleId;
  final Campains? campaignDetails;
  @override
  State<ChooseRoleSecondPage> createState() => _ChooseRoleSecondPageState();
}

class _ChooseRoleSecondPageState extends State<ChooseRoleSecondPage> {
  late JoinCampaignCubit joinCampaignCubit;
  @override
  void initState() {
    super.initState();
    joinCampaignCubit = context.read<JoinCampaignCubit>();
  }

  bool dataEntry = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          50.h,
        ),
        child: CustomAppBar('طلب انضمام للحملة'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              headerImage,
              SizedBox(height: 30.h),
              title,
              SizedBox(height: dataEntry == true ? 25.h : 470.h),
              if (dataEntry == true)
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: widget.campaignDetails!.tasks!.where((element) =>
                      element.id==widget.selectedRoleId)
                          .map(
                            (e) => Column(
                              children: e.details!.map((e) => CheckboxMenuButton(
                                value: true,
                                onChanged: (v) {},
                                child: SizedBox(
                                  width: 240.w,
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                      fontFamily: 'Alexandria',
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ),).toList(),
                            )
                          )
                          .toList(),
                    ),
                  ),
                ),
              SizedBox(
                height: dataEntry == true ? 98.h : 0.h,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: button,
    );
  }

  get headerImage => Image.network(widget.campaignDetails!.photo!,
      fit: BoxFit.cover, width: double.infinity, height: 200.h);
  get showMoreButton => GestureDetector(
        onTap: () {
          setState(() {
            dataEntry = !dataEntry;
          });
        },
        child: CircleAvatar(
          radius: 11.r,
          backgroundColor: AppColors.orangeBorderColor,
          child: dataEntry == false
              ? SvgPicture.asset(
                  AppAssets.plusIcon,
                  width: 12.w,
                )
              : SvgPicture.asset(
                  AppAssets.cancelIcon,
                  width: 10.w,
                ),
        ),
      );
  get titleText => Text(
        ' ${widget.campaignDetails?.name}',
        style: TextStyle(
            color: Colors.black,
            fontFamily: FontFamilies.alexandria,
            fontWeight: FontWeight.w500,
            fontSize: 12),
      );
  get title => Padding(
        padding: EdgeInsets.only(right: 35.w),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            showMoreButton,
            SizedBox(width: 10.w),
            titleText,
          ],
        ),
      );
  get button => Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      child: SizedBox(
        width: 380.w,
        height: 60.h,
        child: BlocConsumer<JoinCampaignCubit, CubitBaseState>(
          listener: (_, state) {
            if (state == CubitBaseState.doneJoinCampaign) {
              showJoinCampaignSuccessPoUp(context);
            }
          },
          builder: (_, state) {
            if (state == CubitBaseState.loading) {
              return Center(child: CircularProgressIndicator.adaptive());
            }
            return NewsButton2(
                onTap: () {
                  joinCampaignCubit.joinCampaign(
                      taskId: widget.selectedRoleId, context: context);
                },
                text: AppStrings.joinCampaign);
          },
        ),
      ));
  void showJoinCampaignSuccessPoUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7.r))),
            insetPadding: const EdgeInsets.all(26),
            scrollable: true,
            titlePadding: const EdgeInsets.all(0),
            contentPadding: EdgeInsets.zero,
            content: Container(
              height: 260.h,
              width: 360.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    AppStrings.requestRegistered,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      fontFamily: FontFamilies.alexandria,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                  SvgPicture.asset(
                    AppAssets.successIcon,
                    width: 100.w,
                  ),
                  const Text(
                    AppStrings.waitForApproval,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      fontFamily: FontFamilies.alexandria,
                    ),
                    textDirection: TextDirection.rtl,
                  ),
                ],
              ),
            ));
      },
    );
    Future.delayed(const Duration(seconds: 2), () {
      // Close the popup
      Navigator.pop(context);

      // Navigate to another screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>
            JoinCampaignDetails(taskId: widget.selectedRoleId,

            campaignDetails: widget.campaignDetails)),
      );
    });
  }

}
