/*
 用户模块
 */

import 'package:linkme_flutter_sdk/common/http_utils.dart';
import 'package:linkme_flutter_sdk/common/urls.dart';
import 'package:linkme_flutter_sdk/manager/AppManager.dart';
import 'package:linkme_flutter_sdk/models/OssConfig.dart';
import 'package:linkme_flutter_sdk/models/ProposeFeedback.dart';
import 'package:linkme_flutter_sdk/models/RsaKeyPairModel.dart';
import 'package:linkme_flutter_sdk/models/StoreInfo.dart';
import 'package:linkme_flutter_sdk/models/UserInfo.dart';
import 'package:linkme_flutter_sdk/models/UserReport.dart';
// import 'package:linkme_flutter_sdk/sdk/Listeners.dart';
import 'package:libsignal_protocol_dart/src/ecc/curve.dart' as DH;
import 'package:linkme_flutter_sdk/util/hex.dart';

import 'dart:async';
import 'SdkEnum.dart';
import 'package:linkme_flutter_sdk/manager/LogManager.dart';

/// @nodoc 用户类
class UserMod {
  /// @nodoc 从服务器获取当前登录用户的个人资料并保存到users表
  static Future getMyProfile() async {
    assert(AppManager.currentUsername != null);

    Completer _completer = new Completer.sync();
    Future _c = _completer.future;

    ///提交数据
    try {
      var _body = await HttpUtils.get(HttpApi.myProfile);
      logD('_body: $_body');

      if (_body['code'] == 200) {
        var _data = _body['data'];
        UserInfo _user = UserInfo.fromMap(_data);

        AppManager.setUserType(_user.userType!);
        AppManager.setUserState(_user.state!);

        _completer.complete(_user); //返回
      } else {
        logE(' error, msg: ${_body['msg']}');
        return false;
      }
    } catch (e) {
      logE(e);
      _completer.completeError('无法获取${AppManager.currentUsername}的个人资料');
    } finally {
      logD('getMyProfile end.');
    }
    return _c;
  }

  /// @nodoc 修改用户资料
  /// nick - 呢称
  /// gender - 性别
  /// imageKey - 头像的阿里云obj
  /// label - 标签
  /// trueName - 实名
  /// email - 电子邮箱
  /// extend - 扩展信息
  /// province  - 用户所在省份
  /// city  - 用户所在城市
  /// area - 区
  /// address  - 地址
  /// identityCard - 身份证
  static Future updateUserProfile({
    String? nick,
    String? gender,
    String? imageKey,
    String? label,
    String? trueName,
    String? email,
    String? extend,
    String? province,
    String? city,
    String? area,
    String? address,
    String? identityCard,
  }) async {
    Map<String, dynamic> fields = new Map();
    if (nick != null)
      fields['fields[${UserFeildEnum.UserFeildEnum_Nick.index}]'] = nick;

    if (gender != null)
      fields['fields[${UserFeildEnum.UserFeildEnum_Gender.index}]'] = gender;

    if (imageKey != null)
      fields['fields[${UserFeildEnum.UserFeildEnum_Avatar.index}]'] = imageKey;

    if (label != null)
      fields['fields[${UserFeildEnum.UserFeildEnum_Label.index}]'] = label;

    if (trueName != null)
      fields['fields[${UserFeildEnum.UserFeildEnum_TrueName.index}]'] =
          trueName;

    if (email != null)
      fields['fields[${UserFeildEnum.UserFeildEnum_Email.index}]'] = email;

    if (extend != null)
      fields['fields[${UserFeildEnum.UserFeildEnum_Extend.index}]'] = extend;

    if (province != null)
      fields['fields[${UserFeildEnum.UserFeildEnum_Province.index}]'] =
          province;

    if (city != null)
      fields['fields[${UserFeildEnum.UserFeildEnum_City.index}]'] = city;

    if (area != null)
      fields['fields[${UserFeildEnum.UserFeildEnum_Area.index}]'] = area;

    if (address != null)
      fields['fields[${UserFeildEnum.UserFeildEnum_Address.index}]'] = address;

    if (identityCard != null)
      fields['fields[${UserFeildEnum.UserFeildEnum_IdentityCard.index}]'] =
          identityCard;

    logD('fields: $fields');

    Completer _completer = new Completer.sync();
    Future f = _completer.future;

    try {
      var _body = await HttpUtils.post(HttpApi.userprofile, params: fields);
      logD('_body: $_body');

      if (_body['code'] == 200) {
        _completer.complete(_body['data']);
      } else {
        logE("修改用户资料出错 , ${_body['code']} , msg ${_body['msg']}");
        return new Future.error('修改用户资料 ,错误信息:  ${_body['msg']}');
      }
    } catch (e) {
      logD(e);
      _completer.completeError('无法修改用户资料');
    }
    return f;
  }

