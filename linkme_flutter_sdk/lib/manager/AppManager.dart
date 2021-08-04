import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'dart:async';

import 'package:linkme_flutter_sdk/common/common.dart';
import 'package:linkme_flutter_sdk/common/http_utils.dart';
import 'package:linkme_flutter_sdk/common/urls.dart';
import 'package:linkme_flutter_sdk/manager/EventsManagers.dart';
import "package:linkme_flutter_sdk/base_enum.dart";
import 'package:linkme_flutter_sdk/models/OssConfig.dart';
import 'package:linkme_flutter_sdk/net/wsHandler.dart';
import 'package:linkme_flutter_sdk/sdk/OrderMod.dart';
import 'package:linkme_flutter_sdk/sdk/SdkEnum.dart';
import 'package:linkme_flutter_sdk/sdk/UserMod.dart';
import 'package:linkme_flutter_sdk/util/file_cryptor.dart';
import 'package:linkme_flutter_sdk/util/md5.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:linkme_flutter_sdk/models/OrderInfo.dart';
import 'package:linkme_flutter_sdk/isolate/repositories/Repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/common.dart';
import 'package:aly_oss/aly_oss.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'LogManager.dart';

const bucketName = 'lianmi-ipfs';

class AppManager {
  //是否生产环境
  static bool _isProduct = true;
  static bool get isProduct => _isProduct;

  static setIsProduct(bool isPro) {
    _isProduct = isPro;
  }

  static int innerTaskid = 1;

  static SharedPreferences? prefs;

  static Function(String msg)? onTokenExpire;

  //用于服务端下发订单数据的回调s
  static Function(OrderInfoData orderInfoData)? onReceiveOrder;

  //私有构造函数
  AppManager._internal();
  static final AppManager api = new AppManager._internal();

  //工厂构造函数
  factory AppManager() => api;

  // static Result defaultCityAttr = new Result(); //记忆默认城市选择器

  static String? _requestId;
  static String get requestId => _requestId!;
  static int _aliyunTokenExpire = 0; //阿里云临时令牌过期时长
  static int _aliyunTokenAt = 0; //阿里云临时令牌获取时刻 秒

  static String _curVersion = '1.0.0';

  static String get curVersion {
    return _curVersion;
  }

  static void setVersion(String version) {
    _curVersion = version;
  }

  static String? get os {
    if (Platform.isIOS) {
      //ios相关代码
      return 'ios';
    } else if (Platform.isAndroid) {
      //android相关代码
      return 'android';
    }
  }

  static Directory? _appDocumentDir;

  static Directory? get appDocumentDir {
    return _appDocumentDir;
  }

  /// 当前的手机
  static String? _currentMobile;

  /// 外部获取最后一次登用户手机
  static String? get currentMobile {
    if (_currentMobile == null && prefs != null) {
      _currentMobile = prefs!.getString(Constant.lastMobile);
    }
    return _currentMobile;
  }

  ///设置最后一次登用户手机
  static Future setMobile(String? mobile) async {
    if (mobile == null) return;
    assert(prefs != null);
    _currentMobile = mobile;

    if (prefs != null) {
      await prefs!.setString(Constant.lastMobile, mobile); //持久化
    }
    return;
  }

  /// 当前的用户id
  static String? _currentUsername;

  /// 外部获取最后一次登录成功的用户id
  static String? get currentUsername {
    if (_currentUsername == null && prefs != null) {
      if (prefs != null) {
        _currentUsername = prefs!.getString(Constant.lastLoginName);
      }
    }
    return _currentUsername;
  }

  ///设置用户id
  static void setUsername(String username) async {
    _currentUsername = username;
    if (prefs != null) {
      await prefs!.setString(Constant.lastLoginName, username); //持久化

    }
  }

  /// 用户类型, 1-普通，2-商户
  static UserTypeEnum _currentUserType = UserTypeEnum.UserTypeEnum_Undefined;

  /// 外部获取用户类型
  static UserTypeEnum get currentUserType {
    if (prefs != null) {
      _currentUserType =
          UserTypeEnum.values[prefs!.getInt(Constant.lastLoginUserType)!];
    }
    return _currentUserType;
  }

