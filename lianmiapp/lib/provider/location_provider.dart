import 'dart:async';

import 'package:amap_flutter_location/amap_flutter_location.dart';
import 'package:amap_flutter_location/amap_location_option.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:lianmiapp/notification/notification_center.dart';
import 'package:lianmiapp/util/alert_utils.dart';
import 'package:lianmiapp/util/app.dart';
import 'package:permission_handler/permission_handler.dart';
import '../models/my_location_model.dart';
import '../util/shared_preferences_utils.dart';

const String _myLocationLocalKey = 'myLocationLocalKey';

const kAmapAndroidKey = '86119726e07a492d381ac66d918be14b';
const kAmapIOSKey = '';

class LocationProvider extends ChangeNotifier {
  MyLocationModel? _myLocation;

  MyLocationModel? get myLocation => _myLocation;

  late StreamSubscription<Map<String, Object>> _locationListener;

  AMapFlutterLocation _locationPlugin = new AMapFlutterLocation();

  bool _hasSetOption = false;

  ///初始化定位信息
  void setup() {
    getLocation();
  }

  void _setLocationOption() {
    AMapFlutterLocation.setApiKey(kAmapAndroidKey, kAmapIOSKey);
    ///注册定位结果监听
    _locationListener = _locationPlugin.onLocationChanged().listen((Map<String, Object> result) {
      if (result.containsKey('errorCode') == false) {
        updateLocation(
          longitude: result['longitude'] as double,
          latitude: result['latitude'] as double,
          province: result['province'] as String,
          city: result['city'] as String,
          area: result['district'] as String
        );
      }
      if (result['errorCode'] == 12 && App.lifecycleState == AppLifecycleState.resumed) {
        showNoLocationPermissionAlert();
      } 
    });

    AMapLocationOption locationOption = new AMapLocationOption();

    ///是否单次定位
    locationOption.onceLocation = false;

    ///是否需要返回逆地理信息
    locationOption.needAddress = true;

    ///逆地理信息的语言类型
    locationOption.geoLanguage = GeoLanguage.DEFAULT;

    locationOption.desiredLocationAccuracyAuthorizationMode = AMapLocationAccuracyAuthorizationMode.ReduceAccuracy;

    locationOption.fullAccuracyPurposeKey = "AMapLocationScene";

    ///设置Android端连续定位的定位间隔
    // locationOption.locationInterval = 60000;
    locationOption.locationInterval = 5000;

    ///设置Android端的定位模式<br>
    ///可选值：<br>
    ///<li>[AMapLocationMode.Battery_Saving]</li>
    ///<li>[AMapLocationMode.Device_Sensors]</li>
    ///<li>[AMapLocationMode.Hight_Accuracy]</li>
    locationOption.locationMode = AMapLocationMode.Hight_Accuracy;

    ///设置iOS端的定位最小更新距离<br>
    locationOption.distanceFilter = -1;

    ///设置iOS端期望的定位精度
    /// 可选值：<br>
    /// <li>[DesiredAccuracy.Best] 最高精度</li>
    /// <li>[DesiredAccuracy.BestForNavigation] 适用于导航场景的高精度 </li>
    /// <li>[DesiredAccuracy.NearestTenMeters] 10米 </li>
    /// <li>[DesiredAccuracy.Kilometer] 1000米</li>
    /// <li>[DesiredAccuracy.ThreeKilometers] 3000米</li>
    locationOption.desiredAccuracy = DesiredAccuracy.Best;

    ///设置iOS端是否允许系统暂停定位
    locationOption.pausesLocationUpdatesAutomatically = false;

    ///将定位参数设置给定位插件
    _locationPlugin.setLocationOption(locationOption);

    _hasSetOption = true;
  }

  ///开始获取定位
  void startLocation() async {
    _locationPlugin.startLocation();
  }

  ///获取定位
  void getLocation() {
    checkHasLocaitonPermission().then((value) {
      if (value == true) {
        if (_hasSetOption == false) {
          _setLocationOption();
        }
        startLocation();
      } else {
        showNoLocationPermissionAlert();
      }
    }).catchError((err) async {
      showNoLocationPermissionAlert();
    });
  }

  ///判断是否有定位权限
  Future<bool> checkHasLocaitonPermission() async {
    bool hasLocationPermission = await requestLocationPermission();
    if (hasLocationPermission) {
      return true;
    } else {
      return Future.error('没有定位权限');
    }
  }

  /// 申请定位权限
  /// 授予定位权限返回true， 否则返回false
  Future<bool> requestLocationPermission() async {
    //获取当前的权限
    var status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      //已经授权
      return true;
    } else {
      //未授权则发起一次申请
      status = await Permission.location.request();
      if (status == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  ///显示没有定位提示
  void showNoLocationPermissionAlert() {
    AlertUtils.showChooseAlert(
      App.context!,
      title: '提示',
      content: '需要获得定位权限?',
      confirmTitle: '去设置',
      onTapConfirm: () async {
        await Geolocator.openLocationSettings();
      }
    );
      
  }

  void updateLocation({double? longitude, double? latitude, String? province, String? city, String? area}) {
    if (_myLocation == null) _myLocation = MyLocationModel();
    if (longitude != null && longitude > 0) {
      _myLocation!.longitude = longitude;
    }
    if (latitude != null && latitude > 0) {
      _myLocation!.latitude = latitude;
    }
    if (province != null && province.length > 0) {
      _myLocation!.province = province;
    }
    if (city != null && city.length > 0) {
      _myLocation!.city = city;
    }
    if (area != null && area.length > 0) {
      _myLocation!.area = area;
    }
    saveMyLocation();
    notifyListeners();
    NotificationCenter.instance.postNotification(NotificationDefine.locationUpdate);
  }

  ///获取我上次的定位信息
  MyLocationModel loadMyLastLocation() {
    String? jsonText = SharePreferencesUtils.getValue(_myLocationLocalKey);
    if (jsonText == null || jsonText.length == 0) {
      MyLocationModel locationModel = MyLocationModel(
        longitude: 0,
        latitude: 0,
        province: '广东省',
        city: '广州市',
        area: '黄埔区',
      );
      _myLocation = locationModel;
      return locationModel;
    }
    Map<String, dynamic> jsonData = json.decode(jsonText);
    MyLocationModel locationModel = MyLocationModel.fromJson(jsonData);
    _myLocation = locationModel;
    return locationModel;
  }

  void saveMyLocation() {
    if (_myLocation == null) return;
    Map<String, dynamic> jsonData = _myLocation!.toJson();
    SharePreferencesUtils.putValue(_myLocationLocalKey, json.encode(jsonData));
  }
}

