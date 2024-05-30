import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/notification/presentation/widgets/notification_widget.dart';
import '../../../../core/utils/app-assets.dart';
import '../../../../core/utils/app-string.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/widgets/title_text.dart';
import '../../../../services/shared_preferences/preferences_helper.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late SignUpCubit signUpCubit;

  @override
  void initState() {
    signUpCubit = context.read<SignUpCubit>();
    signUpCubit.GetUserNotifications();
    super.initState();
  }

  Future<void> _refresh() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      await signUpCubit.GetUserNotifications();
    } catch (error) {
      if (kDebugMode) {
        print('Error refreshing data: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.whiteColor3,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 17.h),
                header,
                SizedBox(height: 20.h),
                if (state is NotificationsLoading && !PreferencesHelper.getIsVisitor)
                   Expanded(child: Center(child: CircularProgressIndicator.adaptive())),
                if (state is NotificationSuccessfully)
                   Expanded(
                    child: RefreshIndicator.adaptive(
                      onRefresh: _refresh,
                      color: Colors.white,
                      backgroundColor: AppColors.orangeColor,
                      child: Padding(
                        padding:  EdgeInsets.only(bottom: 100.h),
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: signUpCubit.notificationModel?.notifications?.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 7.h,),
                              child: NotificationWidget(
                                img: AppAssets.messageImage,
                                description: "${signUpCubit.notificationModel?.notifications![index].title}",
                                time: "${signUpCubit.notificationModel?.notifications![index].updatedAt}",
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                if(state is NotificationSuccessfully && signUpCubit.notificationModel?.notifications?.length==0)
                   Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(AppAssets.noCampaignsImg),
                        SizedBox(height: 30.h),
                        const Text(
                          'لا توجد اشعارات',
                          style: TextStyle(
                            color: AppColors.greyColor4,
                            fontFamily: FontFamilies.alexandria,
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget get header => title;

  Widget get title => Center(
    child: TitleText(text: AppStrings.notifications),
  );
}

// ... Other widget classes if needed

