import 'dart:typed_data';

import 'package:linkme_flutter_sdk/models/OssConfig.dart';
import 'package:linkme_flutter_sdk/sdk/SdkEnum.dart';

///用来保存跨页面的订单id等
class Application {
  static String changeStateOrderID = ''; //订单id
  static String businessUserOpk = '';

  static String productID = 'c3c6b581-505f-4009-8859-d4fd1aa4e11f';
  // static String buyUser = 'id1';
  static String businessUser = 'id3';
  static String orderBody =
      '{"body_type":5,"body":"eyJidXlVc2VyIjoiaWQxIiwiYnVzaW5lc3NVc2VybmFtZSI6ImlkNTgiLCJwcm9kdWN0SUQiOiJjM2M2YjU4MS01MDVmLTQwMDktODg1OS1kNGZkMWFhNGUxMWYiLCJvcmRlcklEIjpudWxsLCJvcmRpZCI6bnVsbCwidGlja2V0VHlwZSI6MSwic3RyYXdzIjpbeyJibHVlQmFsbHMiOls0XSwiZGFudHVvQmFsbHMiOm51bGwsInJlZEJhbGxzIjpbMTcsMjMsMjQsMjgsMjksMzBdfV0sIm11bHRpcGxlIjoxLCJjb3VudCI6MSwiY29zdCI6Mi4wLCJsb3R0ZXJ5UGljT2JqSUQiOm51bGwsImxvdHRlcnlQaWNIYXNoIjpudWxsfQ=="}'; //  订单真实未加密的内容
  // static Uint8List? userdata;

  static OrderStateEnum? state;

  static double orderTotalAmount = 2.00;
  static int orderTotalAmountInt = 200;

  static OssConfig? ossConfig;

  //管理员批准入群
  static String? teamId;
  static String? inviter;
  static String? invitee;
  static String? workflowID;
}
