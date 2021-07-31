import 'package:flutter/material.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/gongzhengchu/model/hetong_model.dart';

class HetongProvider extends ChangeNotifier {
  HetongDataModel _hetongData = HetongDataModel();

  HetongDataModel get hetongData => _hetongData;

  void reset() {
    _hetongData = HetongDataModel();
  }
}
