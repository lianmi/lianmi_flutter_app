import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lianmiapp/res/colors.dart';

class DividerWidget extends StatelessWidget{
  double padding;
  DividerWidget({this.padding = 0});

  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colours.text_gray_c,
      indent:  padding,
      endIndent: padding,
    );
  }

}