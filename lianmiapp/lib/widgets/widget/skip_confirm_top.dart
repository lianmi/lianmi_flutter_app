import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lianmiapp/res/colors.dart';
import 'package:lianmiapp/res/styles.dart';

class SkipConfirmTop extends StatelessWidget{
  ///右键字符
  String rightText;
  ///右键事件
  Function? rightTap;
  ///右键颜色
  Color? rightColor; ///右键颜色
  ///标题
  String title;
  ///高度
  double? height;
  ///是否有右键
  bool hasRight;
  ///是否有左键
  bool hasLeft;
  ///是否有top
  bool hasTop;
  ///右键widget
  Widget? rightWidget;
  Color? fontColor;

  SkipConfirmTop({this.rightText = '跳过',
    this.rightColor,
    this.rightWidget,
    this.height,
    this.hasLeft = true,
    this.hasRight = true,
    this.rightTap,
    this.hasTop = true,
    this.fontColor,
    this.title = ''}
    );
  Widget build(BuildContext context) {
    double _top = MediaQuery.of(context).padding.top;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: hasTop ? _top : 0,),
        Container(
          height: height ?? 44,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              hasLeft ? GestureDetector(
                child: Container(
                  width: height ?? 44,
                  height: height ?? 44,
                  color: Colors.transparent,
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: fontColor ?? Colours.text,
                    size: 16,
                  ),
                ),
                onTap: (){
                  Navigator.of(context).pop();
                }
              ): SizedBox(width: height ?? 44,),
              Expanded(
                child: Container(
                  width: 100,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: Text(title, style: TextStyles.font20(color: fontColor ?? Colours.text),),
                )
              ),
              hasRight ? GestureDetector(
                child: rightWidget != null ? Container(
                  width: height ?? 44,
                  height: height ?? 44,
                  color: Colors.transparent,
                  alignment: Alignment.centerRight,
                  child: rightWidget,
                ): Container(
                  width: height ?? 44,
                  height: height ?? 44,
                  color: Colors.transparent,
                  alignment: Alignment.centerRight,
                  child: Text(rightText, style:TextStyles.font17(color: rightColor),),
                ),
                onTap: (){
                  rightTap!();
                },
              ) : SizedBox(width: height ?? 44,),
            ],
          )
        ),
      ],
    );
  }
}