import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/features/home_page/cubit/emergency_campaigns_cubit.dart';
import 'package:life_makers/features/home_page/presentation/widgets/main_page_widgets/home_dots_indicator.dart';
import 'package:life_makers/features/home_page/presentation/widgets/main_page_widgets/news_sample.dart';
import 'package:life_makers/services/cubit/global_cubit_state.dart';

class UrgentCampaigns extends StatefulWidget {
  const UrgentCampaigns({super.key});

  @override
  State<UrgentCampaigns> createState() => _UrgentCampaignsState();
}

class _UrgentCampaignsState extends State<UrgentCampaigns> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom:10.h),
      child: SizedBox(
        height: 50.h,
        child: BlocBuilder<EmergencyCampaignsCubit, CubitBaseState>(
          builder: (context, state) {
            final emergencyCampaignsCubit = context.read<EmergencyCampaignsCubit>();
            if (state == CubitBaseState.done) {
              if (emergencyCampaignsCubit.emergencyCampaignModel?.campaigns?.isNotEmpty == true) {
                return Column(
                  children: [
                    Flexible(
                      child: PageView.builder(
                        reverse: true,
                        controller: _pageController,
                        itemCount: emergencyCampaignsCubit.emergencyCampaignModel?.campaigns?.length ?? 0,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        itemBuilder: (BuildContext context, int index) {
                          return NewsSample(
                            campaigns: emergencyCampaignsCubit.emergencyCampaignModel?.campaigns![index],
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    HomeDotsIndicator(
                      length: emergencyCampaignsCubit.emergencyCampaignModel?.campaigns?.length ?? 0,
                      currentPage: _currentPage,
                    ),
                  ],
                );
              } else {
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.greyColor7,
                    borderRadius: BorderRadius.circular(7.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(AppAssets.emptyIcon,width: 22.w,),
                        SizedBox(width: 5.w,),
                        Text(
                          AppStrings.noUrgentCampaigns,
                          maxLines: 2,
                          textDirection: TextDirection.rtl,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: FontFamilies.alexandria,
                            fontWeight: FontWeight.w400,
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            } else if (state == CubitBaseState.loading) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
