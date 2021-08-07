import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/services.dart';
import 'package:lianmiapp/citypicker/picker.dart';
import 'package:lianmiapp/linkme/linkme_manager.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/models/my_location_model.dart';
import 'package:lianmiapp/provider/location_provider.dart';
import 'package:lianmiapp/util/location_utils.dart';
import 'package:lianmiapp/widgets/my_refresh_widget.dart';
import 'package:lianmiapp/notification/notification_center.dart';
import 'package:lianmiapp/widgets/widget/button/common_button.dart';
import '../widgets/discovery_top_widget.dart';
import '../widgets/discovery_list_item.dart';
import '../discovery_const.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage>
    with
        AutomaticKeepAliveClientMixin<DiscoveryPage>,
        SingleTickerProviderStateMixin
    implements LinkMeManagerAppSystemListerner {
  @override
  bool get wantKeepAlive => true;

  // TabController _tabController;

  MyRefreshController _refreshController = MyRefreshController();

  ScrollController _scrollController = ScrollController();

  List<StoreInfo> _storeList = [];

  int _page = 1;

  int _totalPage = 1;

  String? _showAddress;

  double _lastLongitude = 0;

  double _lastLatitude = 0;

  String? _selectedProvince;
  String? _selectedCity;
  String? _selectedArea;

  int _selectType = 0;

  String? _keys;

  // List cityDatas = [];

  PickerItem showTypeAttr = PickerItem(name: '省+市+县+乡', value: ShowType.pcav);
  Result resultAttr = new Result();
  Result result = new Result();
  double barrierOpacityAttr = 0.5;
  bool barrierDismissibleAttr = false;
  double customerItemExtent = 40;
  bool customerButtons = false;
  bool isSort = false;
  bool customerItemBuilder = false;
  PickerItem? themeAttr;

  @override
  void initState() {
    super.initState();
    MyLocationModel myLocation =
        Provider.of<LocationProvider>(context, listen: false)
            .loadMyLastLocation();
    _showAddress = myLocation.area;
  }

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance!.addPostFrameCallback((tim) {
      NotificationCenter.instance.addObserver(NotificationDefine.locationUpdate,
          ({object}) {
        _handleLocationUpdate();
      });
      _page = 1;
      _refreshController.finishLoad(noMore: true);
      _refreshController.callRefresh();
      Future.delayed(Duration(seconds: 5), () {
        if (_storeList.isEmpty) {
          _refreshController.finishRefresh();
          _refreshController.finishLoad();
          _refreshController.callRefresh();
        }
      });
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    NotificationCenter.instance
        .removeNotification(NotificationDefine.locationUpdate);
  }

  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Scaffold(
          body: Container(
            child: Column(
              children: [
                DiscoveryTopWidget(
                  showAddress: _showAddress,
                  onTapAddress: () {
                    _showAddressSelect();
                  },
                  onTapCategory: () {
                    _showTypeSelect();
                  },
                  onSearch: (String text) {
                    _keys = text;
                    _page = 1;
                    _refreshController.callRefresh();
                  },
                ),
                Expanded(
                    child: Container(
                  child: MyRefreshWidget(
                    headerBackgroundColor: Colours.bg_color,
                    scrollController: _scrollController,
                    refreshController: _refreshController,
                    itemCount: _storeList.length,
                    itemBuilder: (context, index) {
                      return DiscoveryListItem(_storeList[index]);
                    },
                    refreshCallback: () {
                      _onRefresh();
                    },
                    loadMoreCallback: () {
                      _loadMore();
                    },
                  ),
                ))
              ],
            ),
          ),
        ));
  }

  void _showAddressSelect() async {
    resultAttr.provinceId = AppManager.provinceId; //初始省
    resultAttr.cityId = AppManager.cityId; //初始城市

    Result? tempResult = await CityPickers.showCityPicker(
        context: context,
        theme: themeAttr?.value,
        locationCode: resultAttr != null
            ? resultAttr.areaId ??
                resultAttr.cityId ??
                resultAttr.provinceId ??
                '110000'
            : '110000',
        showType: showTypeAttr.value,
        isSort: isSort,
        barrierOpacity: barrierOpacityAttr,
        barrierDismissible: barrierDismissibleAttr,
        citiesData: null,
        provincesData: null,
        itemExtent: customerItemExtent,
        cancelWidget: null,
        confirmWidget: null,
        itemBuilder: null);
    if (tempResult == null) {
      return;
    }

    logI("${tempResult.toString()}");
    _selectedProvince = tempResult.provinceName;
    _selectedCity = tempResult.cityName;
    _selectedArea = tempResult.areaName;
    _showAddress = tempResult.areaName;

    AppManager.setProvinceId(tempResult.provinceId!);
    AppManager.setCityId(tempResult.cityId!);

    setState(() {});
    _refreshController.callRefresh();
  }

  void _showTypeSelect() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
              child: Column(
            mainAxisSize: MainAxisSize.min, // 设置最小的弹出
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Container(
              //   width: double.infinity,
              //   height: 50.px,
              //   alignment: Alignment.center,
              //   color: Colors.white,
              //   child: CommonText(
              //     '选择类型',
              //     fontSize: 18.px,
              //     color: Colors.black,
              //   ),
              // ),
              CommonButton(
                width: double.infinity,
                height: 40.px,
                color: Colors.white,
                text: '全部',
                textColor: Colors.black,
                fontSize: 16.px,
                onTap: () {
                  Navigator.of(context).pop();
                  _selectType = 0;
                  _page = 1;
                  _refreshController.callRefresh();
                },
              ),
              // CommonButton(
              //   width: double.infinity,
              //   height: 40.px,
              //   color: Colors.white,
              //   text: '我的关注',
              //   textColor: Colors.black,
              //   fontSize: 16.px,
              //   onTap: () {
              //     Navigator.of(context).pop();
              //     AppNavigator.push(context, StoreFocusPage());
              //   },
              // ),
              CommonButton(
                width: double.infinity,
                height: 40.px,
                color: Colors.white,
                text: '中国福利网点',
                textColor: Colors.black,
                fontSize: 16.px,
                onTap: () {
                  Navigator.of(context).pop();
                  _selectType = 1;
                  _page = 1;
                  _refreshController.callRefresh();
                },
              ),
              CommonButton(
                width: double.infinity,
                height: 40.px,
                color: Colors.white,
                text: '中国体育网点',
                textColor: Colors.black,
                fontSize: 16.px,
                onTap: () {
                  Navigator.of(context).pop();
                  _selectType = 2;
                  _page = 1;
                  _refreshController.callRefresh();
                },
              ),
              CommonButton(
                width: double.infinity,
                height: 40.px,
                color: Colors.white,
                text: '公证企业',
                textColor: Colors.black,
                fontSize: 16.px,
                onTap: () {
                  Navigator.of(context).pop();
                  _selectType = 3;
                  _page = 1;
                  _refreshController.callRefresh();
                },
              ),
              CommonButton(
                width: double.infinity,
                height: 40.px,
                color: Colors.white,
                text: '律师事务所',
                textColor: Colors.black,
                fontSize: 16.px,
                onTap: () {
                  Navigator.of(context).pop();
                  _selectType = 4;
                  _page = 1;
                  _refreshController.callRefresh();
                },
              ),
              CommonButton(
                width: double.infinity,
                height: 40.px,
                color: Colors.white,
                text: '保险公司',
                textColor: Colors.black,
                fontSize: 16.px,
                onTap: () {
                  Navigator.of(context).pop();
                  _selectType = 5;
                  _page = 1;
                  _refreshController.callRefresh();
                },
              ),
              CommonButton(
                width: double.infinity,
                height: 40.px,
                color: Colors.white,
                text: '政府部门',
                textColor: Colors.black,
                fontSize: 16.px,
                onTap: () {
                  Navigator.of(context).pop();
                  _selectType = 6;
                  _page = 1;
                  _refreshController.callRefresh();
                },
              ),
              CommonButton(
                width: double.infinity,
                height: 40.px,
                color: Colors.white,
                text: '设计公司',
                textColor: Colors.black,
                fontSize: 16.px,
                onTap: () {
                  Navigator.of(context).pop();
                  _selectType = 7;
                  _page = 1;
                  _refreshController.callRefresh();
                },
              ),
              CommonButton(
                width: double.infinity,
                height: 40.px,
                color: Colors.white,
                text: '知识产权',
                textColor: Colors.black,
                fontSize: 16.px,
                onTap: () {
                  Navigator.of(context).pop();
                  _selectType = 8;
                  _page = 1;
                  _refreshController.callRefresh();
                },
              ),
              CommonButton(
                width: double.infinity,
                height: 40.px,
                color: Colors.white,
                text: '艺术品古董鉴定',
                textColor: Colors.black,
                fontSize: 16.px,
                onTap: () {
                  Navigator.of(context).pop();
                  _selectType = 9;
                  _page = 1;
                  _refreshController.callRefresh();
                },
              ),
            ],
          ));
        });
  }

  Future _onRefresh() async {
    _page = 1;
    _requestList();
    // logD('刷新完成');
  }

  Future _loadMore() async {
    _page++;
    _requestList();
  }

  void _requestList({bool isLoading = false}) {
    if (isLoading) {
      HubView.showLoading();
    }
    MyLocationModel myLocation =
        Provider.of<LocationProvider>(context, listen: false)
            .loadMyLastLocation();
    var data = {
      'storeType': _selectType,
      'keys': '',
      'longitude': myLocation.longitude,
      'latitude': myLocation.latitude,
      'province': myLocation.province,
      'city': myLocation.city,
      'area': myLocation.area,
      'radius': 0.00,
      'page': _page,
      'limit': kDiscoverStoreLoadCount
    };
    if (isValidString(_selectedProvince) &&
        isValidString(_selectedCity) &&
        isValidString(_selectedArea)) {
      data['province'] = _selectedProvince!;
      data['city'] = _selectedCity!;
      data['area'] = _selectedArea!;
    }
    if (isValidString(_keys)) {
      data['keys'] = _keys!;
      data['address'] = _keys!;
    }
    _lastLatitude = myLocation.latitude!;
    _lastLongitude = myLocation.longitude!;
    HttpUtils.post(HttpApi.storeList, data: data).then((val) {
      HubView.dismiss();
      _refreshController.finishRefresh();
      if (_page == 1) {
        _storeList.clear();
      }
      _totalPage = val['totalPage'] == null ? 0 : val['totalPage'];
      // logD("totalPage ${_totalPage}");

      _refreshController.finishLoad(noMore: _totalPage <= _page);

      //lishijia
      var _list = val['stores'];
      if (_list != null && _list.length > 0) {
        _list.forEach((store) {
          _storeList.add(StoreInfo.fromMap(store));
        });
      }

      setState(() {});
    }).catchError((err) {
      HubView.dismiss();
      _page--;
      _refreshController.finishRefresh();
      _refreshController.finishLoad(noMore: false);
      logE(err);
    });
  }

  void _handleLocationUpdate() {
    MyLocationModel myLocation =
        Provider.of<LocationProvider>(context, listen: false)
            .loadMyLastLocation();
    double distance = LocationUtils.getdistanceInMeters(_lastLatitude,
        _lastLongitude, myLocation.latitude!, myLocation.longitude!);

    ///大于1公里才刷新信息
    if (distance > 1000 || _selectedArea == null) {
      _showAddress = myLocation.area;
      _selectedArea = myLocation.area;
      _onRefresh();
    }
  }

  @override
  void onLinkMeInitAfter() {
    _refreshController.callRefresh();
  }
}
