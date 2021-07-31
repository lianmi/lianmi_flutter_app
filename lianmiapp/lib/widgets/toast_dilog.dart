import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lianmiapp/util/adapt.dart';
import 'package:provider/provider.dart';

///弹窗选项
class ToastDilog {
  CancelFunc showToast(Widget childW, {BuildContext? context, Offset? target, required Color backgroundColor, Function? onClose}) {
    CancelFunc _botToast = BotToast.showAttachedWidget(
      target: target,
      targetContext: context,
      verticalOffset: Adapt.px(20),
      horizontalOffset: Adapt.px(30),
      attachedBuilder: (cancel){
        return childW;
      },
      onClose: (){
        if(onClose != null) onClose();
      },
      backgroundColor: backgroundColor,
    );
    return _botToast;
  }

  void showToastCard({
    required Offset target,
    required List<Widget> listWidget,
    bool exchange = true,
  }) {
    showToast(
      Card(
        color: exchange ? Colors.black : Colors.black,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: listWidget,
          ),
        )
      ), 
      target: target,
      backgroundColor: Colors.transparent,
    );
  }

  void showText(String text) {
    BotToast.showText(
      text: text,
      align: Alignment(0, 0),
      borderRadius: BorderRadius.circular(4),
      contentPadding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      contentColor: Colors.black,
      textStyle: TextStyle(
        fontSize: 11.px,
        color: Colors.black
      )
      // textStyle: FontStandard.font11(
      //   color: ColorStandard.back1,
      //   fontWeight: FontWeight.w400,
      // ),
    );
  }

  void closeToast() {
    BotToast.cleanAll();
  }
}