  /// 设置用户类型
  static void setUserType(int userType) async {
    _currentUserType = UserTypeEnum.values[userType];
    if (prefs != null) {
      await prefs!.setInt(Constant.lastLoginUserType, userType); //持久化
    }
  }

  /// 当前的用户状态,  0-普通用户，非VIP 1-付费用户(购买会员) 2-封号
  static int _currentUserState = 0;

  static bool _isVip = false;
  static bool get isVip => _isVip;

  static bool _isStore = false;
  static bool get isStore => _isStore;

  /// 外部获取用户状态
  static int get currentUserState {
    if (prefs != null) {
      _currentUserState = prefs!.getInt(Constant.lastLoginState)!;
    }
    logD('外部获取用户状态:$_currentUserState');
    // _isVip = _currentUserState == 1;
    return _currentUserState;
  }

  /// 设置用户状态
  static void setUserState(int state) async {
    _currentUserState = state;
    _isVip = _currentUserState == 1;
    if (prefs != null) {
      await prefs!.setInt(Constant.lastLoginState, state); //持久化
    }
  }

  /// 当前用户token
  static String? _currentToken;

  /// 外部获取用户令牌
  static String? get currentToken {
    if (_currentToken == null && prefs != null) {
      _currentToken = prefs!.getString(Constant.lastLoginToken);
    }
    return _currentToken;
  }

  /// 设置用户令牌
  static void setJwtToken(String token) async {
    _currentToken = token;
    if (prefs != null) {
      await prefs!.setString(Constant.lastLoginToken, token); //持久化
    }
  }

  /// 当前用户的登录是否成功
  static bool _isLogined = false;

  /// 当前用户的登录是否成功的标识
  static bool get isLogined {
    if (prefs != null) {
      _isLogined = prefs!.getBool(Constant.isLogined) ?? false;
    }
    return _isLogined;
  }

  /// 设置用户登录是否成功
  static void setIsLogined(bool islogin) async {
    _isLogined = islogin;
    if (prefs != null) {
      prefs!.setBool(Constant.isLogined, islogin);
    }
  }

  /// 当前用户的最后登录时间戳，如果收到离线的 SignOut, 必须对比，如果SignOut时间戳比较早，则不做登出处理
  static int _latestLoginTimeAt = 0;

  /// 获取当前用户的最后登录时间戳
  static int? get latestLoginTimeAt {
    if (prefs != null) {
      return prefs!.getInt(Constant.lastLoginTimeAt);
    }
  }

  /// 设置当前用户的最后登录时间戳
  static void setLatestLoginTimeAt(int timeAt) async {
    _latestLoginTimeAt = timeAt;
    if (prefs != null) {
      prefs!.setInt(Constant.lastLoginTimeAt, timeAt);
    }
  }

  /// 商户的加解密协商秘钥
  static String _storeSecret = '';

  /// 外部获取商户的加解密协商秘钥
  static String get storeSecret {
    return _storeSecret;
  }

  static String _provinceId = '440000'; //初始省
  static String _cityId = '440100'; //初始城市

  /// 外部获取最后一次省份id
  static String? get provinceId {
    if (prefs != null) {
      if (prefs!.getString(Constant.provinceId) != null)
        _provinceId = prefs!.getString(Constant.provinceId)!;
    }
    return _provinceId;
  }

  ///设置最后一次省份id
  static void setProvinceId(String provinceId) async {
    _provinceId = provinceId;
    if (prefs != null) {
      await prefs!.setString(Constant.provinceId, provinceId); //持久化

    }
  }

  /// 外部获取最后一次城市id
  static String? get cityId {
    if (prefs != null) {
      if (prefs!.getString(Constant.cityId) != null)
        _cityId = prefs!.getString(Constant.cityId)!;
    }
    return _cityId;
  }

  ///设置最后一次省份id
  static void setCityId(String cityId) async {
    _cityId = cityId;
    if (prefs != null) {
      await prefs!.setString(Constant.cityId, cityId); //持久化

    }
  }

  // 商户本地公私钥对
  static String _localPubkey = '';
  static String _localPrikey = '';

