import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/notification/presentation/widgets/notification_widget.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  late SignUpCubit signUpCubit;

  @override
  void initState() {
    signUpCubit = context.read<SignUpCubit>();
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
    return Expanded(
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
    );
  }
}
