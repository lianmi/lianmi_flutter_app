import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lianmiapp/res/colors.dart';

class CommonButton extends StatelessWidget {
  final double? width;

  final double? height;

  final EdgeInsetsGeometry? margin;

  final double? borderRadius;

  final Color? borderColor;

  final Color? color;

  final String? text;

  final double? fontSize;

  final Color? textColor;

  final BoxShadow? boxShadow;

  final Function? onTap;

  CommonButton({
    this.width,
    this.height,
    this.margin,
    this.borderRadius,
    this.borderColor,
    this.color,
    this.boxShadow,
    this.text,
    this.fontSize,
    this.textColor,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(onTap != null) onTap!();
      },
      child: Container(
        margin: margin,
        width: width??double.infinity,
        height: height??double.infinity,
        decoration: BoxDecoration(
          color: color ?? Colours.app_main,
          borderRadius: BorderRadius.circular(borderRadius??4),
          border: Border.all(width: 1, color: borderColor??Colors.transparent),
          boxShadow: boxShadow != null?[boxShadow!]:[]
        ),
        alignment: Alignment.center,
        child: Text(
          text??'',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize??12,
            color: textColor??Colors.white,
          ),
          strutStyle: StrutStyle(
            forceStrutHeight: true, 
          ),
        ),
      ),
    );
  }
}