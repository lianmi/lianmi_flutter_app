import 'dart:io';
import 'dart:isolate';
import 'package:linkme_flutter_sdk/manager/LogManager.dart';
import 'package:flutter/foundation.dart';
import 'package:linkme_flutter_sdk/isolate/isolate_db/my_database.dart';
import 'package:moor/ffi.dart';
import 'package:moor/isolate.dart';
import 'package:moor/moor.dart';
import 'package:linkme_flutter_sdk/db_enum.dart';

import '../isolate_db/my_database.dart';

///第二线程,时间处理
class IsolateFuEvents {
  ///用户id, 用于构建数据库
  static String userId = '';
  static String mobile = '';
  static String token = '';
  static String initCompleteruuid = '';

  ///用于动态线程通信
  static ReceivePort _rp = new ReceivePort();
  static SendPort? _portDy;

  ///动态线程数据库处理
  static MyDatabase? db;

  ///debug输出控制
  static const _logStatements = kDebugMode;

  ///从主线程回包的数据
  static _IsolateStartRequest? _request;

  //在父Isolate中调用
  static Isolate? isolate;

  static String? completerUuid;

  ///创建第二线程
  static createIsolate(ReceivePort rp, String _userID, String _uuid) async {
    userId = _userID;
    completerUuid = _uuid;
    // logV('createIsolate: _completerIndex=${_uuid}');

    ///获取数据库地址
    final path = await MyDatabase.getDatabasePath();

    ///创建子Isolate对象 注册线程
    isolate = await Isolate.spawn(
      startBackground,
      _IsolateStartRequest(rp.sendPort, path, completerUuid!),
    );
  }

  ///关闭Isolate/receivePorr
  static closeIsolate() {
    _rp.close();
    //关闭Isolate对象
    isolate!.kill(priority: Isolate.immediate);
    // isolate = null;
    // logV('关闭Isolate done');
  }

  ///动态线程事件
  static void startBackground(_IsolateStartRequest request) async {
    _request = request;

    ///绑定主线程信息接收器
    // logV('startBackground: completerIndex: ${request.completerUuid}');
    _request!.sendMoorIsolate.send([0, _rp.sendPort, request.completerUuid]);
    _portDy = _request!.sendMoorIsolate;
    _dynamicListen();
  }