  static String get localPubkey {
    return _localPubkey;
  }

  /// 外部设置当前商户的协商公钥
  static void setLocalPubkey(String pubKey) async {
    _localPubkey = pubKey;
    if (prefs != null) {
      await prefs!.setString(Constant.localPubkey, pubKey); //持久化

    }
  }

  static String get localPrikey {
    return _localPrikey;
  }

  /// 外部设置当前商户的协商私钥
  static void setLocalPrikey(String priKey) async {
    _localPrikey = priKey;
    if (prefs != null) {
      await prefs!.setString(Constant.localPrikey, priKey); //持久化

    }
  }

  /// 全局的订单加密及未加密图片映射关系管理器
  late Box<dynamic> _box;

  /// 全局的数据仓库管理器
  static Map<String, Repository> _repositories = new Map();

  /// 全局的Repository
  static Repository? gRepository;

  /// 存储阿里云oss
  static OssConfig? ossConfig;

  void addEvent() {}

  ///初始化dio
  void initDio() {
    HttpUtils.init(
        baseUrl: HttpApi.baseUrl, connectTimeout: 5000, receiveTimeout: 5000);
    return;
  }

  static AlyOss _alyOss = AlyOss();
  AlyOss get alyOss => _alyOss;

  static StreamSubscription<UploadResponse>? _subscription;
  static StreamSubscription<ProgressResponse>? _onProgressSubscription;

  StreamSubscription<UploadResponse>? get subscription => _subscription;
  StreamSubscription<ProgressResponse>? get onProgressSubscription =>
      _onProgressSubscription;

  /// 统一初始化入口
  init() async {
    LogManager.instance()
        .init(SDKLogLevel.debug, output: LogOutputEnum.console);

    prefs = await SharedPreferences.getInstance();

    _appDocumentDir = await getApplicationDocumentsDirectory();

    initDio(); //初始化Dio

    //初始化Hive
    Directory directory = await pathProvider.getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    _box = await Hive.openBox('order_images');

    if (prefs != null) {
      _currentUsername = prefs!.getString(Constant.lastLoginName);
      if (prefs!.getString(Constant.localPrikey) != null) {
        _localPrikey = prefs!.getString(Constant.localPrikey)!;
        _localPubkey = prefs!.getString(Constant.localPubkey)!;
      }
    }

    //当SP里的用户账号非空的时候, 需要初始化数据库
    if (_currentUsername != null && _currentUsername != '') {
      logD(
          'SP里的用户账号非空: $_currentUsername, rsa私钥: $_localPrikey, rsa公钥: $_localPubkey');

      /// 初始化数据仓库
      bool isCreated = await initUserIsolate();
      if (isCreated) {
        bool isConnected = await gRepository!.init(); //必须先create
        if (isConnected) {
          _currentMobile = prefs!.getString(Constant.lastMobile);
          _currentToken = prefs!.getString(Constant.lastLoginToken);

          int userType = 1; //默认是普通用户
          if (prefs!.getInt(Constant.lastLoginUserType) != null) {
            userType = prefs!.getInt(Constant.lastLoginUserType)!;
          } else {
            await prefs!.setInt(Constant.lastLoginUserType, userType); //持久化
          }

          _currentUserType = UserTypeEnum.values[userType];
          _currentUserState = prefs!.getInt(Constant.lastLoginState)!;

          _isVip = _currentUserState == 1;
          _isStore = _currentUserType == UserTypeEnum.UserTypeEnum_Business;

          if (_isStore) {
            if (_localPubkey == '') {
              String _tempPublicKey =
                  await UserMod.getRsaPublickey(_currentUsername!);

              if (_tempPublicKey == '') {
                logW('商户在服务端没有rsa公钥');
                var pair = UserMod.generateRsaKeyPair();
                setLocalPrikey(pair.privateKey!);
                setLocalPubkey(pair.publicKey!);
                UserMod.uploadRsaPublickey(pair.publicKey!).then((value) {
                  logD('商户上传rsa公钥成功');
                }).catchError((e) {
                  logE(e);
                });
              }
            }

            // 商户的加解密秘钥
            try {
              _storeSecret = OrderMod.calculateAgreement(
                  Constant.systemPublickey, _localPrikey);
            } catch (e) {
              logE(e);
            }
          }

          /// 初始化各种业务事件
          eventsManagers.init();

          //连接ws server
          websocketfactory.create(_currentToken!);
          websocketfactory.doLogin();
        } else {
          return new Future.error('数据库进程初始化失败');
        }
      } else {
        return new Future.error('初始化数据仓库失败');
      }
    } else {
      logD('SP里的用户账号为空: $_currentUsername');
    }
  }

