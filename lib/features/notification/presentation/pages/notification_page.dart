import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_cubit.dart';
import 'package:life_makers/features/authentication/cubit/sign_up_cubit/sign_up_states.dart';
import 'package:life_makers/features/notification/presentation/widgets/no_notifications_icon.dart';
import 'package:life_makers/features/notification/presentation/widgets/notification_list.dart';
import 'package:life_makers/features/notification/presentation/widgets/notification_loading.dart';
import 'package:life_makers/features/notification/presentation/widgets/notification_title.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';

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
                NotificationTitle(),
                if (state is NotificationsLoading && !PreferencesHelper.getIsVisitor)...[const NotificationLoading(),],
                if (state is NotificationSuccessfully)...[const NotificationList(),],
                if(state is NotificationSuccessfully && signUpCubit.notificationModel?.notifications?.length==0)...[const NoNotificationIcon()],
              ],
            ),
          ),
        );
      },
    );
  }
}
