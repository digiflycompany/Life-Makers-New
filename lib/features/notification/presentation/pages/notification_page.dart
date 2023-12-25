import 'package:flutter/material.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/features/notification/presentation/widgets/notification_widget.dart';
import '../../../../core/utils/app-assets.dart';
import '../../../../core/utils/app-string.dart';
import '../../../../core/widgets/title_text.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child:Column(
          children: [
            SizedBox(height: 17.h,),
            header,
            SizedBox(height: 20.h,),
            // notificationList,
          ],
        ),
      ),
    );
  }
  get header => title;
  get title => Center(
    child: TitleText(
        text: AppStrings.notifications),
  );
  get notifications => Padding(
    padding:  EdgeInsets.symmetric(vertical: 7.h),
    child: const NotificationWidget(img: AppAssets.notificationImg, description: AppStrings.notificationText, time: AppStrings.hourAgo),
  );
  get notificationList => Expanded(
    child: ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return notifications;
      },
    ),
  );

}
