import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/extensions.dart';

class LoginImage extends StatelessWidget {
  const LoginImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: AlignmentDirectional.center,
        child: Padding(
          padding: EdgeInsets.only(top:context.height48,bottom: context.height32),
          child: SvgPicture.asset(AppAssets.logoFinalSvg),
        ));
  }
}
