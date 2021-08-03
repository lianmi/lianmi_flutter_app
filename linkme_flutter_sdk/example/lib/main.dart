import 'package:lianmisdk/router/routes.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

import 'ui/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: UserModel()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //初始化日志管理器, console表示输出到屏幕, 默认是输出到文件
    LogManager.instance()
        .init(SDKLogLevel.error, output: LogOutputEnum.console);

    return MaterialApp(
      title: 'Lianmi Sdk Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      routes: routes,
    );
  }
}
