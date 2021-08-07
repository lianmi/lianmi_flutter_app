/*
 订单模块
 */
import 'dart:convert';
import 'dart:async';
import 'dart:typed_data';
import 'dart:io';
// import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:linkme_flutter_sdk/common/common.dart';
import 'package:linkme_flutter_sdk/common/http_utils.dart';
import 'package:linkme_flutter_sdk/common/urls.dart';
import 'package:linkme_flutter_sdk/manager/AppManager.dart';
import 'package:linkme_flutter_sdk/models/HetongtData.dart';
import 'package:linkme_flutter_sdk/models/orderRate.dart';
import 'package:linkme_flutter_sdk/models/terms.dart';
import 'package:linkme_flutter_sdk/sdk/UserMod.dart';
import 'package:linkme_flutter_sdk/manager/LogManager.dart';
import 'package:linkme_flutter_sdk/sdk/SdkEnum.dart';
import 'package:linkme_flutter_sdk/models/UpdateStatusReq.dart';
// import 'package:linkme_flutter_sdk/util/file_cryptor.dart';
import 'package:linkme_flutter_sdk/util/md5.dart';
import 'package:encrypt/encrypt.dart' as SDKCrypt;
import 'package:linkme_flutter_sdk/util/hex.dart';
// import 'package:libsignal_protocol_dart/src/ecc/curve.dart' as DH;
// import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart';
import 'package:path_provider/path_provider.dart';

class OrderMod {
  /// @nodoc POST方法, 根据彩票总金额，获取对应的服务费
  ///totalAmount 客户端支付的总金额(彩票总价,以元为单位)
  /// 返回服务费
  static Future getOrderFee(double totalAmount) async {
    assert(totalAmount > 0);
    Completer _completer = new Completer.sync();
    Future f = _completer.future;

    //舍弃当前变量的小数部分。返回值为 int 类型。
    int _totalAmount = (totalAmount * 100).truncate();
    var _map = {
      'total_amount': _totalAmount,
    };

    ///提交数据
    try {
      var _body = await HttpUtils.post(HttpApi.getOrderFee, data: _map);
      // logD('_body: $_body');

      var code = _body['code'];
      if (code == 200) {
        var _fee = _body['data'];
        _completer.complete(_fee);
      } else {
        logE("根据彩票总金额，获取对应的服务费出错 , ${_body['code']} , msg ${_body['msg']}");
        _completer.completeError('根据彩票总金额，获取对应的服务费出错');
      }
    } catch (e) {
      logE(e);
      _completer.completeError('错误');
      return;
    }

    return f;
  }

  /// @nodoc 预下单 扣chu链服务费
  /// businessUsername - 商户id
  /// productID 商品id
  /// totalAmount 客户端支付的总金额(彩票总价), 以元为单位
  /// body 明文的json字符串, 由UI构造，里面是订单详细数据，如果是彩票则需要解析，如果是存证数据，按枚举类型解析
  /// payMode 用户选择的支付方式，默认是1-微信,  2-支付宝
  /// 如果成功，服务端会返回一个新的订单ID 及 网点OPK公钥
  static Future preOrder(String businessUsername, String productID,
      double totalAmount, String body,
      {int payMode = 1}) async {
    assert(totalAmount > 0);
    //舍弃当前变量的小数部分。返回值为 int 类型。
    int _totalAmount = (totalAmount).truncate();

    Completer _completer = new Completer.sync();
    Future f = _completer.future;

    var _map = {
      'business_id': businessUsername,
      'product_id': productID,
      'total_amount': _totalAmount * 100, //服务端以分为单位接收
      'pay_mode': payMode,
      'body': body,
    };

    ///提交数据 下单
    try {
      var _body = await HttpUtils.post(HttpApi.preOrder, data: _map);
      // logD('_body: $_body');

      var code = _body['code'];
      if (code == 200) {
        logD('服务端回包: ${_body['data']}');
        CreateNewOrderResp _resp = CreateNewOrderResp.fromMap(_body['data']);

        logD('订单id: ${_resp.orderId}');
        logD('订单时间: ${_resp.orderTime}');
        logD('出票码: ${_resp.orderTime}');

        _completer.complete(_resp.orderId);
      } else {
        logE("预下单出错 , ${_body['code']} , msg ${_body['msg']}");
        // return new Future.error('预下单出错 ,错误信息:  ${_body['msg']}');
        _completer.completeError('预下单出错');
      }
    } catch (e) {
      logE(e);
      _completer.completeError('预下单出错');
      return;
    }

    return f;
  }

