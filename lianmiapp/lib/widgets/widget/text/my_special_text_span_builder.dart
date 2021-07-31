// import 'package:extended_text_field/extended_text_field.dart';
// import 'package:flutter/material.dart';
// import 'package:lianmiapp/util/emoji_utils.dart';

// enum MySpecialTextSpanBuilderType { 
//   extendedText,
//   extendedTextField 
// }

// class MySpecialTextSpanBuilder extends SpecialTextSpanBuilder {
//   /// whether show background for @somebody
//   final bool showAtBackground;
//   final MySpecialTextSpanBuilderType type;
//   MySpecialTextSpanBuilder(
//       {this.showAtBackground: false, this.type: MySpecialTextSpanBuilderType.extendedText});

//   @override
//   TextSpan build(String data, {TextStyle? textStyle, onTap}) {
//     var textSpan = super.build(data, textStyle: textStyle, onTap: onTap);
//     return textSpan;
//   }

//   @override
//   SpecialText? createSpecialText(String flag,
//       {TextStyle? textStyle, SpecialTextGestureTapCallback? onTap, int? index}) {
//     if (flag == null || flag == "") return null;
//     if (isStart(flag, EmojiText.flag)) {
//       return EmojiText(textStyle!, start: index! - (EmojiText.flag.length - 1));
//     }
//     return null;
//   }
// }

// class EmojiText extends SpecialText {
//   static const String flag = "[";
//   final int? start;
//   EmojiText(TextStyle textStyle, {this.start})
//       : super(EmojiText.flag, "]", textStyle);

//   @override
//   InlineSpan finishText() {
//     var key = toString();
//     if (EmojiUitls.instance.emojiMap.containsKey(key)) {
//       final double size = 20.0;
      
//       return ImageSpan(
//         AssetImage(EmojiUitls.instance.emojiMap[key]!),
//         imageWidth: size,
//         imageHeight: size,   
//         actualText: key,     
//         start: start!,
//         fit: BoxFit.fill,
//         margin: EdgeInsets.only(left: 2.0, top: 2.0, right: 2.0)
//       );
//     }

//     return TextSpan(text: toString(), style: textStyle);
//   }
// }
