import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'colors.dart';
import 'dimens.dart';

///字体
class TextStyles {
  static TextStyle font10(
          {Color? color, FontWeight? fontWeight, bool bar = false}) =>
      TextStyle(
          color: color ?? Colours.text,
          fontWeight: fontWeight ?? FontWeight.w400,
          decoration: bar ? TextDecoration.underline : TextDecoration.none,
          fontSize: 10);
  static TextStyle font12(
          {Color? color, FontWeight? fontWeight, bool bar = false}) =>
      TextStyle(
          color: color ?? Colours.text,
          fontWeight: fontWeight ?? FontWeight.w400,
          decoration: bar ? TextDecoration.underline : TextDecoration.none,
          fontSize: 12);
  static TextStyle font14(
          {Color? color, FontWeight? fontWeight, bool bar = false}) =>
      TextStyle(
          color: color ?? Colours.text,
          fontWeight: fontWeight ?? FontWeight.w400,
          decoration: bar ? TextDecoration.underline : TextDecoration.none,
          fontSize: 14);
  static TextStyle font15(
          {Color? color, FontWeight? fontWeight, bool bar = false}) =>
      TextStyle(
          color: color ?? Colours.text,
          fontWeight: fontWeight ?? FontWeight.w400,
          decoration: bar ? TextDecoration.underline : TextDecoration.none,
          fontSize: 15);
  static TextStyle font16(
          {Color? color, FontWeight? fontWeight, bool bar = false}) =>
      TextStyle(
          color: color ?? Colours.text,
          fontWeight: fontWeight ?? FontWeight.w400,
          decoration: bar ? TextDecoration.underline : TextDecoration.none,
          fontSize: 16);
  static TextStyle font17(
          {Color? color, FontWeight? fontWeight, bool bar = false}) =>
      TextStyle(
          color: color ?? Colours.text,
          fontWeight: fontWeight ?? FontWeight.w400,
          decoration: bar ? TextDecoration.underline : TextDecoration.none,
          fontSize: 17);
  static TextStyle font18(
          {Color? color, FontWeight? fontWeight, bool bar = false}) =>
      TextStyle(
          color: color ?? Colours.text,
          fontWeight: fontWeight ?? FontWeight.w400,
          decoration: bar ? TextDecoration.underline : TextDecoration.none,
          fontSize: 18);
  static TextStyle font19(
          {Color? color, FontWeight? fontWeight, bool bar = false}) =>
      TextStyle(
          color: color ?? Colours.text,
          fontWeight: fontWeight ?? FontWeight.w400,
          decoration: bar ? TextDecoration.underline : TextDecoration.none,
          fontSize: 19);
  static TextStyle font20(
          {Color? color, FontWeight? fontWeight, bool bar = false}) =>
      TextStyle(
          color: color ?? Colours.text,
          fontWeight: fontWeight ?? FontWeight.w400,
          decoration: bar ? TextDecoration.underline : TextDecoration.none,
          fontSize: 20);
  static TextStyle font21(
          {Color? color, FontWeight? fontWeight, bool bar = false}) =>
      TextStyle(
          color: color ?? Colours.text,
          fontWeight: fontWeight ?? FontWeight.w400,
          decoration: bar ? TextDecoration.underline : TextDecoration.none,
          fontSize: 21);
  static TextStyle font22(
          {Color? color, FontWeight? fontWeight, bool bar = false}) =>
      TextStyle(
          color: color ?? Colours.text,
          fontWeight: fontWeight ?? FontWeight.w400,
          decoration: bar ? TextDecoration.underline : TextDecoration.none,
          fontSize: 22);
  static TextStyle font23(
          {Color? color,
          FontWeight? fontWeight,
          bool bar = false,
          FontStyle? fontStyle}) =>
      TextStyle(
          color: color ?? Colours.text,
          fontWeight: fontWeight ?? FontWeight.w400,
          decoration: bar ? TextDecoration.underline : TextDecoration.none,
          fontSize: 23,
          fontStyle: FontStyle.italic);
  static TextStyle font24(
          {Color? color, FontWeight? fontWeight, bool bar = false}) =>
      TextStyle(
          color: color ?? Colours.text,
          fontWeight: fontWeight ?? FontWeight.w400,
          decoration: bar ? TextDecoration.underline : TextDecoration.none,
          fontSize: 24);
  static TextStyle font25(
          {Color? color, FontWeight? fontWeight, bool bar = false}) =>
      TextStyle(
          color: color ?? Colours.text,
          fontWeight: fontWeight ?? FontWeight.w400,
          decoration: bar ? TextDecoration.underline : TextDecoration.none,
          fontSize: 25);
  static TextStyle font26(
          {Color? color, FontWeight? fontWeight, bool bar = false}) =>
      TextStyle(
          color: color ?? Colours.text,
          fontWeight: fontWeight ?? FontWeight.w400,
          decoration: bar ? TextDecoration.underline : TextDecoration.none,
          fontSize: 26);
  static TextStyle font28(
          {Color? color, FontWeight? fontWeight, bool bar = false}) =>
      TextStyle(
          color: color ?? Colours.text,
          fontWeight: fontWeight ?? FontWeight.w400,
          decoration: bar ? TextDecoration.underline : TextDecoration.none,
          fontSize: 28);