  ///动态线程监听
  static void _dynamicListen() {
    _rp.listen((message) async {
      // logV('动态线程监听主线程发来的信息: $message');
      // logV('是否关闭数据库:${message[0] == DbDaoEnum.Close}');

      //根据传入的第一个参数判断是哪个dao操作
      switch (message[0]) {
        case DbDaoEnum.Close:
          // logV('动态线程关闭数据库');
          db?.close();
          db = null;
          // logV('动态数据库成功关闭');
          break;
        case DbDaoEnum.InitDb:
          if (message.length >= 5) {
            initCompleteruuid = message[1];
            userId = message[2];
            mobile = message[3];
            token = message[4];
            // logV(
            //     '接收来自主线程的DbDaoEnum.InitDb数据, initCompleteruuid: ${initCompleteruuid}, userId: ${userId}');

            if (db == null) {
              _dynamicDbInit();
            }
          } else {
            logE('Error: DbDaoEnum.InitDb 参数不足');
          }

          break;
        case DbDaoEnum.AddTest:

          ///增加操作
          if (db == null) {
            _portDy!.send([DbDaoEnum.AddTest, 0]);
            return;
          }
          Test _t = message[1];
          try {
            int _i = await db!.insertDemo(_t);
            _portDy!.send([DbDaoEnum.AddTest, _i]);
          } catch (e) {
            logE(e);
            _portDy!.send([DbDaoEnum.AddTest, 0]);
          }
          break;

        case DbDaoEnum.DeleteTest:

          ///删除操作
          if (db == null) {
            _portDy!.send([DbDaoEnum.DeleteTest, 0]);
            return;
          }
          int _id = message[1];
          int _i = await db!.deleteDemo(_id);
          _portDy!.send([DbDaoEnum.DeleteTest, _i]);
          break;

        case DbDaoEnum.UpdateTest:

          ///修改操作
          if (db == null) {
            _portDy!.send([DbDaoEnum.UpdateTest, 0]);
            return;
          }
          Test _t = message[1];
          int _i = await db!.updateDemo(_t);
          _portDy!.send([DbDaoEnum.UpdateTest, _i]);

          break;
        case DbDaoEnum.QueryTest:

          ///查询操作
          if (db == null) {
            _portDy!.send([DbDaoEnum.QueryTest, null]);
            return;
          }
          String _completeruuid = message[1];
          int _id = message[2] as int;
          List<Test> _t = await db!.selectDemo(_id);
          _portDy!.send([DbDaoEnum.QueryTest, _completeruuid, _t]); //主线程接收？？
          break;

        case DbDaoEnum.AddStore:

          ///增加操作
          if (db == null) {
            _portDy!.send([DbDaoEnum.AddStore, 0]);
            return;
          }
          Store _t = message[1];
          try {
            int _i = await db!.insertStore(_t);
            _portDy!.send([DbDaoEnum.AddStore, _i]);
          } catch (e) {
            logE(e);
            _portDy!.send([DbDaoEnum.AddStore, 0]);
          }
          break;

        case DbDaoEnum.UpdateStore:

          ///修改操作
          if (db == null) {
            _portDy!.send([DbDaoEnum.UpdateStore, 0]);
            return;
          }
          Store _t = message[1];
          int _i = await db!.updateStore(_t);
          _portDy!.send([DbDaoEnum.UpdateStore, _i]);

          break;

        case DbDaoEnum.DeleteStore:

          ///修改操作
          if (db == null) {
            _portDy!.send([DbDaoEnum.DeleteStore, 0]);
            return;
          }
          String _userName = message[1];
          int _i = await db!.deleteStore(_userName);
          _portDy!.send([DbDaoEnum.DeleteStore, _i]);

          break;

        case DbDaoEnum.ClearStores:

          ///清空操作
          if (db == null) {
            _portDy!.send([DbDaoEnum.ClearStores, 0]);
            return;
          }
          int _i = await db!.clearStores();
          _portDy!.send([DbDaoEnum.ClearStores, _i]);
          break;

        case DbDaoEnum.QueryStores:

          ///查询操作
          if (db == null) {
            _portDy!.send([DbDaoEnum.QueryStores, null]);
            return;
          }
          String _completeruuid = message[1];
          String _businessUserName = message[2];
          int _storeType = message[3] == null ? 0 : message[3];
          int _limit = message[4] == null ? 9999 : message[4];
          int _offset = message[5] == null ? 0 : message[5];
          List<Store> _t = await db!.selectStores(
              businessUsername: _businessUserName,
              storeType: _storeType,
              limit: _limit,
              offset: _offset);
          _portDy!.send([DbDaoEnum.QueryStores, _completeruuid, _t]); //主线程接收？？
          break;

        case DbDaoEnum.AddLottery:
          if (db == null) {
            _portDy!.send([DbDaoEnum.AddLottery, null]);
            return;
          }
          String _completeruuid = message[1];
          Lottery _c = message[2];

          var result;
          try {
            result = await db!.insertLottery(_c);
          } catch (e) {
            result = '添加彩票失败:$e';
          }
          _portDy!.send([DbDaoEnum.AddLottery, _completeruuid, result]); //主线程接收
          break;

        case DbDaoEnum.DeleteLottery:
          if (db == null) {
            _portDy!.send([DbDaoEnum.DeleteLottery, null]);
            return;
          }
          String _completeruuid = message[1];
          int id = message[2] == null ? 0 : message[2];

          var result;
          try {
            result = await db!.deleteLottery(id);
          } catch (e) {
            result = '删除彩票失败:$e';
          }
          _portDy!
              .send([DbDaoEnum.DeleteLottery, _completeruuid, result]); //主线程接收
          break;

        case DbDaoEnum.QueryLotterys:
          if (db == null) {
            _portDy!.send([DbDaoEnum.QueryLotterys, null]);
            return;
          }
          String _completeruuid = message[1];
          int productId = message[2];
          int type = message[3] == null ? 0 : message[3];
          int act = message[4] == null ? 0 : message[4];

          var result;
          try {
            result = await db!.queryLotterys(productId, type, act);
          } catch (e) {
            result = '查询彩票数据错误:$e';
          }
          _portDy!
              .send([DbDaoEnum.QueryLotterys, _completeruuid, result]); //主线程接收
          break;

        default:
          break;
      }
    });
  }

  ///初始化动态线程里数据库，并向主线程回包
  static void _dynamicDbInit() async {
    // logV('动态线程初始化开始, 数据库文件: ${_request.targetPath}');

    ///构建数据库
    final executor = VmDatabase(
      File(_request!.targetPath),
      logStatements: _logStatements,
    );

    ///数据库绑定并开启数据库
    MoorIsolate moorIsolate = MoorIsolate.inCurrent(
      () => DatabaseConnection.fromExecutor(executor),
    );

    ///获取[DatabaseConnection],将其转换为MyDatabase;
    DatabaseConnection connection = await moorIsolate.connect();

    ///创建db
    db = MyDatabase.connect(connection);
    if (db != null) {
      // logV('动态线程数据库获取成功 ...');

      ///将moorIsolate及initCompleteruuid动态线程通讯返回主线程
      _portDy!.send([1, moorIsolate, initCompleteruuid]);
    } else {
      logE('动态线程数据库获取失败, db==null');
    }
  }
}

class _IsolateStartRequest {
  _IsolateStartRequest(
      this.sendMoorIsolate, this.targetPath, this.completerUuid);

  final SendPort sendMoorIsolate;
  final String targetPath;
  final String completerUuid;
}
