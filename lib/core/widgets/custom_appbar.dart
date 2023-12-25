import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/core/widgets/title_text.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(  this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      title: TitleText(text: text),
      centerTitle: true,
      actions: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Container(
                width: 30.w,
                height: 30.h,
                child: Transform.scale(
                    scale: 0.35,
                    child: SvgPicture.asset(AppAssets.popUpIcon,))),
          ),
        ),
      ],
    );
  }
}
