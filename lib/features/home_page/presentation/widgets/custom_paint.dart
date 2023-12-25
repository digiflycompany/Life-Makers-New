import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:life_makers/core/utils/extensions.dart';
import '../../../../core/utils/app-color.dart';

class ButtonNotch extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var dotPoint = Offset(size.width / 2, 2);

    var paint_1 = Paint()
      ..color = AppColors.backgroundColor
      ..style = PaintingStyle.fill;
    var paint_2 = Paint()
      ..color = AppColors.blueColor
      ..style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, 0);
    path.quadraticBezierTo(3, 0, 12, 10); // Adjusted control point
    path.quadraticBezierTo(size.width / 2, size.height / 2, size.width - 12, 10);
    path.quadraticBezierTo(size.width - 3, 0, size.width, 0); // Adjusted control point
    path.close();

    //canvas.drawShadow(path, Colors.black.withOpacity(0.5), -1, false);

    canvas.drawPath(path, paint_1);
    canvas.drawCircle(dotPoint, 5.r, paint_2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}