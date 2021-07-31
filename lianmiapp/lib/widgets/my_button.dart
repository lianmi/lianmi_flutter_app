import 'package:flutter/material.dart';
import 'package:lianmiapp/res/resources.dart';
import 'package:lianmiapp/util/theme_utils.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    this.text = '',
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    return FlatButton(
      onPressed: onPressed,
      textColor: isDark ? Colours.dark_button_text : Colors.white,
      color: isDark ? Colours.dark_app_main : Colours.app_main,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100)
      ),
      disabledTextColor: Colors.white,
      disabledColor:
          isDark ? Colours.dark_button_disabled : Colours.dark_app_main,
      //shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        height: 48,
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(fontSize: Dimens.font_sp18),
        ),
      ),
    );
  }
}