  /// @nodoc 根据手机获取注册id
  static Future getUserIDFromServerByMobile(String mobile) async {
    Completer _completer = new Completer.sync();
    Future _c = _completer.future;

    ///提交数据
    try {
      var _body = await HttpUtils.get(
        HttpApi.getId + '/' + mobile,
      );
      logD('_body: $_body');
      if (_body['code'] == 200) {
        var _data = _body['data'];
        logD('_data: ${_data.toString()}');
        _completer.complete(_data);
      } else {
        logE("根据手机获取注册id出错 , ${_body['code']} , msg ${_body['msg']}");
        return new Future.error('根据手机获取注册id出错 ,错误信息:  ${_body['msg']}');
      }
    } catch (e) {
      logD(e);
      _completer.completeError('无法获取 $mobile 对应的注册id');
    } finally {
      logD('getUserIDFromServerByMobile end.');
    }
    return _c;
  }

  /// @nodoc 用户绑定手机
  static Future userBindMobile(String mobile, String smscode) async {
    Completer _completer = new Completer.sync();
    Future _c = _completer.future;

    ///提交数据
    try {
      var _map = {
        'mobile': mobile,
        'smscode': smscode,
      };
      var _body = await HttpUtils.post(HttpApi.bindmobile, data: _map);
      logD('_body: $_body');
      if (_body['code'] == 200) {
        await AppManager.setMobile(mobile); //修改本地手机
        _completer.complete(true);
      } else {
        logE("用户绑定手机出错 , ${_body['code']} , msg ${_body['msg']}");
        return new Future.error('用户绑定手机出错 ,错误信息:  ${_body['msg']}');
      }
    } catch (e) {
      logD(e);
      _completer.completeError('无法绑定手机');
    }
    return _c;
  }

  /// @nodoc 用户绑定微信
  static Future userBindWechat(String wechatCode) async {
    Completer _completer = new Completer.sync();
    Future _c = _completer.future;

    ///提交数据
    try {
      var _map = {
        ' ': wechatCode,
      };
      var _body = await HttpUtils.post(HttpApi.bindwechat, data: _map);
      logD('_body: $_body');
      if (_body['code'] == 200) {
        _completer.complete(_body['data']); //TODO 由UI来询问用户是否采用微信呢称 及 头像
      } else {
        logE("用户绑定微信出错 , ${_body['code']} , msg ${_body['msg']}");
        return new Future.error('用户绑定微信出错 ,错误信息:  ${_body['msg']}');
      }
    } catch (e) {
      logD(e);
      _completer.completeError('无法绑定微信');
    }
    return _c;
  }

