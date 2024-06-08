import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/features/home_page/cubit/home_calender_cubit.dart';
import 'package:life_makers/features/home_page/presentation/widgets/main_page_widgets/home_calendatr_item.dart';
import 'package:life_makers/services/cubit/global_cubit_state.dart';

class HomeCalendar extends StatelessWidget {
  const HomeCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.h),
      child: BlocBuilder<HomeCalenderCubit, CubitBaseState>(
          builder: (context, state) {
        final homeCalenderCubit = context.read<HomeCalenderCubit>();
        if (state == CubitBaseState.done) {
          return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: homeCalenderCubit.homeCalenderModel?.calender?.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return HomeCalenderItem(
                    calender:
                        homeCalenderCubit.homeCalenderModel?.calender?[index]);
              });
        } else if (state == CubitBaseState.loading) {
          return Center(child: CircularProgressIndicator.adaptive());
        }
        return SizedBox.shrink();
      }),
    );
  }
}
