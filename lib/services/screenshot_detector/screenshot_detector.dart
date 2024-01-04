import 'package:flutter/material.dart';

class ScreenshotDetector extends StatefulWidget {
  final Widget child;

  ScreenshotDetector({required this.child});

  @override
  _ScreenshotDetectorState createState() => _ScreenshotDetectorState();
}

class _ScreenshotDetectorState extends State<ScreenshotDetector> with WidgetsBindingObserver {
  bool isObscured = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App returned to the foreground
      setState(() {
        isObscured = false;
      });
    } else if (state == AppLifecycleState.paused) {
      // App went into the background
      setState(() {
        isObscured = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (isObscured)
          Container(
            color: Colors.black, // You can use any color or widget to obscure the content
          ),
      ],
    );
  }
}
