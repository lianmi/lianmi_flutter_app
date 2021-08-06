import 'package:flutter/material.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/legalattest/model/hetong_model.dart';

class HetongProvider extends ChangeNotifier {
  HetongDataModel _hetongData = HetongDataModel(
    type: 0,
    description: '',
    jiafangName: '',
    jiafangPhone: '',
    attachs: [],
    attachsAliyun: [],
  );

  HetongDataModel get hetongData => _hetongData;

  void reset() {
    _hetongData = HetongDataModel(
      type: 0,
      description: '',
      jiafangName: '',
      jiafangPhone: '',
      attachs: [],
      attachsAliyun: [],
    );
  }
}
