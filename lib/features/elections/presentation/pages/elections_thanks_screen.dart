import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:life_makers/core/utils/app-assets.dart';
import 'package:life_makers/core/utils/app-string.dart';
import 'package:life_makers/core/utils/app_fonts.dart';
import 'package:life_makers/core/utils/extensions.dart';
import 'package:life_makers/features/elections/presentation/widgets/save_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ElectionsThanksScreen extends StatefulWidget {
  const ElectionsThanksScreen({super.key});

  @override
  State<ElectionsThanksScreen> createState() => _ElectionsThanksScreenState();
}

class _ElectionsThanksScreenState extends State<ElectionsThanksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Screenshot(
        controller: screenshotController,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              thanksImage,
              thanksText,
              SizedBox(height: 80.h),
              SaveButton(
                  onTap: () {
                    takeScreenShot();
                  },
                  text: AppStrings.save)
            ],
          ),
        ),
      ),
    );
  }

  get thanksImage => Center(
          child: Padding(
        padding: EdgeInsets.only(top: 138.h),
        child: Image.asset(AppAssets.thanksImg),
      ));
  get thanksText => Text(
        AppStrings.electionsThanksText,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontFamily: FontFamilies.alexandria,
          fontWeight: FontWeight.w400,
          height: 1.9.h,
        ),
      );
  ScreenshotController screenshotController = ScreenshotController();
  Uint8List? image;
  Future<void> takeScreenShot() async {
    await screenshotController
        .capture(delay: const Duration(milliseconds: 100))
        .then((Uint8List? image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/image.png').create();
        await imagePath.writeAsBytes(image);

        await Share.shareXFiles(
          [XFile(imagePath.path)],
        );
      }
    });
  }
}