  /// 根据登录的用户初始化数据仓库
  Future initUserIsolate() {
    logD('初始化数据仓库Isolate: username: $_currentUsername');
    //设置全局数据仓库
    _repositories[_currentUsername!] = new Repository(_currentUsername!);
    gRepository = _repositories[_currentUsername];
    return _repositories[_currentUsername]!.create();
  }

  static bool _hasInitAliyunOss = false;

  initAliyunOss() async {
    logD('initAliyunOss start ...');

    _aliyunTokenExpire = 0; //毫秒
    _aliyunTokenAt = 0;

    _requestId = Uuid().v4(); //可以用于上传任务管理的key, java会返回
    // logD('_requestId: ${_requestId}');

    var result = await _alyOss.init(InitRequest(
      _requestId,
      ossConfig!.endPoint!,
      ossConfig!.accessKeyId!,
      ossConfig!.accessKeySecret!,
      ossConfig!.securityToken!,
      ossConfig!.expiration!,
    ));
    // if (result['instanceId'] != null) {
    //   logD('aliyunoss init ok, instanceId: ${result!['instanceId']}');
    // }

    _subscription = _alyOss.onUpload.listen((data) {
      logD('.......阿里云oss上传文件监听器.........');
      logD('文件上传完成!!!!');
      if (data.success!) {
        logD('requestId: ${data.requestId}, objFile: ${data.key}');
        if (_onDone != null) {
          _onDone!(data.key);
        }
      } else {
        logE('文件上传失败');
        if (_onFail != null) {
          _onFail!('文件上传失败');
        }
      }
      logD('.......阿里云oss上传文件监听器结束.........');
    });

    _onProgressSubscription = _alyOss.onProgress.listen((data) {
      // logD('.......上传进度监听器.........');
      // logD('success: ${data.success}');
      // logD('requestId: ${data.requestId}');
      // logD('key: ${data.key}');
      // logD('currentSize: ${data.currentSize}');
      // logD('totalSize: ${data.totalSize}');
      int percent = (100 * data.currentSize! / data.totalSize!).round();
      // logD('percent: ${percent}%');
      // if (percent == 100) {
      // logD('.......上传进度监监听器结束.........');
      // }
      if (_onProgress != null) {
        _onProgress!(percent);
      }
    });
  }

  static Function? _onDone;
  static Function? _onFail;
  static Function? _onProgress;

  ///阿里云 上传 moduleName = orders, msg , products ...
  // ignore: missing_return
  Future? uploadAly(
      String moduleName,
      String filefullpath,
      void onDone(String key),
      void onFail(String errmsg),
      void onProgress(int percent)) {
    _onDone = onDone;
    _onFail = onFail;
    _onProgress = onProgress;
    var file = File(filefullpath);
    String filemd5;
    filemd5 = md5.convert(file.readAsBytesSync()).toString(); // 同步
    logD('md5filename: $filemd5');

    //如果阿里云临时令牌过期，则重新获取
    if (DateTime.now().millisecondsSinceEpoch - _aliyunTokenAt >
        _aliyunTokenExpire) {
      var f = UserMod.getOssToken(false);
      f.then((value) {
        logD('阿里云临时令牌过期，重新获取 : ${ossConfig.toString()}');

        _aliyunTokenExpire = ossConfig!.expire!; //毫秒
        _aliyunTokenAt = DateTime.now().millisecondsSinceEpoch;

        if (!_hasInitAliyunOss) {
          _hasInitAliyunOss = true;
          //初始化原生阿里云
          initAliyunOss();
        }

        String objFile = moduleName +
            '/' +
            currentUsername! +
            '/' +
            ossConfig!.directory! +
            filemd5;

        logD('objFile: $objFile');

        return alyOss.upload(UploadRequest(_requestId, bucketName, objFile,
            filefullpath)); //file image.absolute.path
      });
    } else {
      String objFile = moduleName +
          '/' +
          currentUsername! +
          '/' +
          ossConfig!.directory! +
          filemd5;

      logD('objFile: $objFile');

      return alyOss.upload(UploadRequest(_requestId, bucketName, objFile,
          filefullpath)); //file image.absolute.path
    }
  }