  /// @nodoc 查询用户消息推送设置
  static Future getPushSetting() async {
    Completer _completer = new Completer.sync();
    Future _c = _completer.future;

    ///提交数据
    try {
      var _body = await HttpUtils.get(HttpApi.pushsetting);
      logD('_body: $_body');
      if (_body['code'] == 200) {
        _completer.complete(_body['data']);
      } else {
        logE("查询用户消息推送设置出错, ${_body['code']} , msg ${_body['msg']}");
        return new Future.error('查询用户消息推送设置出错, 错误信息:  ${_body['msg']}');
      }
    } catch (e) {
      logD(e);
      _completer.completeError('查询用户消息推送设置失败');
    }
    return _c;
  }

  /// @nodoc 查询用户是否绑定了微信
  static Future isBindWechat() async {
    Completer _completer = new Completer.sync();
    Future _c = _completer.future;

    ///提交数据
    try {
      var _body = await HttpUtils.get(HttpApi.isbindwechat);
      logD('_body: $_body');
      if (_body['code'] == 200) {
        _completer.complete(_body['data']);
      } else {
        logE("查询用户是否绑定了微信出错 , ${_body['code']} , msg ${_body['msg']}");
        _completer.completeError('查询用户是否绑定了微信出错, 错误信息:  ${_body['msg']}');
      }
    } catch (e) {
      logD(e);
      _completer.completeError('查询用户是否绑定了微信失败');
    }
    return _c;
  }

  /// @nodoc 用户解除绑定微信
  static Future unBindMobile() async {
    Completer _completer = new Completer.sync();
    Future _c = _completer.future;

    ///提交数据
    try {
      var _body = await HttpUtils.get(HttpApi.unbindmobile);
      logD('_body: $_body');
      if (_body['code'] == 200) {
        _completer.complete(true);
      } else {
        logE("用户解除绑定微信出错 , ${_body['code']} , msg ${_body['msg']}");
        _completer.completeError('用户解除绑定微信出错, 错误信息:  ${_body['msg']}');
      }
    } catch (e) {
      logD(e);
      _completer.completeError('用户解除绑定微信失败');
    }
    return _c;
  }

  /// @nodoc 用户消息推送设置更改
  static Future modifyPushSetting(
      bool newRemindSwitch, bool detailSwitch, bool soundSwitch) async {
    Completer _completer = new Completer.sync();
    Future _c = _completer.future;

    ///提交数据
    try {
      var _map = {
        'new_remind_switch': newRemindSwitch,
        'detail_switch': detailSwitch,
        'sound_switch': soundSwitch,
      };
      var _body = await HttpUtils.post(HttpApi.pushsetting, data: _map);
      logD('_body: $_body');
      if (_body['code'] == 200) {
        _completer.complete(true);
      } else {
        logE("用户消息推送设置更改出错 , ${_body['code']} , msg ${_body['msg']}");
        return new Future.error('用户消息推送设置更改出错, 错误信息:  ${_body['msg']}');
      }
    } catch (e) {
      logD(e);
      _completer.completeError('更改用户消息推送设置失败');
    }
    return _c;
  }

  /// @nodoc 根据组合条件获取店铺列表
  static Future getStoreList(dynamic data) async {
    Completer _completer = new Completer.sync();
    Future _c = _completer.future;

    ///提交数据
    try {
      var _body = await HttpUtils.post(HttpApi.storeList, data: data);
      logD('_body: $_body');

      if (_body['code'] == 200) {
        var totalPage = _body['data']['totalPage'];
        var _list = _body['data']['stores'];
        List<StoreInfo> stores = [];
        _list.forEach((val) {
          stores.add(StoreInfo.fromMap(val));
        });

        _completer.complete(stores); //返回
      }
    } catch (e) {
      logD(e);
      _completer.completeError('无法 根据组合条件获取店铺列表');
    } finally {
      logD('getStoreList end.');
    }
    return _c;
  }