  ///输入中奖金额，以元为单位
  static Future inputPrize(String orderID, double prize) async {
    //舍弃当前变量的小数部分。返回值为 int 类型。
    int _prize = (prize * 100).truncate();

    var _data = {
      'order_id': orderID,
      'prize': _prize,
    };

    try {
      var _body = await HttpUtils.post(HttpApi.inputPrize, data: _data);
      // logD('_body:  $_body');
      if (_body['code'] == 200) {
        return true;
      } else {
        logE('inputPrize error, msg: ${_body['msg']}');
        return false;
      }
    } catch (e) {
      logE(e);
      return false;
    }
  }

  /// @nodoc 删除订单, 不建议轻易删除订单，一旦删除，无法找回
  static Future deleteOrder(String orderID) async {
    try {
      var _body = await HttpUtils.post(HttpApi.deleteOrder + '/' + orderID);
      // logD('_body:  $_body');
      if (_body['code'] == 200) {
        return true;
      } else {
        logE('inputPrize error, msg: ${_body['msg']}');
        return false;
      }
    } catch (e) {
      logE(e);
      return false;
    }
  }

  /// @nodoc 清除当前登录用户在服务端的的所有订单
  static Future clearAllOrders() async {
    try {
      var _body = await HttpUtils.post(HttpApi.clearAllOrders);
      // logD('_body:  $_body');
      if (_body['code'] == 200) {
        return true;
      } else {
        logE('inputPrize error, msg: ${_body['msg']}');
        return false;
      }
    } catch (e) {
      logE(e);
      return false;
    }
  }

  /// @nodoc 获取某个订单ID的信息
  static Future getOrder(String orderID) async {
    Completer _completer = new Completer.sync();
    Future _c = _completer.future;

    ///提交数据
    try {
      var _body = await HttpUtils.get(HttpApi.orderInfo + '/' + orderID);
      // logD('_body:  $_body');
      if (_body['code'] == 200) {
        OrderInfoData _orderInfoData = OrderInfoData.fromMap(_body['data']);
        _completer.complete(_orderInfoData); //返回
      } else {
        logE('getOrder error, msg: ${_body['msg']}');
        _completer.completeError('获取某个订单ID的信息出错');
      }
    } catch (e) {
      logE(e);
      _completer.completeError('获取某个订单ID($orderID)的信息');
    } finally {
      logD('getOrder end.');
    }
    return _c;
  }

  //计算图片的hash256
  static Future getHash256(String filename) {
    return hash256(filename);
  }

  /// 商户接单
  static Future<dynamic> takeOrder(String orderID) async {
    Completer _completer = new Completer.sync();
    Future f = _completer.future;

    var _map = {
      'order_id': orderID,
    };
    try {
      var _body = await HttpUtils.post(HttpApi.takeOrder, data: _map);
      // logD('takeOrder, _body: $_body');
      var code = _body['code'];
      var errmsg = _body['msg'];
      if (code == 200) {
        _completer.complete(true);
      } else {
        _completer.completeError('商户接单出错');
      }
    } catch (e) {
      logE(e);
      return Future.error(e);
    } finally {
      logD('OrderMod.takeOrder end.');
    }

    return f;
  }

