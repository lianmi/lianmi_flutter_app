import 'dart:isolate';
import 'package:linkme_flutter_sdk/manager/LogManager.dart';
import 'package:linkme_flutter_sdk/isolate/isolate_events/isolate_f_events.dart';
import 'isolate_events.dart';

class CreateTestIsolate {
  static ReceivePort? rp;

  /// 创建一个新的 isolate  用于主线程通讯
  static createIsolate(String userID, String _uuid) async {
    ///主线程监听
    rp = new ReceivePort();
    rp!.listen((message) {
      // logD('线程的监听回包:' + message.toString());

      ///在监听回包后进行线程绑定
      IsolateEvents(message);
    });

    ///创建第二线程
    await IsolateFuEvents.createIsolate(rp!, userID, _uuid);
  }

  static closeIsolate() {
    if (rp != null) {
      logD('closeIsolate....');
      rp!.close();
    }

    IsolateFuEvents.closeIsolate();
  }
}
