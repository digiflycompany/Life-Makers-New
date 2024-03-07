import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';

class EnterPhoneImage extends StatelessWidget {
  const EnterPhoneImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: SvgPicture.asset(AppAssets.forgotPassword));
  }
}