  /// @nodoc 根据商户注册id ，从服务端获取店铺资料
  static Future getStoreInfoFromServer(String businessUsername) async {
    Completer _completer = new Completer.sync();
    Future _c = _completer.future;

    ///提交数据
    try {
      var _body = await HttpUtils.get(
        HttpApi.storeInfo + '/' + businessUsername,
      );
      logD('_body: $_body');

      if (_body['code'] == 200) {
        var _data = _body['data'];
        StoreInfo storeInfo = StoreInfo.fromMap(_data);

        _completer.complete(storeInfo); //返回
      }
    } catch (e) {
      logD(e);
      _completer.completeError('无法获取$businessUsername的店铺资料');
    } finally {
      logD('getStoreInfoFromServer end.');
    }
    return _c;
  }

  ///  @nodoc 上传用户设备信息
  static Future userUploadDeviceInfo(dynamic _map) async {
    ///提交数据
    try {
      var _body =
          await HttpUtils.post(HttpApi.userUploadDeviceInfo, data: _map);

      logD('_body: ${_body}');

      if (_body['code'] == 200) {
        return _body['data'];
      } else {
        logE("上传用户设备信息出错 , ${_body['code']} , msg ${_body['msg']}");
        return new Future.error('上传用户设备信息出错 ,错误信息:  ${_body['msg']}');
      }
    } catch (e) {
      logE(e);
      return new Future.error('上传用户设备信息接口出错');
    } finally {
      logD('UserMod.userUploadDeviceInfo end.');
    }
  }

  /// @nodoc 获取当前用户的阿里云oss的临时令牌
  static Future getOssToken([bool isPrivate = false]) async {
    Completer _completer = new Completer.sync();
    Future f = _completer.future;

    try {
      var _body = await HttpUtils.get(HttpApi.osstoken);
      logD('_body: $_body');

      var code = _body['code'];
      if (code == 200) {
        var _data = _body['data'];
        AppManager.ossConfig = AppManager.ossConfig ?? new OssConfig();
        AppManager.ossConfig!.endPoint = _data['endPoint'];
        AppManager.ossConfig!.bucketName = _data['bucketName'];
        AppManager.ossConfig!.accessKeyId = _data['accessKeyId'];
        AppManager.ossConfig!.accessKeySecret = _data['accessKeySecret'];
        AppManager.ossConfig!.securityToken = _data['securityToken'];
        AppManager.ossConfig!.expiration = _data['expiration'];
        AppManager.ossConfig!.expire = _data['expire'];
        AppManager.ossConfig!.directory = _data['directory'];
        return true;
      } else {
        return false;
      }
    } catch (e) {
      logE(e);
    } finally {
      logD('AuthMod.postDefaultOpk end.');
    }

    return f;
  }

  /// @nodoc oss 上传 到 订单的位置
  /// [file] 本地文件
  /// [onDone] 上传成功回调
  /// [onFail] 上传失败回调
  /// [onProgress] 上传进度
  static Future uploadOssOrderFile(String file, void onDone(String key),
      void onFail(String errmsg), void onProgress(int percent)) async {
    return appManager.uploadAly('orders', file, onDone, onFail, onProgress);
  }

  /// @nodoc oss 上传
  /// [file] 本地文件
  /// [moduleName] 模块名称,字母s结尾(msg除外)
  /// [onDone] 上传成功回调
  /// [onFail] 上传失败回调
  /// [onProgress] 上传进度
  static Future uploadOssFile(
      String file,
      String moduleName,
      void onDone(String key),
      void onFail(String errmsg),
      void onProgress(int percent)) async {
    return appManager.uploadAly(moduleName, file, onDone, onFail, onProgress);
  }

  /// @nodoc oss 上传 到 消息的位置
  /// [file] 本地文件
  /// [onDone] 上传成功回调
  /// [onFail] 上传失败回调
  /// [onProgress] 上传进度
  static Future uploadOssMsgFile(String file, void onDone(String key),
      void onFail(String errmsg), void onProgress(int percent)) async {
    return appManager.uploadAly('msg', file, onDone, onFail, onProgress);
  }

