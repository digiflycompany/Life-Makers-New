import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/extensions.dart';

class ChangePasswordImage extends StatelessWidget {
  const ChangePasswordImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.height51),
      child: Center(child: SvgPicture.asset(AppAssets.changePassword)),
    );
  }
}
