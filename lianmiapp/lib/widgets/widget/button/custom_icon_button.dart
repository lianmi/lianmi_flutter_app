import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final double width;

  final double height;

  final String? icon;

  final double? iconWidth;

  final double? iconHeight;

  final Widget? iconWidget;

  final AlignmentGeometry? alignment;

  final Function()? onTap;

  CustomIconButton(
    {
      required this.width, 
      required this.height, 
      this.icon, 
      this.iconWidget,
      this.iconWidth,
      this.iconHeight,
      this.alignment,
      this.onTap
    }
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: alignment??Alignment.center,
        child: iconWidget != null ? iconWidget : Image.asset(
          icon??'',
          width: iconWidth,
          height: iconHeight,
        ),
      ),
    );
  }
}