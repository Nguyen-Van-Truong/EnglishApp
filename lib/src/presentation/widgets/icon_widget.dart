import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final double size;
  final BoxFit fit;

  const AppIcon({Key? key, this.size = 24.0, this.fit = BoxFit.cover}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'lib/res/assets/icon_app/icon_Grade_Writing_Exam.png',
      width: size,
      height: size,
      fit: fit,
    );
  }
}