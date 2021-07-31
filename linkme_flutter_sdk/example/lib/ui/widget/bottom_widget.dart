import 'package:lianmisdk/ui/page/wallet_page.dart';

import '../page/order_page.dart';

import '../page/auth_page.dart';
import '../page/user_page.dart';
import '../page/store_page.dart';
import '../page/db_page.dart';
import 'package:flutter/material.dart';
import 'package:linkme_flutter_sdk/manager/LogManager.dart';

class BottomWidget extends StatefulWidget {
  BottomWidget({Key? key}) : super(key: key);

  @override
  _BottomWidgetState createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
  int _currentIndex = 0;
  String _title = "LianMi";
  Widget _currentBody = AuthPage();

  // _jumpChatPage(Widget page) {
  //   Navigator.pop(context);
  //   Navigator.push(context, CupertinoPageRoute(builder: (context){
  //     return page;
  //   }));
  // }

  _onTap(int index) {
    logD(
        "to choice page.....index = ${index}, _currentIndex = ${_currentIndex}");
    switch (index) {
      case 0:
        _currentBody = AuthPage();
        _title = "鉴权";
        break;
      case 1:
        _currentBody = UserPage();
        _title = "用户";
        break;
      case 2:
        _currentBody = StorePage();
        _title = "商户";
        break;
      case 3:
        _currentBody = OrderPage();
        _title = "订单";
        break;
      case 4:
        _currentBody = WalletPage();
        _title = "中心化钱包";
        break;
      default:
        break;
    }
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentBody,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTap,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black,
        currentIndex: _currentIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              title: Text('auth'), icon: Icon(Icons.camera_front)),
          BottomNavigationBarItem(
              title: Text('user'), icon: Icon(Icons.search)),
          BottomNavigationBarItem(
              title: Text('store'), icon: Icon(Icons.message)),
          BottomNavigationBarItem(
              title: Text('order'), icon: Icon(Icons.border_outer)),
          BottomNavigationBarItem(
              title: Text('wallet'), icon: Icon(Icons.directions_boat_sharp)),
        ],
      ),
    );
  }
}
