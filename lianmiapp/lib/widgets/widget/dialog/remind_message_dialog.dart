import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lianmiapp/res/colors.dart';
import 'package:lianmiapp/res/styles.dart';
import 'package:lianmiapp/res/view_standard.dart';

import '../divider_widget.dart';

class RemindMessageDialog extends StatelessWidget{
  String? remind;
  String rightText;
  bool hasLeft;
  Function? onTap;
  RemindMessageDialog({
    this.remind,
    this.onTap,
    this.rightText = '确定',
    this.hasLeft = false,
  });

  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
            width: 300,
            height: 155,
            decoration:  BoxDecoration(
              borderRadius: ViewStandard.imageRadius,
              color: Colours.back1,
            ),
          child: Column(
            children: [
              Container(
                height: 105,
                padding: ViewStandard.padding,
                alignment: Alignment.center,
                child: Text(remind ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyles.font17(),
                ),
              ),
              DividerWidget(),
              Expanded(
                child: Row(
                  children: [
                    hasLeft
                      ? Expanded(
                        flex: 1,
                        child: GestureDetector(
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            alignment: Alignment.center,
                            color: Colors.transparent,
                            child: Text('取消', style: TextStyles.font15(color: Colours.text_gray),),
                          ),
                          onTap: (){
                            Navigator.of(context).pop();
                          }
                        ),
                    ) : SizedBox(),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          alignment: Alignment.center,
                          color: Colors.transparent,
                          child: Text(rightText, style: TextStyles.font15(color: Colours.app_main),),
                        ),
                        onTap: (){
                          onTap!();
                        }
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}