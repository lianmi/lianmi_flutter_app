import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lianmiapp/res/colors.dart';
import 'package:lianmiapp/res/styles.dart';

class CircleButton extends StatelessWidget{
  Function onTap;
  String text;
  Color? color;
  double? width;
  double? height;
  CircleButton({
    required this.onTap,
    required this.text,
    this.color,
    this.width,
    this.height
  });

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap();
      },
      child: Container(
        width: width ?? 100,
        height: height ?? 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color ?? Colours.app_main,
            borderRadius: BorderRadius.circular(30)
        ),
        child: Text(text,
          style: TextStyles.font14(color: Colors.white),),
      ),
    );
  }
}