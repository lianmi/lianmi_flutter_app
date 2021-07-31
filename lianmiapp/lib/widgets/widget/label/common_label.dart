import 'package:flutter/material.dart';

class CommonLabel extends StatelessWidget {
  final double? width;

  final double? height;

  final String? text;

  final double? fontSize;

  final Color? color;

  final AlignmentGeometry? alignment;

  CommonLabel(this.text, {Key? key,this.width, this.height, this.fontSize, this.color, this.alignment}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width??double.infinity,
      height: height??double.infinity,
      alignment: alignment??Alignment.center,
      child: Text(
        text!,
        style: TextStyle(
          fontSize: fontSize,
          color: color
        ),
      ),
    );
  }
}