  ///用于注销及登出
  clearCache() async {
    logD('clearCache start...');

    //ws 登出
    websocketfactory.logout();

    //database
    if (_repositories[_currentUsername] != null) {
      _repositories[_currentUsername!]!.closeIsolate(); //关闭数据库线程
    }
    _repositories.remove(_currentUsername);

    _isLogined = false;

    setUsername('');
    setMobile('');
    setIsLogined(false);
    setJwtToken('');
    setUserState(0);
    setUserType(0);
    setLocalPubkey('');
    setLocalPrikey('');

    if (prefs != null) {
      await prefs!.setBool(Constant.isLogined, false);
      await prefs!.setInt(Constant.lastLoginTimeAt, 0);
      await prefs!.setString(Constant.lastLoginName, '');
      await prefs!.setInt(Constant.lastLoginState, 0);
      await prefs!.setString(Constant.lastLoginToken, '');
      await prefs!.setString(Constant.notaryServicePublickey, '');
      await prefs!.setString(Constant.curVersion, '');
      await prefs!.setString(Constant.lastMobile, '');
      await prefs!.setString(Constant.localPrikey, '');
      await prefs!.setString(Constant.localPubkey, '');
    }

    //aliyunoss
    if (subscription != null) {
      subscription!.cancel();
    }
    if (onProgressSubscription != null) {
      onProgressSubscription!.cancel();
    }
  }

  /// 将阿里云oss的url及对应本地目录的
  addOrderImages(String fileUrl, String value) {
    assert(fileUrl != '');
    assert(value != '');
    String key = generateMD5(fileUrl);
    _box.put(key, value);
  }

  /// 从本地  hive获取 key对应的解密后的图片真实路径 ，如果没有，则从阿里云下载，并 写入hive
  Future<String?> getOrderImages(String fileUrl,
      {String? storeUserName}) async {
    logI('fileUrl : $fileUrl, storeUserName: $storeUserName');

    String key = generateMD5(fileUrl);

    String? value = _box.get(key);
    if (value == null) {
      //TODO 本地缓存图片不存在，需要下载
      //将加密后的文件下载到本地
      var appDocDir = await getApplicationDocumentsDirectory();

      var _file = fileUrl.split("/").last;

      String targetFileName = appDocDir.path + "/" + _file;

      logI('targetFileName : $targetFileName');

      await Dio().download(fileUrl, targetFileName,
          onReceiveProgress: (count, total) {
        // print((count / total * 100).toStringAsFixed(0) + "%");
      });

      String secret;

      if (storeUserName != null) {
        String publicKeyHex = await UserMod.getRsaPublickey(storeUserName);
        logI('publicKeyHex : $publicKeyHex');
        secret = OrderMod.calculateAgreement(
            publicKeyHex, Constant.systemPrivateKey);
      } else {
        secret = _storeSecret;
      }

      logI('secret : $secret');

      FileCryptor fileCryptor = FileCryptor(
        key: secret, //64个字符
        iv: 16,
        dir: appDocDir.path + '/order_images',
        // useCompress: true,
      );

      File decryptedFile = await fileCryptor.decrypt(
          inputFile: targetFileName, outputFile: targetFileName);

      logI('解密后文件完整路径 : ${decryptedFile.absolute.path}');
      value = decryptedFile.absolute.path;
      _box.put(key, value);
    }
    return value;
  }
}

//定义一个top-level变量，页面引入该文件后可以直接使用appManager.xxx调用方法
var appManager = new AppManager();
