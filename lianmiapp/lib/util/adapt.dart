import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Adapt {
  static Size size = window.physicalSize;
  static double _width = size.width / window.devicePixelRatio;
  static double _height = size.height;
  static double _topbarH = window.padding.top;
  static double _botbarH = window.padding.bottom;
  static double _pixelRatio = window.devicePixelRatio;
  static var _ratio;

  static init(double num){
    int uiwidth = 375;
    _ratio = _width / uiwidth;
  }
  static px(number){
    if(!(_ratio is double || _ratio is int)){Adapt.init(375);}
    return number * _ratio;
  }
  static onepx(){
    return 1/_pixelRatio;
  }
  static screenW(){
    return _width;
  }
  static screenH(){
    return _height;
  }
  static padTopH(){
    return _topbarH/_pixelRatio;
  }
  static padBotH(){
    return _botbarH/_pixelRatio;
  }
}

extension SizeAdaptDoubleExtension on num {
  double get px => Adapt.px(this);
}