import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/app_routes.dart';
import 'package:life_makers/features/home_page/cubit/home_calender_cubit.dart';
import 'package:life_makers/features/home_page/data/models/home_calender_model.dart';
import 'package:life_makers/features/home_page/presentation/widgets/main_page_widgets/calendar_date.dart';
import 'package:life_makers/features/home_page/presentation/widgets/main_page_widgets/calendar_text.dart';
import 'package:life_makers/services/cubit/global_cubit_state.dart';

class HomeCalenderItem extends StatelessWidget {
  final Calender? calender;

  const HomeCalenderItem({
    Key? key,
    required this.calender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCalenderCubit, CubitBaseState>(
      builder: (context, state) {
        return InkWell(
          splashColor: AppColors.transparent,
          highlightColor: AppColors.transparent,
          onTap: () {
            if (calender != null && calender!.date != null) {
              final today = DateTime.now();
              final calendarDate = DateTime.parse(calender!.date!);

              if (calendarDate.isSameDate(today)) {
                Navigator.pushNamed(context, Routes.seasonalCampaignsPageRoute, arguments: 1);
              } else if (calendarDate.isAfter(today)) {
                Navigator.pushNamed(context, Routes.seasonalCampaignsPageRoute, arguments: 2);
              }
            }
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8.h),
            height: 85.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CalendarDate(calender: calender),
                CalendarText(calender: calender),
              ],
            ),
          ),
        );
      },
    );
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
