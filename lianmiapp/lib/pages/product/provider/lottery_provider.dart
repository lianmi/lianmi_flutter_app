import 'package:flutter/material.dart';

class LotteryProvider extends ChangeNotifier {
  ///当前彩种id
  int lotteryId = 0;

  ///当前倍数
  int _multiple = 1;

  int get multiple => _multiple;
  
  ///普通注数
  int _count = 0;

  int get count => _count;

  set multiple(int m) {
    _multiple = m;
    notifyListeners();
  }

  set count(int c) {
    _count = c;
    notifyListeners();
  }

  void addMultiple() {
    _multiple ++;
    notifyListeners();
  }

  void minusMultiple() {
    if(_multiple <= 1) return;
    _multiple --;
    notifyListeners();
  }

  void reset() {
    _multiple = 1;
    notifyListeners();
  }

  void clear() {
    _multiple = 1;
  }
}