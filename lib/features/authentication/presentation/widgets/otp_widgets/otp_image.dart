import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/extensions.dart';

class OtpImage extends StatelessWidget {
  const OtpImage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(child: Padding(
      padding:  EdgeInsets.only(bottom:context.height12),
      child: SvgPicture.asset(AppAssets.forgotPassword),
    ));
  }
}
