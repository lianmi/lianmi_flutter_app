import 'dart:convert';

import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/notification/notification_center.dart';
import 'package:lianmiapp/util/url_util.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

enum QrActionEnum {
  unknow,
  personInfo //个人资料
}

class ActionUtils {
  static void handleQrData(dynamic data) {
    if (data is String) {
      if (data.contains('http')) {
        Map jsonData = UrlUtil.urlToMap(data);
        _handleJsonData(jsonData);
      } else {
        try {
          Map<String, dynamic> jsonData = json.decode(data);
          if (jsonData != null) {
            _handleJsonData(jsonData);
          }
        } catch (e) {
          logD('解析二维码出错');
        }
      }
    }
  }

  static void _handleJsonData(dynamic jsonData) {
    int? action;
    if (jsonData['action'] is int) {
      action = jsonData['action'];
    } else if (jsonData['action'] is String) {
      action = int.parse(jsonData['action']);
    }
    if (action != null) {
      switch (QrActionEnum.values[action]) {
        case QrActionEnum.personInfo:
          {
            _handlePersonData(jsonData);
          }
          break;
        default:
      }
    }
  }
}

void _handlePersonData(Map jsonData) {}
