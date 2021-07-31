import 'package:flutter/material.dart';
import 'package:linkme_flutter_sdk/manager/LogManager.dart';

class MyAppBar {
  String title;
  bool leadding = true;
  double height;
  MyAppBar(this.title, this.height, this.leadding);

  void _search() {
    Drawer(
      child: Text("press search icon .."),
    );
    logD("is press search icon...");
  }

  void _addIcon() {
    Text("hhh添加hhh");
    logD("is press add icon...");
  }

  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      toolbarHeight: height,
      automaticallyImplyLeading: leadding,
      title: Container(
        child: Container(
          // height: 120,
          child: Column(
            children: [
              Container(
                height: 20,
              ),
              Row(children: <Widget>[
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
                // IconButton(
                //     icon: Icon(Icons.search),
                //     iconSize: 30,
                //     alignment: Alignment(10, 0),
                //     onPressed: _search),
                // IconButton(
                //     icon: Icon(Icons.add_circle_outline),
                //     iconSize: 30,
                //     alignment: Alignment(10, 0),
                //     onPressed: _addIcon),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
