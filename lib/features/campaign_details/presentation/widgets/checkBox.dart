import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/app-color.dart';
import '../../../../core/utils/app-string.dart';
import '../../../../core/utils/app_fonts.dart';

class CustomCheckBox extends StatefulWidget {
  final bool value;
  final void Function(bool?)? onChanged;
  const CustomCheckBox({super.key, required this.value, required this.onChanged});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: Checkbox(
            value: widget.value,
            onChanged:widget.onChanged,
            activeColor: AppColors.orangeBorderColor,
            focusColor: Colors.white,
            side: const BorderSide(width: 1.0, color: AppColors.checkBoxColor),
          ),
        ),
        SizedBox(width: 10.w,),
        const Text(
          AppStrings.checkBoxText,
          style: TextStyle(
              color: Colors.black,
              fontFamily: FontFamilies.alexandria,
              fontWeight: FontWeight.w300,
              fontSize: 9
          ),
        ),
      ],
    );
  }
}