  // /// @nodoc oss 上传 到 商品的位置
  // /// [file] 本地文件
  // /// [onDone] 上传成功回调
  // /// [onFail] 上传失败回调
  // /// [onProgress] 上传进度
  // static Future uploadOssProductFile(String file, void onDone(String key),
  //     void onFail(String errmsg), void onProgress(int percent)) async {
  //   return appManager.uploadAly('products', file, onDone, onFail, onProgress);
  // }

  /// @nodoc 关注商户
  static Future watchingStore(String storeUsername) async {
    if (storeUsername == AppManager.currentUsername) {
      return new Future.error('不能关注自己');
    }
    Completer _completer = new Completer.sync();
    Future _c = _completer.future;

    ///提交数据
    try {
      var _map = {
        'store_user_name': storeUsername,
      };
      var _body = await HttpUtils.post(HttpApi.storeWatching, data: _map);
      logD('_body: $_body');
      if (_body['code'] == 200) {
        _completer.complete('关注此商户成功');
      } else {
        logE("关注商户出错 , ${_body['code']} , msg ${_body['msg']}");
        return new Future.error('关注商户出错 ,错误信息:  ${_body['msg']}');
      }
    } catch (e) {
      logD(e);
      _completer.completeError('无法关注商户');
    }
    return _c;
  }

  /// 获取当前用户的关注商户
  static Future getWatchingStores() async {
    Completer _completer = new Completer.sync();
    Future _c = _completer.future;

    ///提交数据
    try {
      var _body = await HttpUtils.get(HttpApi.storeWatching);

      if (_body['code'] == 200) {
        var _list = _body['data'];
        logD('_list: $_list');

        List<StoreInfo> stores = [];

        _list.forEach((val) {
          stores.add(StoreInfo.fromMap(val));
        });

        _completer.complete(stores); //返回
      } else {
        logE(' error, msg: ${_body['msg']}');
        return false;
      }
    } catch (e) {
      logE(e);
      _completer.completeError('获取当前用户的关注商户');
    } finally {
      logD('getWatchingStores end.');
    }
    return _c;
  }

  /// @nodoc 取消关注商户
  static Future cancelWatchingStore(String storeUsername) async {
    if (storeUsername == AppManager.currentUsername) {
      return new Future.error('不能取消关注自己');
    }
    Completer _completer = new Completer.sync();
    Future _c = _completer.future;

    ///提交数据
    try {
      var _map = {
        'store_user_name': storeUsername,
      };
      var _body = await HttpUtils.post(HttpApi.cancelWatching, data: _map);
      logD('_body: $_body');
      if (_body['code'] == 200) {
        _completer.complete('取消关注此商户成功');
      } else {
        logE("取消关注商户出错 , ${_body['code']} , msg ${_body['msg']}");
        return new Future.error('取消关注商户出错 ,错误信息:  ${_body['msg']}');
      }
    } catch (e) {
      logD(e);
      _completer.completeError('无法取消关注商户');
    }

    return _c;
  }

