import 'dart:isolate';
import 'package:linkme_flutter_sdk/manager/LogManager.dart';
import 'package:linkme_flutter_sdk/isolate/isolate_db/my_database.dart';
import 'package:linkme_flutter_sdk/db_enum.dart';
import 'package:moor/isolate.dart';
import 'package:moor/moor.dart';
import 'package:linkme_flutter_sdk/isolate/repositories/Repository.dart';
import 'package:linkme_flutter_sdk/manager/AppManager.dart';

///主线程事件处理
class IsolateEvents {
  ///用于向动态线程发送消息
  static SendPort? portDynamic;

  static IsolateEvents? _current;
  // static get current => _current != null ? _current : IsolateEvents._();

  ///主线程数据库处理
  static MyDatabase? db;

  ///主线程订阅第二个线程的事件
  IsolateEvents(List<dynamic> _message) {
    // logV('IsolateEvents, 主线程从动态线程接收信息:' + _message.toString());
    if (_message[0] == 0) {
      ///绑定动态线程监听
      portDynamic = _message[1] as SendPort;
      String completerUuid = _message[2] as String;
      // portDynamic.send('从主线程发送测试');
      AppManager.gRepository!.onDynamicCreate(completerUuid, true);
    } else if (_message[0] == 1) {
      // logV('IsolateEvents, 绑定MoorIsolate');

      ///绑定MoorIsolate
      MoorIsolate _db = _message[1] as MoorIsolate;
      //获取到返回的index
      int index = 0;
      if (_message.length >= 3 && _message[2] != null) {
        String completerUuid = _message[2] as String;
        // logV('获取到返回的Completer数组index: ${index}');
        AppManager.gRepository!.onInitCb(completerUuid, (_db != null));
      }
    }

    //注意！！ 凡是查询，都需要在这里补充进去，以便回调到 repository
    switch (_message[0]) {
      case DbDaoEnum.QueryTest:
        {
          // logV(' _message[1]= ${_message[1]}');
          // logV(' _message[2]= ${_message[2]}');

          //取出回调
          if (AppManager.gRepository != null) {
            AppManager.gRepository!.onQueryTestSuccess(
                _message[1] as int, _message[2] as List<Test>);
          }
        }
        break;

      case DbDaoEnum.QueryStores:
        {
          // logV(' _message[1]= ${_message[1]}');
          // logV(' _message[2]= ${_message[2]}');

          //取出回调
          if (AppManager.gRepository != null) {
            AppManager.gRepository!.onQueryStoresSuccess(
                _message[1] as String, _message[2] as List<Store>);
          }
        }
        break;

      case DbDaoEnum.QueryStores:
        {
          // logV(' _message[1]= ${_message[1]}');
          // logV(' _message[2]= ${_message[2]}');

          //取出回调
          if (AppManager.gRepository != null) {
            AppManager.gRepository!.onQueryStoresSuccess(
                _message[1] as String, _message[2] as List<Store>);
          }
        }
        break;

      case DbDaoEnum.AddLottery:
        {
          // logV(' _message[1]= ${_message[1]}');
          // logV(' _message[2]= ${_message[2]}');

          //取出回调
          if (AppManager.gRepository != null) {
            AppManager.gRepository!.onInsertLotterySuccess(
                _message[1] as String, _message[2] ?? 0);
          }
        }
        break;

      case DbDaoEnum.DeleteLottery:
        {
          // logV(' _message[1]= ${_message[1]}');
          // logV(' _message[2]= ${_message[2]}');

          //取出回调
          if (AppManager.gRepository != null) {
            AppManager.gRepository!.onDeleteLotterySuccess(
                _message[1] as String, _message[2] ?? 0);
          }
        }
        break;

      case DbDaoEnum.QueryLotterys:
        {
          // logV(' _message[1]= ${_message[1]}');
          // logV(' _message[2]= ${_message[2]}');

          //取出回调
          if (AppManager.gRepository != null) {
            AppManager.gRepository!
                .onQueryLotterysSuccess(_message[1] as String, _message[2]);
          }
        }
        break;

      default:
      // logV(' _message[0]= ${_message[0]}');
      // logV(' _message[1]= ${_message[1]}');
    }
  }

  ///查询表的回调
  static void doSendPortDynamic(List<dynamic> _message) {
    portDynamic!.send(_message);
  }

  ///关闭数据库
  static closeDb() {
    // logV('主线程发送关闭动态线程数据库命令');
    portDynamic?.send([DbDaoEnum.Close.index]);
    // logV('主线程关闭数据库');
    db?.close();
    db = null;
  }

  static kill() {
    IsolateEvents.kill();
  }
}
