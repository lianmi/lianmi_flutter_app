import 'package:flutter/material.dart';
import 'package:lianmiapp/util/emoji_utils.dart';
import 'package:lianmiapp/util/text_utils.dart';

class EmojiText extends StatelessWidget {
  final String text;

  final double fontSize;

  final double emojiSize;

  final Color? textColor;

  final int? maxLines; 

  EmojiText(this.text,{required this.fontSize,required this.emojiSize, this.textColor, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: maxLines,
      overflow: maxLines!=null?TextOverflow.ellipsis:TextOverflow.clip,
      text: TextSpan(   
        children: _getChildrens()
      )
    );
  }

  List<InlineSpan> _getChildrens() {
    List<InlineSpan> targetChildren = [];
    List<String> textList = TextUtils.sliceToList(text, prefix: '[', suffix: ']');
    textList.forEach((element) {
      if(EmojiUitls.instance.emojiMap.containsKey(element)) {
        targetChildren.add(
          WidgetSpan(
            child: SizedBox(
              child: Image.asset(EmojiUitls.instance.emojiMap[element]!),
              width: emojiSize,
              height: emojiSize,
            )
          )
        );
      } else {
        targetChildren.add(
          TextSpan(
            text: element,
            style: TextStyle(
              fontSize: fontSize, 
              color: textColor??Colors.black54),
          )
        );
      }
    });
    return targetChildren;
  }
}