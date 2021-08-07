import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  final String? text;

  final double? fontSize;

  final Color? color;

  final int? maxLines;

  CommonText(this.text,
      {Key? key, this.fontSize, this.color, this.maxLines = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: TextStyle(fontSize: fontSize, color: color),
    );
  }
}
