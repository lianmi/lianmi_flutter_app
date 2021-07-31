import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lianmiapp/res/colors.dart';
import 'package:lianmiapp/res/styles.dart';
import 'package:lianmiapp/res/view_standard.dart';

class CircleBigButton extends StatelessWidget{
  Function onTap;
  String text;
  Color? color;

  CircleBigButton({
    required this.onTap,
    required this.text,
    this.color
  });
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        width: double.infinity,
        height: ViewStandard.widgetHeight,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color ?? Colours.app_main,
          borderRadius: BorderRadius.circular(30)
        ),
        child: Text(text,
          style: TextStyles.font17(color: Colors.white),),
      ),
    );
  }
}