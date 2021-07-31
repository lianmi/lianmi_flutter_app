import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:quiver/strings.dart';
import 'package:typed_data/typed_data.dart';
import 'package:uuid/uuid.dart';
import 'websocket_model.dart';

import '../net/wsHandler.dart';

class UserModel with ChangeNotifier {
  bool isConnected(BuildContext context) {
    return Provider.of<WebsocketModel>(context, listen: false).state ==
        WebsocketConnectionState.connected;
  }

  bool isLogined(BuildContext context) {
    return Provider.of<WebsocketModel>(context, listen: false).isLogined;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
