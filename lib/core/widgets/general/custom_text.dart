import 'package:flutter/material.dart';
import 'package:progress_soft_app/core/servise_network/get_device_type.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color? color;
  final String fontFamily;
  final FontWeight fontWeight;
  final TextDecoration textDecoration;
  final TextAlign textAlign;
  final int maxLines;
  final TextOverflow? textOverflow;
  final TextDirection textDirection;
  final List<Shadow>? shadows;

  const CustomText({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.color,
    this.textAlign = TextAlign.start,
    this.fontFamily = 'SF Pro Display',
    this.fontWeight = FontWeight.w500,
    this.textDecoration = TextDecoration.none,
    this.maxLines = 5,
    this.textOverflow,
    this.textDirection = TextDirection.ltr,
    this.shadows,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTaplet = checkDeviceTaplet(context);
    Color defaultColor = color ?? Theme.of(context).colorScheme.tertiary;
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: textOverflow,
      textDirection: textDirection,
      style: TextStyle(
        fontFamily: fontFamily,
        decoration: textDecoration,
        shadows: shadows,
        fontSize: (isTaplet ? (fontSize - 2) : fontSize),
        color: defaultColor,
        fontWeight: fontWeight,
      ),
    );
  }
}