  /// @nodoc 完善当前商户资料并提交审核, 用于普通用户提交资料，可以重复提交，服务端会以最后一次提交保存
  static Future completeBusinessUserAudit({
    int? storeType, // 1-福彩 2-体彩, 3-公证处 4- ...
    String? branchesname, //网点全称
    String? imageUrl, //网点形象照片，会展示在app店铺列表
    String? contactMobile, //联系手机
    String? wechat, //微信号
    String? legalPerson, //法人姓名
    String? legalIdentityCard, //法人身份证号码
    String? idCardFrontPhoto, //法人身份证正面拍照
    String? idCardBackPhoto, //法人身份证背面拍照
    String? licenseUrl, //营业执照拍照
    String? introductory, //简介
    String? province, //省
    String? city, //市
    String? area, //区
    String? address, //地址
    String? keys, //搜索关键字
    String? businessCode, //网点编码，彩票中心颁发
    String? longitude, //精度
    String? latitude, //纬度
    String? openingHours, //营业时间
    String? cardOwner, //银行卡持卡人
    String? bankName, //开户银行
    String? bankBranch, //所在支行
    String? cardNumber, //银行卡卡号
  }) async {
    StoreInfo storeInfoData = new StoreInfo(
      storeType: storeType,
      branchesName: branchesname,
      imageUrl: imageUrl,
      contactMobile: contactMobile,
      wechat: wechat,
      legalPerson: legalPerson,
      legalIdentityCard: legalIdentityCard,
      idCardFrontPhoto: idCardFrontPhoto,
      idCardBackPhoto: idCardBackPhoto,
      licenseUrl: licenseUrl,
      introductory: introductory,
      province: province,
      city: city,
      area: area,
      address: address,
      keys: keys,
      businessCode: businessCode,
      longitude: longitude,
      latitude: latitude,
      openingHours: openingHours,
      cardOwner: cardOwner,
      bankName: bankName,
      bankBranch: bankBranch,
      cardNumber: cardNumber,
    );

    ///提交数据
    try {
      var _body =
          await HttpUtils.post(HttpApi.addStore, data: storeInfoData.toJson());
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
      logD('AuthMod.completeBusinessUserAudit end.');
    }
  }

  /// @nodoc 当前商户修改资料,用于商户修改资料
  static Future updateStoreInfo({
    String? branchesName, //网点名称
    String? imageUrl, //网点形象图片
    String? introductory, //简介
    String? province, //省
    String? city, //市
    String? area, //区
    String? address, //地址
    String? keys, //关键字
    String? contactMobile, // 联系电话
    String? wechat, //微信
    String? businessCode, //网点编码
    String? longitude, //经度
    String? latitude, //纬度
    String? openingHours, //营业时间
  }) async {
    Map<String, dynamic> fields = new Map();
    if (branchesName != null) fields['fields[1]'] = branchesName;

    if (imageUrl != null) fields['fields[2]'] = imageUrl;

    if (introductory != null) fields['fields[3]'] = introductory;

    if (province != null) fields['fields[4]'] = province;

    if (city != null) fields['fields[5]'] = city;

    if (area != null) fields['fields[6]'] = area;

    if (address != null) fields['fields[7]'] = address;

    if (keys != null) fields['fields[8]'] = keys;

    if (contactMobile != null) fields['fields[9]'] = contactMobile;

    if (wechat != null) fields['fields[10]'] = wechat;

    if (businessCode != null) fields['fields[11]'] = businessCode;

    if (longitude != null) fields['fields[12]'] = longitude;

    if (latitude != null) fields['fields[13]'] = latitude;

    if (openingHours != null) fields['fields[14]'] = openingHours;

    logD('fields: $fields');

    Completer _completer = new Completer.sync();
    Future f = _completer.future;

    try {
      var _body = await HttpUtils.post(HttpApi.updateStore, params: fields);
      logD('_body: $_body');

      if (_body['code'] == 200) {
        _completer.complete(_body['data']);
      } else {
        logE("修改商户资料出错 , ${_body['code']} , msg ${_body['msg']}");
        return new Future.error('修改商户资料 ,错误信息:  ${_body['msg']}');
      }
    } catch (e) {
      logD(e);
      _completer.completeError('无法修改商户资料');
    }
    return f;
  }

  /// 商户专用方法， 查询申请成为商户的审核进度,0-审核中，1-审核通过，2-审核不通过
  static Future getAuditState() async {
    Completer _completer = new Completer.sync();
    Future _c = _completer.future;

    ///提交数据
    try {
      var _body = await HttpUtils.get(HttpApi.auditState);
      logD('_body: $_body');

      if (_body['code'] == 200) {
        var _data = _body['data'];
        _completer.complete(_data); //返回
      } else {
        logE(' error, msg: ${_body['msg']}');
        return false;
      }
    } catch (e) {
      logE(e);
      _completer.completeError('无法获取审核进度');
    } finally {
      logD('getAuditStatus end.');
    }
    return _c;
  }

