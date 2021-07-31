import 'package:flutter/material.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/home/provider/home_provider.dart';
import 'package:lianmiapp/pages/me/page/user_center_page.dart';
import 'package:lianmiapp/pages/order/page/order_page.dart';
import 'package:lianmiapp/pages/discovery/page/discovery_page.dart';
import 'package:lianmiapp/provider/main_tabbar_index_provider.dart';
import 'package:lianmiapp/widgets/custom_tabbar.dart';
import 'package:provider/provider.dart';

class HomePageUser extends StatefulWidget {
  @override
  _HomePageUserState createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  late List<Widget> _pageList;
  final List<String> _appBarTitles = [
    '发现',
    '订单',
    '我的',
  ];
  final List<Map> _appBarImages = [
    {
      'icon': 'assets/images/home/user_tab1.png',
      'aIcon': 'assets/images/home/user_tab1_s.png'
    },
    {
      'icon': 'assets/images/home/user_tab3.png',
      'aIcon': 'assets/images/home/user_tab3_s.png'
    },
    {
      'icon': 'assets/images/home/user_tab4.png',
      'aIcon': 'assets/images/home/user_tab4_s.png'
    }
  ];
  final PageController _pageController = PageController();

  HomeProvider provider = HomeProvider();
  
  List<Widget> tabbars = [];

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void initData() {
    App.context = context;
    _pageList = [
      DiscoveryPage(), //发现(普通用户专用)
      OrderPage(), // 购物车(普通用户专用)
      UserCenterPage(), //我的(普通用户专用)
    ];
  }

  @override
  Widget build(BuildContext context) {
    _setupTabbars();
    return Scaffold(
      body: Consumer<MainTabbarIndexProvider>(
        builder: (context, main, child){
          return IndexedStack(
            index: main.index,
            children: _pageList,
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: Adapt.px(5),
        child: Row(
          children: tabbars,
        ),
      ),
    );
  }

  void _setupTabbars() {
    double itemWidth = (375 / _appBarTitles.length).px;
    tabbars.clear();
    for (var i = 0; i < _appBarTitles.length; i++) {
      tabbars.add(
        CustomTabbbar(
          itemWidth,
          56.px,
          _appBarTitles[i],
          i,
          AssetImage(_appBarImages[i]['icon']),
          AssetImage(_appBarImages[i]['aIcon']),
          Colors.black,
          Colours.app_main,
          onTap: () {
            Provider.of<MainTabbarIndexProvider>(App.context!, listen: false).index = i;
          },
        )
      );
    }
    return;
  }
}
