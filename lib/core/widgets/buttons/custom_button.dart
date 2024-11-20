import 'package:flutter/material.dart';
import 'package:progress_soft_app/core/helper/colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double? paddingHorizontal;
  final double? paddingVertical;
  final Color? backgroundColor;
  final double? borderRadius;

  const CustomElevatedButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.paddingHorizontal,
    this.paddingVertical,
    this.backgroundColor,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal ?? 118.0,
          vertical: paddingVertical ?? 16.0,
        ),
        backgroundColor: backgroundColor ?? AColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 20.0),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
