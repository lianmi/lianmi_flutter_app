import 'package:flutter/material.dart';

class MainTabbarIndexProvider extends ChangeNotifier {
  int _index = 0;

  int get index => _index;

  set index(int i) {
    _index = i;
    _handleIndexWhenChange();
    notifyListeners();
  }

  void _handleIndexWhenChange() {
    switch (_index) {
      case 1:{
      }
        break;
      case 2:{
      }
        break;
      default:
    }
  }
}