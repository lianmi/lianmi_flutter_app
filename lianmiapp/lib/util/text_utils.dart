import 'package:flutter/material.dart';

///是否有效文本
bool isValidString(String? text) {
  if (text != null && text is String && text.length > 0) {
    return true;
  }
  return false;
}

//判定是否为数字
bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}

class TextUtils {
  ///根据前缀和后缀分割字符串
  static List<String> sliceToList(String text,
      {required String prefix, required String suffix}) {
    if (text == null || text.length == 0) return [];
    String originText = text;
    List<String> targetTextList = [];
    int? startIndex;
    int? endIndex;
    List<String> expressRangeList = [];
    for (var i = 0; i < originText.length; i++) {
      String singleChar = originText.substring(i, i + 1);
      if (singleChar == prefix) {
        startIndex = i;
      } else if (singleChar == suffix) {
        endIndex = i;
      }
      if (startIndex != null && endIndex != null && endIndex > startIndex) {
        expressRangeList.add('$startIndex-$endIndex');
        startIndex = null;
        endIndex = null;
      }
    }
    for (var i = 0; i < expressRangeList.length; i++) {
      if (i == 0) {
        String rangeText = expressRangeList.first;
        List range = rangeText.split('-');
        int start = int.parse(range.first);
        int end = int.parse(range.last);
        String prefixText = originText.substring(0, start);
        if (prefixText.length > 0) targetTextList.add(prefixText);
        targetTextList.add(originText.substring(start, end + 1));
        if (expressRangeList.length == 1) {
          String suffixText = originText.substring(end + 1, originText.length);
          if (suffixText.length > 0) targetTextList.add(suffixText);
        }
      } else if (i == expressRangeList.length - 1) {
        String lastRangeText = expressRangeList[i - 1];
        List lastRange = lastRangeText.split('-');
        int lastEnd = int.parse(lastRange.last);

        String thisRangeText = expressRangeList.last;
        List thisRange = thisRangeText.split('-');
        int thisStart = int.parse(thisRange.first);
        int thisEnd = int.parse(thisRange.last);
        String prefixText = originText.substring(lastEnd + 1, thisStart);
        if (prefixText.length > 0) targetTextList.add(prefixText);
        targetTextList.add(originText.substring(thisStart, thisEnd + 1));
        String suffixText =
            originText.substring(thisEnd + 1, originText.length);
        if (suffixText.length > 0) targetTextList.add(suffixText);
      } else {
        String lastRangeText = expressRangeList[i - 1];
        List lastRange = lastRangeText.split('-');
        int lastEnd = int.parse(lastRange.last);

        String thisRangeText = expressRangeList[i];
        List thisRange = thisRangeText.split('-');
        int thisStart = int.parse(thisRange.first);
        int thisEnd = int.parse(thisRange.last);

        String nextRangeText = expressRangeList[i + 1];
        List nextRange = nextRangeText.split('-');
        int nextStart = int.parse(nextRange.first);

        String prefixText = originText.substring(lastEnd + 1, thisStart);
        if (prefixText.length > 0) targetTextList.add(prefixText);
        targetTextList.add(originText.substring(thisStart, thisEnd + 1));
        // String suffixText = originText.substring(thisEnd+1, nextStart);
        // if(suffixText.length > 0) targetTextList.add(suffixText);
      }
    }
    if (expressRangeList.length == 0) targetTextList.add(originText);
    return targetTextList;
  }
}
