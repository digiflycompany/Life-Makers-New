import 'package:flutter/material.dart';

class LoginCircular extends StatelessWidget {
  const LoginCircular({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.scale(
          scale: 0.5,
          child: CircularProgressIndicator.adaptive())
    );
  }
}