  /// 修改订单状态
  static Future<dynamic> changeOrderStatus(
      String orderID, OrderStateEnum status, ProductOrderType orderType) async {
    UpdateStatusReq req = new UpdateStatusReq();
    req.order_id = orderID;
    req.status = status.index;

    try {
      var _body = await HttpUtils.post(HttpApi.updateStatus, data: req);
      // logD('changeOrderStatus, _body: $_body');
      var code = _body['code'];
      var errmsg = _body['msg'];
      if (code == 200) {
        return true;
      } else {
        return Future.error(errmsg);
      }
    } catch (e) {
      logE(e);
      return Future.error(e);
    } finally {
      logD('OrderMod.updateStatus end.');
    }
  }

  /// 修改订单价格
  /// totalAmount 修改后的修改订单总价，以元为单位
  static Future<dynamic> changeOrderCost(
      String orderID, double totalAmount) async {
    assert(totalAmount > 0);

    // 由于服务端接收是以分为单位, 所以需要乘以100
    //舍弃当前变量的小数部分。返回值为 int 类型
    int _totalAmount = (totalAmount * 100).truncate();

    var _map = {'order_id': orderID, 'total_amount': _totalAmount};

    try {
      var _body = await HttpUtils.post(HttpApi.changeOrderCost, data: _map);
      var code = _body['code'];
      var errmsg = _body['msg'];
      if (code == 200) {
        return true;
      } else {
        return Future.error(errmsg);
      }
    } catch (e) {
      logE(e);
      return Future.error(e);
    } finally {
      logD('OrderMod.changeOrderCost end.');
    }
  }

  /// 翻页获取订单列表
  static Future getOrders(int status,
      {int? ticketCode, int? limit, int? page}) async {
    Completer _completer = new Completer.sync();
    Future _c = _completer.future;

    ///提交数据
    try {
      Map<String, dynamic> params = new Map<String, dynamic>();
      params['status'] = status;
      if (limit != null) {
        params['limit'] = limit;
      }
      if (page != null) {
        params['page'] = page;
      }

      var _body = await HttpUtils.get(HttpApi.orderList, params: params);
      // logD('getOrders(), _body: $_body');
      List<OrderInfoData> orders = [];
      if (_body['code'] == 200) {
        _body['data'].forEach((v) {
          OrderInfoData orderInfo = OrderInfoData.fromMap(v);
          orders.add(orderInfo);
        });
        _completer.complete(orders); //返回List

      } else {
        logE('getOrders error, msg: ${_body['msg']}');
        _completer.completeError('获取订单列表出错');
        return false;
      }
    } catch (e) {
      logE(e);
      _completer.completeError('无法获取订单列表');
    } finally {
      // logD('getOrderLists end.');
    }
    return _c;
  }

  /// 通过订单状态、出票码、订单ID 搜索订单
  /// status 订单状态
  /// ticketCode  出票码 精确匹配
  /// orderID 订单id，模糊匹配
  /// startTime 开始时间  如果非零，则结束时间也必须非零。如果是0，则忽略
  /// endTime 结束时间  如果非零，则开始时间也必须非零。如果是0，则忽略
  static Future searchOrders(int status,
      {int? ticketCode,
      String? orderID,
      int? startTime,
      int? endTime,
      int? limit,
      int? page}) async {
    Completer _completer = new Completer.sync();
    Future _c = _completer.future;

    ///提交数据
    try {
      var _orderSearch = {
        'status': 0,
        'ticket_code': ticketCode,
        'order_id': orderID,
        'start_time': startTime,
        'end_time': endTime,
      };
      Map<String, dynamic> params = new Map<String, dynamic>();
      params['status'] = status;
      if (limit != null) {
        params['limit'] = limit;
      }
      if (page != null) {
        params['page'] = page;
      }

      var _body = await HttpUtils.post(HttpApi.orderSearch,
          data: _orderSearch, params: params);
      // logD('_body:  $_body');
      if (_body['code'] == 200) {
        List<OrderInfoData> orders = [];
        _body['data'].forEach((v) {
          OrderInfoData orderInfo = OrderInfoData.fromMap(v);
          orders.add(orderInfo);
        });
        _completer.complete(orders); //返回List
      } else {
        logE('searchOrders error, msg: ${_body['msg']}');
        _completer.completeError('搜索订单出错');
      }
    } catch (e) {
      logE(e);
      _completer.completeError('无法搜索订单列表');
    } finally {
      logD('searchOrders end.');
    }
    return _c;
  }

