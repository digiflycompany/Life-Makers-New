import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';

class UserQR extends StatelessWidget {
  const UserQR({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 17.h,
      left: 17.w,
      child: InkWell(
          onTap: () {
            if (!PreferencesHelper.getIsVisitor)
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(10.r),
                      ),
                      content: Container(
                        decoration: BoxDecoration(
                          color: AppColors.blueColor,
                          borderRadius:
                          BorderRadius.circular(10.r),
                        ),
                        padding:
                         EdgeInsets.only(top: 30.h),
                        // margin: const EdgeInsets.only(bottom: 22),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 150.w,
                              height: 150.h,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius.circular(
                                      10.r)),
                              child: SvgPicture.network(
                                  '${PreferencesHelper.getUserModel?.user.qrCode}'),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                Text(
                                  AppStrings.scanHere,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontFamily:
                                    FontFamilies.alexandria,
                                    color: Colors.white,
                                    fontWeight:
                                    FontWeight.w400,
                                  ),
                                ),
                                SvgPicture.asset(
                                    AppAssets.tieSvg),
                              ],
                            ),
                            SizedBox(height: 14.h),
                          ],
                        ),
                      ),
                    );
                  });
          },
          child: SvgPicture.asset(
            AppAssets.qrCode2,
          )),
    );
  }
}
