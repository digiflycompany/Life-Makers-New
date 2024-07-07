import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/core/utils/app_routes.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/features/home_page/cubit/menu_page_cubit/menu_page_cubit.dart';
import 'package:life_makers/features/home_page/cubit/menu_page_cubit/menu_page_states.dart';

class CampaignsIcon extends StatelessWidget {
  const CampaignsIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuCubit, MenuState>(
      builder: (context, state) {
        final menuCubit = context.read<MenuCubit>();
        return Padding(
          padding: EdgeInsets.only(right: 15.7.w),
          child: Column(
            children: [
              InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  menuCubit.toggleCampaigns();
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 22.h),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(AppAssets.campaignsIcon),
                      SizedBox(
                        width: 11.w,
                      ),
                      Text(
                        AppStrings.campaigns,
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: FontFamilies.alexandria,
                            fontSize: 11.5.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      menuCubit.isVisible == false
                          ? InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          menuCubit.toggleCampaigns();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 2.h),
                          child: SvgPicture.asset(
                              AppAssets.dropDownWhiteIcon),
                        ),
                      )
                          : InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          menuCubit.toggleCampaigns();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 2.h),
                          child: SvgPicture.asset(
                              AppAssets.upArrowIcon),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              menuCubit.isVisible == true
                  ? SizedBox(
                height: 0.h,
              )
                  : SizedBox(
                height: 0.h,
              ),
              if (menuCubit.isVisible == true)
                Padding(
                  padding: EdgeInsets.only(right: 43.w,),
                  child: Column(
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        onTap: ()=>Navigator.pushNamed(context, Routes.seasonalCampaignsPageRoute, arguments: 1),
                        child: Row(
                          textDirection: TextDirection.rtl,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 14.h),
                              child: SvgPicture.asset(
                                  AppAssets.whitePoint),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            const Text(
                              AppStrings.seasonalCampaigns,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily:
                                  FontFamilies.alexandria,
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        onTap: ()=>Routes.nonSeasonalCampaignsPageRoute.moveTo,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          child: Row(
                            textDirection: TextDirection.rtl,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 3.h),
                                child: SvgPicture.asset(
                                    AppAssets.whitePoint),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              const Text(
                                AppStrings.noSeasonalCampaigns,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily:
                                    FontFamilies.alexandria,
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