  /// @nodoc 提交建议和反馈
  static Future submitProposeFeedback({
    String? title, //标题
    String? detail, //建议的内容
    String? image1, //图片1
    String? image2, //图片2
  }) async {
    ProposeFeedbackData _propose = new ProposeFeedbackData(
      userName: AppManager.currentUsername,
      title: title,
      detail: detail,
      image1: image1,
      image2: image2,
    );

    ///提交数据
    try {
      var _body = await HttpUtils.post(HttpApi.submitProposeFeedback,
          data: _propose.toJson());
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
      logD('AuthMod.submitProposeFeedback end.');
    }
  }

  /// @nodoc 提交举报
  static Future submitReport({
    int? type, //类型
    String? description, //举报的内容
    String? image1, //图片1
    String? image2, //图片2
  }) async {
    UserReportData _propose = new UserReportData(
      userName: AppManager.currentUsername,
      type: type,
      description: description,
      image1: image1,
      image2: image2,
    );

    ///提交数据
    try {
      var _body =
          await HttpUtils.post(HttpApi.submitReport, data: _propose.toJson());
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
      logD('UserMod.submitReport end.');
    }
  }

  /// 商户生成Rsa公私钥对，只是当服务端返回的公钥为空时生成
  static RsaKeyPairModel generateRsaKeyPair() {
    var pair = DH.Curve.generateKeyPair();

    String privKey = Hex.encode(pair.privateKey.serialize());
    String pubKey = Hex.encode(pair.publicKey.serialize());

    logD('pubKey: $pubKey');
    logD('privKey: $privKey');

    return RsaKeyPairModel(
      privateKey: privKey,
      publicKey: pubKey,
    );
  }

  /// 商户上传Rsa公钥
  static Future uploadRsaPublickey(String publicKey) async {
    Completer _completer = new Completer.sync();
    Future _c = _completer.future;

    try {
      var _map = {'public_key': publicKey};

      var _body = await HttpUtils.post(HttpApi.uploadPublickey, data: _map);
      // logD('_body: ${_body}');
      var errmsg = _body['msg'];
      if (_body['code'] == 200) {
        // var _data = _body['data'];
        // logD('商户上传Rsa公钥成功');
        _completer.complete('商户上传Rsa公钥成功');
      } else {
        logE('商户上传Rsa公钥 error, msg: $errmsg');
        _completer.completeError('商户上传Rsa公钥出错');
      }
    } catch (e) {
      logE(e);
      return new Future.error('接口出错');
    }

    return _c;
  }

  /// 买家获取指定商户的公钥,用于图片附件的加密
  static Future getRsaPublickey(String businessUsername) async {
    Completer _completer = new Completer.sync();
    Future f = _completer.future;

    try {
      var _body = await HttpUtils.get(HttpApi.rsaPublickey+ '/' + businessUsername);
      logD('getRsaPublickey _body: $_body');
      if (_body['code'] == 200) {
        _completer.complete(_body['data']);
      } else {
        logE("买家获取商户的公钥出错, ${_body['code']} , msg ${_body['msg']}");
        return new Future.error('买家获取商户的公钥出错, 错误信息:  ${_body['msg']}');
      }
    } catch (e) {
      logD(e);
      _completer.completeError('买家获取商户的公钥失败');
    }

    return f;
  }

/*
  /// 商户专用方法，上报默认opk
  static Future postDefaultOpk(DefaultOpkData defaultOpkData) async {
    try {
      var _body =
          await HttpUtils.post(HttpApi.defaultopk, data: defaultOpkData);
      logD('_body: $_body');

      var code = _body['code'];
      if (code == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      logE(e);
    } finally {
      logD('AuthMod.postDefaultOpk end.');
    }
  }
  */
}
