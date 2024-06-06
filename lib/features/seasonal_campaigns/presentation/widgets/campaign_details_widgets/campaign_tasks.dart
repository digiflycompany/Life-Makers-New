import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/features/seasonal_campaigns/model/seasonal_campaigns_model.dart';

class CampaignTasks extends StatelessWidget {
  final Campaigns? campaignDetails;
  const CampaignTasks({super.key, required this.campaignDetails});

  @override
  Widget build(BuildContext context) {
    final tasks = campaignDetails!.tasks!.where((e) => e.details?.isNotEmpty == false).toList();

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5.h),
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
            child: Text(
              '${task.task?.name}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
                fontFamily: FontFamilies.alexandria,
              ),
            ),
          ),
        );
      },
    );
  }
}
