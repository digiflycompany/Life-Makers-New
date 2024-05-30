import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-color.dart';
import 'package:life_makers/core/utils/extensions.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown(
      {super.key,
      this.data,
      required this.items,
      required this.onChange,
      required this.hint});

  final dynamic data;
  final List<DropdownMenuItem<dynamic>> items;
  final Function onChange;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.blueColor7),
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Padding(
              padding: EdgeInsets.only(right: context.width16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                textDirection: TextDirection.rtl,
                children: [
                  SvgPicture.asset(
                    AppAssets.locationIcon,
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(
                    width: context.width8,
                  ),
                  Container(
                    width: 2.w,
                    height: context.height20,
                    color: AppColors.blueColor,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: DropdownButtonFormField2<dynamic>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(0, 26.h, 0, 0),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                  ),
                  hint: Text(
                    hint,
                    style: TextStyle(
                      color: AppColors.blueColor6,
                      fontSize: 10.sp,
                    ),
                  ),
                  items: items,
                  validator: (value) {
                    if (value == null) {
                      return 'Please select one';
                    }
                    return null;
                  },
                  onChanged: (cityName) {
                    onChange(cityName);
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(left: 8),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black45,
                    ),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: 200.w,
                    elevation: 0,
                    padding: EdgeInsets.only(right: 0.w),
                    decoration: BoxDecoration(
                      // color: AppColors.gray1,
                      border: Border.all(color: AppColors.blueColor7),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    offset: const Offset(0, -5),
                  ),
                  menuItemStyleData: MenuItemStyleData(
                    padding: EdgeInsets.only(right: context.width16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