  /// 交互图片上传
  static Future uploaOrderImage(
    String filename, //源文件
    String orderID,
    String image, //json
  ) async {
    Completer _completer = new Completer.sync();
    Future _c = _completer.future;

    ///提交数据
    try {
      String hash = await OrderMod.getHash256(filename);
      var _map = {
        'order_id': orderID,
        'image': image,
        'image_hash': hash,
      };

      var _body = await HttpUtils.post(HttpApi.uploaOrderImage, data: _map);
      // logD('_body:  $_body');
      if (_body['code'] == 200) {
        _completer.complete(true);
      } else {
        logE('uploaOrderImage error, msg: ${_body['msg']}');
        _completer.completeError('拍照上链出错');
      }
    } catch (e) {
      logE(e);
      _completer.completeError('无法上传拍照图片');
    } finally {
      logD('uploaOrderImage end.');
    }
    return _c;
  }

  /// 交互图片数组上传
  static Future uploaOrderPhotos(
    String orderID,
    List<String> photos, //阿里云Url数组
  ) async {
    assert(orderID != '');
    assert(photos.length > 0);
    logD('uploaOrderPhotos start.');
    Completer _completer = new Completer.sync();
    Future _c = _completer.future;

    String _json = json.encode(photos);
    logD('uploaOrderPhotos _json: $_json');

    ///提交数据
    try {
      var _map = {
        'order_id': orderID,
        'image': _json,
      };

      var _body = await HttpUtils.post(HttpApi.uploaOrderImage, data: _map);
      // logD('_body:  $_body');
      if (_body['code'] == 200) {
        _completer.complete(true);
      } else {
        logE('uploaOrderPhotos error, msg: ${_body['msg']}');
        _completer.completeError('交互图片数组上传出错');
      }
    } catch (e) {
      logE(e);
      _completer.completeError('无法上传交互图片数组');
    } finally {
      logD('uploaOrderPhotos end.');
    }
    return _c;
  }

  /// 获取订单的交互图片json
  static Future getOrderPhotos(String orderID) async {
    Completer _completer = new Completer.sync();
    Future _c = _completer.future;

    ///提交数据
    try {
      var _body = await HttpUtils.get(HttpApi.orderimage + '/' + orderID);
      if (_body['code'] == 200) {
        logI('getOrderPhotos, _body.data: ${_body['data']}');
        _completer.complete(_body['data']);
      } else {
        logE('getOrderPhotos error, msg: ${_body['msg']}');
        _completer.completeError('交互图片下载出错');
      }
    } catch (e) {
      logE(e);
      _completer.completeError('无法下载交互图片');
    } finally {
      logD('getOrderPhotos end.');
    }
    return _c;
  }

  /// 商户专用方法，查询商家的订单记录,指定某个月统计
  static Future getStoreOrders(String yearMonth) async {
    try {
      Map<String, dynamic> params = new Map<String, dynamic>();
      params['year_month'] = yearMonth;
      var _body = await HttpUtils.get(HttpApi.storeOrders, params: params);
      // logD('_body: $_body');
      var code = _body['code'];
      if (code == 200) {
        return _body['data'];
      } else {
        return '';
      }
    } catch (e) {
      logE(e);
    } finally {
      logD('AuthMod.getStoreOrders end.');
    }
  }

