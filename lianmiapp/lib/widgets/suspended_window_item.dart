import 'package:flutter/material.dart';
import 'package:lianmiapp/util/adapt.dart';

class SuspendedWindowItem extends StatelessWidget {
  final String title;
  final Function? click;
  final bool showBottomBorder;
  //调换颜色
  final bool exchange;
  final double? width;

  SuspendedWindowItem({
    required this.title,
    this.click,
    this.showBottomBorder = true,
    this.exchange = true,
    this.width
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: click as void Function()?,
      padding: EdgeInsets.all(0),
      child: Container(
        width: width??Adapt.px(80),
        height: Adapt.px(45),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14.px,
            color: exchange ? Colors.white : Colors.grey
          ),
          // style: FontStandard.font14(
          //   fontWeight: FontWeight.w400,
          //   color: exchange ? ColorStandard.back1 : ColorStandard.fontGrey2,
          // ),
        ),
      ),
    );
  }
}


