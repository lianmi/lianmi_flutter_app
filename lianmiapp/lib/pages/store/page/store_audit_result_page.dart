import 'package:flutter/material.dart';
import 'package:lianmiapp/res/resources.dart';
import 'package:lianmiapp/routers/fluro_navigator.dart';
import 'package:lianmiapp/routers/routers.dart';
import 'package:lianmiapp/widgets/my_app_bar.dart';
import 'package:lianmiapp/widgets/load_image.dart';
import 'package:lianmiapp/widgets/my_button.dart';

/// design/2商户审核/index.html#artboard2
class StoreAuditResultPage extends StatefulWidget {
  @override
  _StoreAuditResultPageState createState() => _StoreAuditResultPageState();
}

class _StoreAuditResultPageState extends State<StoreAuditResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: '审核结果',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Gaps.vGap50,
            const LoadAssetImage(
              'store/icon_success',
              width: 80.0,
              height: 80.0,
            ),
            Gaps.vGap12,
            const Text(
              '恭喜，商户资料审核成功',
              style: TextStyles.textSize16,
            ),
            Gaps.vGap8,
            Text(
              '2020-02-21 15:20:10',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Gaps.vGap8,
            Text(
              '预计完成时间：02月28日',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Gaps.vGap24,
            MyButton(
              onPressed: () {
                NavigatorUtils.push(context, Routes.home, clearStack: true);
              },
              text: '进入',
            )
          ],
        ),
      ),
    );
  }
}
