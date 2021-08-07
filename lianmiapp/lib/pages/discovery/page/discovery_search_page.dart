import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/discovery/widgets/discovery_search_item.dart';
import 'package:lianmiapp/widgets/my_refresh_widget.dart';
import '../discovery_const.dart';
import '../widgets/discovery_top_search.dart';
import '../widgets/discovery_types_widget.dart';
import '../models/store_type_model.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

class DiscoverySearchPage extends StatefulWidget {
  @override
  _DiscoverySearchPageState createState() => _DiscoverySearchPageState();
}

class _DiscoverySearchPageState extends State<DiscoverySearchPage> {
  List<StoreTypeModel> _types = [];

  String _currentSearchKey = '';

  int _currentType = 0;

  MyRefreshController _refreshController = MyRefreshController();

  ScrollController _scrollController = ScrollController();

  List<StoreInfo> _storeList = [];

  int _page = 1;

  int _totalPage = 1;

  @override
  void initState() {
    super.initState();
    // _requestTypes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            DiscoveryTopSearch(
              text: _currentSearchKey,
              onTapSearch: (String text) {
                _currentSearchKey = text;
                if (text.length > 0) {
                  _page = 1;
                  _requestList(isLoading: true);
                }
              },
            ),
            DiscoveryTypesWidget(
              types: _types,
              onTap: (int type) {
                _currentType = type;
                _page = 1;
                _requestList(isLoading: true);
              },
            ),
            Expanded(
                child: Container(
              child: MyRefreshWidget(
                scrollController: _scrollController,
                refreshController: _refreshController,
                itemCount: _storeList.length,
                itemBuilder: (context, index) {
                  return DiscoverySearchItem(_storeList[index]);
                },
                // refreshCallback: () {
                //   _page = 1;
                //   _requestList();
                // },
                loadMoreCallback: () {
                  _page++;
                  _requestList();
                },
              ),
            ))
          ],
        ),
      ),
    );
  }

  void _requestTypes() {
    HubView.showLoading();
    HttpUtils.get(HttpApi.storeTypes).then((val) {
      HubView.dismiss();
      _types.clear();
      _types.addAll(StoreTypeModel.modelListFromJson(val));
      setState(() {});
      _requestList(isLoading: true);
    }).catchError((err) {
      HubView.dismiss();
    });
  }

  void _requestList({bool isLoading = false}) {
    logD('_currentSearchKey: $_currentSearchKey, _currentType: $_currentType');
    if (isLoading) {
      HubView.showLoading();
    }
    HttpUtils.post(HttpApi.storeList, data: {
      'storeType': _currentType,
      'keys': _currentSearchKey,
      'longitude': 0.00,
      'latitude': 0.00,
      'radius': 0.00,
      'page': _page,
      'limit': kDiscoverStoreLoadCount
    }).then((val) {
      HubView.dismiss();
      _refreshController.finishRefresh();
      if (_page == 1) {
        _storeList.clear();
      }
      _totalPage = val['totalPage'] == null ? 0 : val['totalPage'];
      // logD("totalPage ${_totalPage}");

      _refreshController.finishLoad(noMore: _totalPage <= _page);
      if (val['stores'] != null) {
        _storeList.addAll(val); //lishijia
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
}