  /// 商户专用方法，查询商家的用户消费记录,按月统计
  static Future getStoreSpendings(String yearMonth) async {
    try {
      Map<String, dynamic> params = new Map<String, dynamic>();
      params['year_month'] = yearMonth;
      var _body = await HttpUtils.get(HttpApi.storeSpendings, params: params);
      // logD('_body: $_body');
      var code = _body['code'];
      if (code == 200) {
        return _body['data'];
      } else {
        return '';
      }
    } catch (e) {
      logE(e);
    } finally {
      logD('AuthMod.getStoreSpendings end.');
    }
  }

  ///取区块链存证二维码
  static Future getAntChainQrcode(String orderID) async {
    try {
      var _body =
          await HttpUtils.get(HttpApi.transactionQrcode + '/' + orderID);
      // logD('_body: $_body');
      var code = _body['code'];
      if (code == 200) {
        return _body['data'];
      } else {
        return '';
      }
    } catch (e) {
      logE(e);
    } finally {
      logD('AuthMod.transactionQrcode end.');
    }
  }

  ///合同上链
  static Future submitHetongData({
    int? type,
    String? description,
    String? jiafangName,
    String? jiafangPhone,
    String? jiafangLegalName,
    String? jiafangAddress,
    String? yifangName,
    String? yifangPhone,
    String? yifangHuji,
    String? yifangAddress,
    String? yifangIdCard,
    String? image1,
    String? image2,
    String? image3,
    String? image4,
    String? image5,
    String? image6,
    String? image7,
    String? image8,
    String? image9,
  }) async {
    HetongteData _data = new HetongteData(
      type: type,
      description: description,
      jiafangName: jiafangName,
      jiafangPhone: jiafangPhone,
      jiafangLegalName: jiafangLegalName,
      jiafangAddress: jiafangAddress,
      yifangName: yifangName,
      yifangPhone: yifangPhone,
      yifangHuji: yifangHuji,
      yifangAddress: yifangAddress,
      yifangIdCard: yifangIdCard,
      image1: image1,
      image2: image2,
      image3: image3,
      image4: image4,
      image5: image5,
      image6: image6,
      image7: image7,
      image8: image8,
      image9: image9,
    );

    ///提交数据
    try {
      var _body =
          await HttpUtils.post(HttpApi.submitHetongData, data: _data.toJson());
      // logD('_body: ${_body}');
      var code = _body['code'];

      if (code == 200) {
        var _data = _body['data'];
        logD('_data: $_data');
        return _data;
      } else {
        logE('错误信息: ${_body['msg']}');
        return new Future.error(_body['msg']);
      }
    } catch (e) {
      logE(e);
      return new Future.error('接口出错');
    } finally {
      logD('orderMod.submitHetongData end.');
    }
  }

  ///拷贝文件到APP的目录
  ///[fileSourcePath]源文件路径
  // ignore: missing_return
  static Future<String> copyFileToAppFolder(
      String fileSourcePath, String targetPath) async {
    File file = File(fileSourcePath);
    // String targetFileName = _randomFileName(basename(file.path));
    // String targetPath = App.userIMPath! + targetFileName;
    File newFile = await file.copy(targetPath);
    return newFile.absolute.path;
  }

  ///获取可下载的签名url，以便浏览器打开
  static Future getSignedUrl(String url) async {
    assert(url != '');

    Completer _completer = new Completer.sync();
    Future f = _completer.future;
    var _map = {
      'url': url,
    };

    ///提交数据
    try {
      var _body = await HttpUtils.post(HttpApi.cunzheng_file, data: _map);
      // logD('_body: $_body');

      var code = _body['code'];
      if (code == 200) {
        _completer.complete(_body['data']);
      } else {
        logE("获取可下载的签名url，以便浏览器打开出错 , ${_body['code']} , msg ${_body['msg']}");
        _completer.completeError('获取可下载的签名url，以便浏览器打开出错');
      }
    } catch (e) {
      logE(e);
      _completer.completeError('错误');
      return;
    }

    return f;
  }
}
