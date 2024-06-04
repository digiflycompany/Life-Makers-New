import 'package:flutter/material.dart';

class CardCircularProgressIndicator extends StatelessWidget {
  const CardCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.6,
      child: CircularProgressIndicator.adaptive(
      ),
    );
  }
}
