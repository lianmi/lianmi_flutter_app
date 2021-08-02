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
import 'package:linkme_flutter_sdk/util/file_cryptor.dart';
import 'package:linkme_flutter_sdk/util/md5.dart';
import 'package:encrypt/encrypt.dart' as SDKCrypt;
import 'package:linkme_flutter_sdk/util/hex.dart';
import 'package:libsignal_protocol_dart/src/ecc/curve.dart' as DH;
import 'package:libsignal_protocol_dart/libsignal_protocol_dart.dart';
import 'package:path_provider/path_provider.dart';

class OrderMod {
  /// @nodoc POST方法, 根据彩票总金额，获取对应的服务费
  ///totalAmount 客户端支付的总金额(彩票总价)
  /// 返回服务费
  static Future getOrderFee(double totalAmount) async {
    assert(totalAmount > 0);
    Completer _completer = new Completer.sync();
    Future f = _completer.future;
    var _map = {
      'total_amount': totalAmount,
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
      'total_amount': _totalAmount,
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
  static Future inputPrize(
      String orderID, String prizedPhoto, double prize) async {
    //舍弃当前变量的小数部分。返回值为 int 类型。
    int _prize = (prize * 100).truncate();

    var _data = {
      'order_id': orderID,
      'prize': _prize,
      'prized_photo': prizedPhoto
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

  /// 商户接单，上传收款码
  static Future<dynamic> takeOrder(
      String orderID, String receiptQrcodefile) async {
    Completer _completer = new Completer.sync();
    Future f = _completer.future;

    //TODO 需要加密
    // UserMod.uploadOssMsgFile(receiptQrcodefile, (receiptUrl) async {
    //   logD('$receiptQrcodefile上传完成, receiptUrl: $receiptUrl');

    //   var _map = {
    //     'order_id': orderID,
    //     'receipt_qrcode_image_url': receiptUrl,
    //   };
    //   try {
    //     var _body = await HttpUtils.post(HttpApi.takeOrder, data: _map);
    //     // logD('takeOrder, _body: $_body');
    //     var code = _body['code'];
    //     var errmsg = _body['msg'];
    //     if (code == 200) {
    //       _completer.complete(true);
    //     } else {
    //       // return Future.error(errmsg);
    //       _completer.completeError('商户接单出错');
    //     }
    //   } catch (e) {
    //     logE(e);
    //     return Future.error(e);
    //   } finally {
    //     logD('OrderMod.takeOrder end.');
    //   }
    // }, (errmsg) {
    //   logD('上传失败, $errmsg');
    // }, (percent) {
    //   //上传进度
    // });

    OrderMod.encryptAndUploadFile(receiptQrcodefile).then((receiptUrl) async {
      logD('$receiptQrcodefile 上传完成, receiptUrl: $receiptUrl');

      var _map = {
        'order_id': orderID,
        'receipt_qrcode_image_url': receiptUrl,
      };
      try {
        var _body = await HttpUtils.post(HttpApi.takeOrder, data: _map);
        logD('takeOrder, _body: $_body');
        var code = _body['code'];
        var errmsg = _body['msg'];
        if (code == 200) {
          _completer.complete(true);
        } else {
          _completer.completeError('商户接单，上传收款码出错');
        }
      } catch (e) {
        logE(e);
        return Future.error(e);
      } finally {
        logD('OrderMod.takeOrder end.');
      }
    }).catchError((e) {
      logE(e);
    });

    return f;
  }

  /// 根据订单id获取商家收款码
  static Future<dynamic> getPayUrl(String orderID) async {
    Completer _completer = new Completer.sync();
    Future f = _completer.future;

    try {
      var _body = await HttpUtils.get(HttpApi.payUrl + '/' + orderID);
      // logD('getPayUrl, _body: $_body');
      var code = _body['code'];
      var errmsg = _body['msg'];
      if (code == 200) {
        _completer.complete(_body['data']);
      } else {
        // return Future.error(errmsg);
        logE(errmsg);
        _completer.completeError('根据订单id获取商家收款码出错');
      }
    } catch (e) {
      logE(e);
      return Future.error(e);
    } finally {
      logD('OrderMod.getPayUrl end.');
    }

    return f;
  }

  // /// 用户领奖，发起收款码 , 需要加密
  // static Future<dynamic> acceptPrize(
  //     String orderID, String prizeQrcodefile) async {
  //   Completer _completer = new Completer.sync();
  //   Future f = _completer.future;

  //   UserMod.uploadOssOrderFile(prizeQrcodefile, (prizeUrl) async {
  //     logD('$prizeQrcodefile 上传完成, receiptUrl: $prizeUrl');

  //     var _map = {
  //       'order_id': orderID,
  //       'prize_qrcode_image_url': prizeUrl,
  //     };
  //     try {
  //       var _body = await HttpUtils.post(HttpApi.acceptPrize, data: _map);
  //       // logD('acceptPrize, _body: $_body');
  //       var code = _body['code'];
  //       var errmsg = _body['msg'];
  //       if (code == 200) {
  //         _completer.complete(true);
  //       } else {
  //         // return Future.error(errmsg);
  //         logE(errmsg);
  //         _completer.completeError('用户领奖出错');
  //       }
  //     } catch (e) {
  //       logE(e);
  //       return Future.error(e);
  //     } finally {
  //       logD('OrderMod.acceptPrize end.');
  //     }
  //   }, (errmsg) {
  //     logD('上传失败, $errmsg');
  //   }, (percent) {
  //     //上传进度
  //   });
  //   return f;
  // }

  /// 用户领奖，发起收款码 , 需要加密
  static Future<dynamic> acceptPrize(
      String orderID, String storeUserName, String prizeQrcodefile) async {
    Completer _completer = new Completer.sync();
    Future f = _completer.future;

    OrderMod.encryptAndUploadFile(prizeQrcodefile, storeUserName: storeUserName)
        .then((prizeUrl) async {
      logD('上传加密拍照图片成功:$prizeUrl');
      var _map = {
        'order_id': orderID,
        'prize_qrcode_image_url': prizeUrl,
      };
      try {
        var _body = await HttpUtils.post(HttpApi.acceptPrize, data: _map);
        // logD('acceptPrize, _body: $_body');
        var code = _body['code'];
        var errmsg = _body['msg'];
        if (code == 200) {
          _completer.complete(true);
        } else {
          logE(errmsg);
          _completer.completeError('用户领奖出错');
        }
      } catch (e) {
        logE(e);
        return Future.error(e);
      } finally {
        logD('OrderMod.acceptPrize end.');
      }
    }).catchError((e) {
      logE(e);
    });
    return f;
  }

  /// 根据订单id获取用户兑奖收款码
  static Future<dynamic> getPrizeUrl(String orderID) async {
    Completer _completer = new Completer.sync();
    Future f = _completer.future;

    try {
      var _body = await HttpUtils.get(HttpApi.acceptPrizeUrl + '/' + orderID);
      // logD('getPrizeUrl, _body: $_body');
      var code = _body['code'];
      var errmsg = _body['msg'];
      if (code == 200) {
        _completer.complete(_body['data']);
      } else {
        // return Future.error(errmsg);
        logE(errmsg);
        _completer.completeError('根据订单id获取用户兑奖收款码出错');
      }
    } catch (e) {
      logE(e);
      return Future.error(e);
    } finally {
      logD('OrderMod.getPrizeUrl end.');
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
      logD('_body: $_body');
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
      logD('getOrderLists end.');
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

  /// 商家出票后拍照上传
  static Future uploadorderimage(
    String filename, //源文件
    String orderID,
    String image,
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

      var _body = await HttpUtils.post(HttpApi.uploadorderimage, data: _map);
      // logD('_body:  $_body');
      if (_body['code'] == 200) {
        _completer.complete(true);
      } else {
        logE('uploadorderimage error, msg: ${_body['msg']}');
        _completer.completeError('拍照上链出错');
      }
    } catch (e) {
      logE(e);
      _completer.completeError('无法上传拍照图片');
    } finally {
      logD('uploadorderimage end.');
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
      logD('_body: ${_body}');
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

  /// @nodoc 计算出 加密密钥
  /// [otherPubkey] 对方的公钥
  /// [myPrivate] 本地的私钥
  static String calculateAgreement(String otherPubkey, String myPrivate) {
    Uint8List pubKey = Hex.decode(otherPubkey);
    final publicKeyable = DH.Curve.decodePoint(pubKey, 0);

    Uint8List privKey = Hex.decode(myPrivate);

    final sharedSecret = DH.Curve.calculateAgreement(
        publicKeyable, DH.Curve.decodePrivatePoint(privKey));

    return Hex.encode(sharedSecret); //64个字符的hex
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

  ///@nodoc 加密文件内容并上传到阿里云oss
  ///源文件需要复制到文档目录 , 并存入map来管理这些图片及对应的阿里云obj
  ///filename 源文件，未加密
  ///storeUserName 是商户的注册id
  static Future encryptAndUploadFile(String filename,
      {String? storeUserName}) async {
    Completer _completer = new Completer.sync();
    Future f = _completer.future;

    String secret = '';
    if (AppManager.isStore) {
      secret = AppManager.storeSecret;
    } else {
      if (storeUserName != null) {
        String publicKeyHex = await UserMod.getRsaPublickey(storeUserName);
        secret = OrderMod.calculateAgreement(
            publicKeyHex, Constant.systemPrivateKey);
      } else {
        return new Future.error('storeUserName is empty');
      }
    }

    Directory saveDir = await getApplicationDocumentsDirectory();

    //计算出图片的hash字符串，用来做文件名
    String _outputFile = await OrderMod.getHash256(filename);

    File file = File(filename);

    Directory orderImgDir = Directory(saveDir.path + '/order_images');
    if (!orderImgDir.existsSync()) {
      orderImgDir.createSync();
      logI('创建订单图片目录成功:' + orderImgDir.path);
    }

    File newFile = await file.copy(orderImgDir.path + '/' + _outputFile);

    FileCryptor fileCryptor = FileCryptor(
      key: secret, //64个字符
      iv: 16,
      dir: orderImgDir.path,
      // useCompress: true,
    );

    File encryptedFile = await fileCryptor.encrypt(
        inputFileFullPath: filename, outputFile: _outputFile);

    logD('完整路径 : ${encryptedFile.absolute.path}');

    UserMod.uploadOssOrderFile(encryptedFile.absolute.path, (String url) async {
      logD('上传加密后的图片成功: $url');

      //缓存到Hive，下次需要展示图片时不需要从阿里云拉取, key是url的md5
      appManager.addOrderImages(url, orderImgDir.path);

      _completer.complete(url);
    }, (String errMsg) {
      logD('上传加密后的图片错误:$errMsg');
      _completer.completeError('上传加密后的图片错误:$errMsg');
    }, (int progress) {
      // logD('上传加密后的图片进度:$progress');
    });

    return f;
  }

  ///@nodoc 加密
  ///publicKeyHex 是对方的公钥
  static Future enCipher(String publicKeyHex, String indata) async {
    Completer _completer = new Completer.sync();
    Future f = _completer.future;

    try {
      ECPublicKey publicKey = DH.Curve.decodePoint(Hex.decode(publicKeyHex), 0);
      logI('publicKey: ${Hex.encode(publicKey.serialize())}');

      //系统私钥
      ECPrivateKey privateKey =
          DjbECPrivateKey(Hex.decode(Constant.systemPrivateKey));

      var sharedSecret = DH.Curve.calculateAgreement(publicKey, privateKey);

      String strkey = base64Encode(sharedSecret);
      var key = SDKCrypt.Key.fromBase64(strkey);

      var encrypter =
          SDKCrypt.Encrypter(SDKCrypt.AES(key, mode: SDKCrypt.AESMode.ecb));
      final iv = SDKCrypt.IV.fromLength(16); //add  by lishijia
      var encrypted = encrypter.encrypt(indata, iv: iv);
      // logI('encrypted: ${encrypted.base16}');
      _completer.complete(encrypted.base16);
    } catch (err) {
      _completer.completeError("加密失败");
    }
    return f;
  }

  ///解密
  ///privateKeyHex 是本地私钥
  static Future deCipher(String privateKeyHex, String inCipther) {
    Completer _completer = new Completer.sync();
    Future f = _completer.future;
    try {
      ECPublicKey publicKey =
          DH.Curve.decodePoint(Hex.decode(Constant.systemPublickey), 0);

      ECPrivateKey privateKey = DjbECPrivateKey(Hex.decode(privateKeyHex));

      var sharedSecret = DH.Curve.calculateAgreement(publicKey, privateKey);

      String strkey = base64Encode(sharedSecret);
      var key = SDKCrypt.Key.fromBase64(strkey);

      var encrypter =
          SDKCrypt.Encrypter(SDKCrypt.AES(key, mode: SDKCrypt.AESMode.ecb));
      final iv = SDKCrypt.IV.fromLength(16); //add  by lishijia
      var decrypted = encrypter.decrypt16(inCipther, iv: iv);
      // print('encrypted: ${decrypted}');
      _completer.complete(decrypted);
    } catch (err) {
      _completer.completeError("解密失败");
    }

    return f;
  }
}
