import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewStandard{
  ///主间据
  static EdgeInsets padding = EdgeInsets.symmetric(horizontal: 16);
  ///组件高度
  static double widgetHeight = 45;
  ///小间距
  static double smallSize = 20;
  ///圆角
  static BorderRadius imageRadius = BorderRadius.circular(5);
  ///小组件大小
  static double smallButtonSize = 16;

  static Widget get arrowRight {
    return Container(
      width: 7,
      height: 12,
      child: Image.asset(
        'assets/images/arrow_right.png',
        width: 7,
        height: 12,
      )
    );
  }

  ///下划线
  static Widget underLine({bool needPadding = true}) {
    return Container(
      padding: needPadding?padding:EdgeInsets.zero,
      width: double.infinity,
      height: 1,
      child: Container(
        height: 1,
        color: Color(0xFFEEEEEE),
      ),
    );
  }

  ///带下划线的Decoration
  static Decoration get lightGrayUnderLineDecoration {
    return BoxDecoration(
      color: Colors.white,
      border: Border(bottom: BorderSide(color: Color(0XFFDDDDDD), width: 1))
    );
  }
}