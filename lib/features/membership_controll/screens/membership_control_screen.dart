import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/core/widgets/custom_snack_bar.dart';
import '../../../core/utils/app-assets.dart';
import '../../../core/utils/app-color.dart';

class MembershipControl extends StatefulWidget {
  const MembershipControl({Key? key}) : super(key: key);

  @override
  State<MembershipControl> createState() => _MembershipControlState();
}

class _MembershipControlState extends State<MembershipControl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 300),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(AppAssets.unionGreyImg,
                width: double.infinity, fit: BoxFit.fill),
            const Padding(
              padding: EdgeInsets.only(top: 0, bottom: 10),
              child: Text('ظبط العضوية',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Alexandria')),
            ),
            Positioned(
              top: 38,
              right: 6,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding:  EdgeInsets.all(20.w),
                  child: SvgPicture.asset(AppAssets.popUpIcon),
                ),
              ),
            ),

          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Image.asset(
            'assets/images/img.png',
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 60,
              bottom: 26,
              left: 25,
              right: 25,
            ),
            child: Text(
              'شروط للحصول على عضوية',
              style: TextStyle(
                fontFamily: 'Alexandria',
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'بعد مرور 3 شهور من تطوعك وتحقيق 30% من انجازاتك',
                  style: TextStyle(
                    color: Color(0xffBDBDBD),
                    fontFamily: 'Alexandria',
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 10),
                SvgPicture.asset(
                  'assets/svg/circleIcon.svg',
                  // ignore: deprecated_member_use
                  color: AppColors.orangeBorderColor,
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 24, bottom: 73, left: 25, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'بعد تحقيق 70% من الحملات المشترك بها',
                  style: TextStyle(
                    color: Color(0xffBDBDBD),
                    fontFamily: 'Alexandria',
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 10),
                SvgPicture.asset('assets/svg/circleIcon.svg'),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'لا يشترط تحقيق الشرطين',
                style: TextStyle(
                  color: Color(0xffBDBDBD),
                  fontFamily: 'Alexandria',
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 10),
              Icon(Icons.info_outline),
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 22),
              child: ElevatedButton(
                onPressed: () {
                 CustomSnackBars.showErrorToast(title: 'لم يتم تحقيق الشروط');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  minimumSize: const Size(95, 35),
                  elevation: 0,
                ),
                child: const Text(
                  'كن عضوا',
                  style: TextStyle(
                    fontSize: 11,
                    fontFamily: FontFamilies.alexandria,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
