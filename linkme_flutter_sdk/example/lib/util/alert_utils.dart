import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AlertUtils {
  static void showChooseAlert(BuildContext context,
      {String? title,
      String? content,
      VoidCallback? onTapConfirm,
      VoidCallback? onTapCancel}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title!),
            content: Text(content!),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('取消'),
                onPressed: () {
                  if (onTapCancel != null) {
                    onTapCancel();
                  }
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                child: Text('确定'),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (onTapConfirm != null) {
                    onTapConfirm();
                  }
                },
              ),
            ],
          );
        });
  }
}