  static TextStyle font88(
          {Color? color, FontWeight? fontWeight, bool bar = false}) =>
      TextStyle(
        color: color ?? Colours.text,
        fontWeight: fontWeight ?? FontWeight.w400,
        decoration: bar ? TextDecoration.underline : TextDecoration.none,
        fontSize: 108,
        fontStyle: FontStyle.italic,
      );

  static const TextStyle textSize12 = TextStyle(
    fontSize: Dimens.font_sp12,
  );
  static const TextStyle textSize16 = TextStyle(
    fontSize: Dimens.font_sp16,
  );
  static const TextStyle textBold14 =
      TextStyle(fontSize: Dimens.font_sp14, fontWeight: FontWeight.bold);
  static const TextStyle text14 = TextStyle(
    fontSize: Dimens.font_sp14,
  );
  static const TextStyle textBold16 =
      TextStyle(fontSize: Dimens.font_sp16, fontWeight: FontWeight.bold);
  static const TextStyle textBold18 =
      TextStyle(fontSize: Dimens.font_sp18, fontWeight: FontWeight.bold);
  static const TextStyle textBold24 =
      TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold);
  static const TextStyle textBlackBold20 = TextStyle(
      fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black);
  static const TextStyle textBold26 =
      TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold);

  static const TextStyle textSize16Gray = TextStyle(
    fontSize: Dimens.font_sp16,
    color: Colours.text_gray,
  );
  static const TextStyle textGray14 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colours.text_gray,
  );
  static const TextStyle textDarkGray14 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colours.dark_text_gray,
  );

  static const TextStyle textWhite14 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colors.white,
  );

  static const TextStyle text = TextStyle(
      fontSize: Dimens.font_sp14,
      color: Colours.text,
      // https://github.com/flutter/flutter/issues/40248
      textBaseline: TextBaseline.alphabetic);
  static const TextStyle textDark = TextStyle(
      fontSize: Dimens.font_sp14,
      color: Colours.dark_text,
      textBaseline: TextBaseline.alphabetic);

  static const TextStyle textGray12 = TextStyle(
      fontSize: Dimens.font_sp12,
      color: Colours.text_gray,
      fontWeight: FontWeight.normal);
  static const TextStyle textDarkGray12 = TextStyle(
      fontSize: Dimens.font_sp12,
      color: Colours.dark_text_gray,
      fontWeight: FontWeight.normal);

  static const TextStyle textHint14 = TextStyle(
      fontSize: Dimens.font_sp14, color: Colours.dark_unselected_item_color);
}
