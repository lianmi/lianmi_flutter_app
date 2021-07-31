import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lianmiapp/res/colors.dart';
import 'package:lianmiapp/res/styles.dart';
import 'package:lianmiapp/res/view_standard.dart';

import '../divider_widget.dart';

class RemindDialog extends StatelessWidget{
  String title;
  String? remind;
  Function? confirm;
  String? confirmText;
  String? cancelText;
  Function? cancel;
  Color? confirmColor;
  Color? cancelColor;

  RemindDialog({
    this.title = '提示',
    this.remind,
    this.confirm,
    this.cancel,
    this.cancelText,
    this.confirmText,
    this.confirmColor,
    this.cancelColor
  });

  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: 300,
          height: 173,
          decoration:  BoxDecoration(
            borderRadius: ViewStandard.imageRadius,
            color: Colours.back1,
          ),
          child: Column(
            children: [
              Container(
                height: 53,
                padding: ViewStandard.padding,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: SizedBox()),
                    Text(title, style: TextStyles.font17(),),
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          height: double.infinity,
                          width: 40,
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.clear,
                            size: ViewStandard.smallButtonSize,
                            color: Colours.text_gray,
                          ),
                        ),
                        onTap: (){
                          Navigator.pop(context);
                        },
                      )
                    )
                  ],
                ),
              ),
              Container(
                height: 70,
                padding: ViewStandard.padding,
                alignment: Alignment.topCenter,
                child: Text(remind ?? '',
                  textAlign: TextAlign.center,
                  style: TextStyles.font15(color: Colours.text_gray),
                ),
              ),
              DividerWidget(),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        child: Container(
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          child: Text(cancelText ?? '取消',
                            style: TextStyles.font15(color: cancelColor ?? Colours.text_gray_c),
                          ),
                        ),
                        onTap: (){
                          cancel!();
                        }
                      )
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        child: Container(
                          color: Colors.transparent,
                          alignment: Alignment.center,
                          child: Text(confirmText ?? '确定',
                            style: TextStyles.font15(color: confirmColor ?? Colours.app_main),),
                        ),
                        onTap: (){
                          confirm!();
                        }
                      )
                    )
                  ],
                )
              )
            ],
          )
        ),
      ),
    );
  }
}