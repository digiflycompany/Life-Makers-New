import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/widgets/spacer.dart';
import 'package:life_makers/features/home_page/cubit/menu_page_cubit/menu_page_cubit.dart';
import 'package:life_makers/features/home_page/cubit/menu_page_cubit/menu_page_states.dart';
import 'package:life_makers/features/home_page/presentation/widgets/menu_page_widgets/campaigns_icon.dart';
import 'package:life_makers/features/home_page/presentation/widgets/menu_page_widgets/close_drawer_icon.dart';
import 'package:life_makers/features/home_page/presentation/widgets/menu_page_widgets/edit_account_icon.dart';
import 'package:life_makers/features/home_page/presentation/widgets/menu_page_widgets/elections_candidate_icon.dart';
import 'package:life_makers/features/home_page/presentation/widgets/menu_page_widgets/elections_icon.dart';
import 'package:life_makers/features/home_page/presentation/widgets/menu_page_widgets/login_icon.dart';
import 'package:life_makers/features/home_page/presentation/widgets/menu_page_widgets/logout_icon.dart';
import 'package:life_makers/features/home_page/presentation/widgets/menu_page_widgets/mentorship_edit_icon.dart';
import 'package:life_makers/features/home_page/presentation/widgets/menu_page_widgets/profile_icon.dart';
import 'package:life_makers/features/home_page/presentation/widgets/menu_page_widgets/volunteer_opp_icon.dart';
import 'package:life_makers/services/shared_preferences/preferences_helper.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late final DateTime apiStartDate;
  late final DateTime apiEndDate;
  DateTime? startTime;
  DateTime? endTime;

  late MenuCubit menuCubit;
  @override
  void initState() {
    super.initState();
    menuCubit = context.read<MenuCubit>();
    menuCubit.fetchDateAndTime().then((value) {
      String? apiStartDateString =
          menuCubit.appSettingsModel?.data?.electionsStartDate;
      String? apiEndDateString =
          menuCubit.appSettingsModel?.data?.electionsEndDate;
      if (kDebugMode) {
        print(apiEndDateString);
        print('***** DATE *****');
        print(apiEndDateString);
      }
      if (apiStartDateString != null && apiEndDateString != null) {
        startTime = DateTime.parse(apiStartDateString);
        endTime = DateTime.parse(apiEndDateString);
      }
    });
    if (kDebugMode) {
      print('$startTime');
      print('$endTime');
    }
  }

  @override
  void dispose() {
    startTime = DateTime.now();
    endTime = DateTime.now();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuCubit, MenuState>(
      listener: (context, state) {
        if (state is DeleteAccountSuccess) {
          PreferencesHelper.logOut();
        } else if (state is DeleteAccountFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
            duration: Duration(seconds: 2),
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: AppColors.blueColor,
            body: SafeArea(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    const CloseDrawerIcon(),
                    if (!PreferencesHelper.getIsVisitor) ...[
                      VerticalSpace(20.h),
                    ],
                    if (!PreferencesHelper.getIsVisitor) ...[
                      const MentorShipEditIcon(),
                    ],
                    VerticalSpace(20.h),
                    if (!PreferencesHelper.getIsVisitor) ...[
                      const ProfileIcon(),
                      const EditAccountIcon(),
                    ],
                    const CampaignsIcon(),
                    const VolunteerOppIcon(),
                    const ElectionsCandidateIcon(),
                    if (!PreferencesHelper.getIsVisitor) const ElectionsIcon(),
                    SizedBox(
                        height: menuCubit.isVisible == false ? 30.h : 20.h),
                    if (!PreferencesHelper.getIsVisitor) ...[
                      const LogoutIcon(),
                    ],
                    if (PreferencesHelper.getIsVisitor) ...[
                      const LoginIcon(),
                    ],
                    VerticalSpace(
                      50.h,
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
