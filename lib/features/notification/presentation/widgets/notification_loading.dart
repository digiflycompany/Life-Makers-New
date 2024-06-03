import 'package:flutter/material.dart';

class NotificationLoading extends StatelessWidget {
  const NotificationLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Center(child: CircularProgressIndicator.adaptive()));
  }
}
