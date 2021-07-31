import 'dart:async';
import 'package:linkme_flutter_sdk/manager/LogManager.dart';
import 'package:linkme_flutter_sdk/isolate/isolate_db/my_database.dart';
import 'package:linkme_flutter_sdk/isolate/isolate_events/create_test_isolate.dart';
import 'package:linkme_flutter_sdk/isolate/isolate_events/isolate_events.dart';
import 'package:linkme_flutter_sdk/db_enum.dart';
import 'package:linkme_flutter_sdk/manager/AppManager.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../linkme_flutter_sdk.dart';

//数据仓库
class Repository {
  //回调上下文
  Map<String, Completer>? completers; //uuid作为key

  String userID = '';

  Repository(String _userID) {
    userID = _userID;
  }

  // String _sqliteDb;
  Future<String> sqliteDb() async {
    // return await Db.getDatabasePath();
    final dir = await getApplicationDocumentsDirectory();
    String base = 'lianmidb_';
    String userIdMd5 = getMd5(AppManager.currentUsername!);

    String dbPath = join(dir.path, '$base$userIdMd5.sqlite');
    logD('数据库文件: $dbPath');
    return dbPath;
  }

  /// 创建Isolate
  Future create() async {
    completers = new Map();
    String innerCompleterUuid = Uuid().v4();
    Completer _completerCreate = new Completer.sync();

    completers![innerCompleterUuid] = _completerCreate;
    CreateTestIsolate.createIsolate(this.userID, innerCompleterUuid);
    return _completerCreate.future;
  }

  ///动态线程创建完成的回调
  onDynamicCreate(String _uuid, bool isCreated) {
    if (completers!.containsKey(_uuid)) {
      Completer _completerCreate = completers![_uuid]!;
      if (isCreated) {
        _completerCreate.complete(true);
      } else {
        _completerCreate.complete(false);
      }
    }
  }

  /// 关闭数据库连接
  void close() async {
    IsolateEvents.portDynamic!.send([DbDaoEnum.Close]);
  }

  /// 关闭Isolate连接
  void closeIsolate() async {
    completers = null;
    await CreateTestIsolate.closeIsolate();
  }

  /// 初始化数据库连接
  Future init() async {
    // logV("初始化数据库连接 init ...");
    Completer _completer = new Completer.sync();
    //保存上下文
    String innerCompleterUuid = Uuid().v4();
    completers![innerCompleterUuid] = _completer;
    IsolateEvents.doSendPortDynamic([
      DbDaoEnum.InitDb, //0
      innerCompleterUuid, //1
      AppManager.currentUsername, //2
      AppManager.currentMobile, //3
      AppManager.currentToken, //4
    ]);
    return _completer.future;
  }

  /// 初始化数据库连接的回调
  onInitCb(String _uuid, bool isConnected) {
    if (completers!.containsKey(_uuid)) {
      //从上下文获取到对应的 _completer
      Completer _completer = completers![_uuid]!;
      // logV('onInitCb, isConnected: $isConnected ...');
      _completer.complete(isConnected);
    }
  }

  Future<void> insertTest(int id, String keyName) async {
    // logV('Start inserting into table test ...');

    //Test是一个类， my_database.g.dart
    Test _t = new Test(id: id, keyname: keyName);
    IsolateEvents.portDynamic!.send([DbDaoEnum.AddTest, _t]);
  }

  Future<void> deleteTest(int id) async {
    // logV('Start delete table test, id: $id ...');

    IsolateEvents.portDynamic!.send([DbDaoEnum.DeleteTest, id]);
  }

  Future<void> updateTest(int id, String keyName) async {
    // logV('Start update table test, id: $id ...');

    Test _t = new Test(id: id, keyname: keyName);
    IsolateEvents.portDynamic!.send([DbDaoEnum.UpdateTest, _t]);
  }

  ///查询例子，返回test表的对应id的记录
  Future queryTest(int id) async {
    // logV('Start query table test, id: $id ...');
    Completer _completer = new Completer.sync();

    //保存上下文
    String innerCompleterUuid = Uuid().v4();
    completers![innerCompleterUuid] = _completer;
    IsolateEvents.doSendPortDynamic(
        [DbDaoEnum.QueryTest, innerCompleterUuid, id]);

    return _completer.future;
  }

  ///queryTest的回调
  onQueryTestSuccess(int index, List<Test> tests) {
    if (completers!.containsKey(index)) {
      //从上下文获取到对应的 _completer
      Completer _completer = completers![index]!;
      // logV('onQueryTestSuccess, tests: $tests ...');

      _completer.complete(tests);
    }
  }

  /// @nodoc add增加一条 stores 表记录
  Future<void> insertStore(Store _store) async {
    // logV('Start inserting into stores  ...');

    IsolateEvents.portDynamic!.send([DbDaoEnum.AddStore, _store]);
  }

  /// @nodoc update stores 表记录
  Future<void> updateStore(Store _store) async {
    // logV('Start update table stores ...');

    IsolateEvents.portDynamic!.send([DbDaoEnum.UpdateStore, _store]);
  }

  /// @nodoc  删除一条 stores 记录
  Future<void> deleteStore(String businessUsername) async {
    // logV('Start delete table stores, businessUsername: $businessUsername ...');

    IsolateEvents.portDynamic!.send([DbDaoEnum.DeleteStore, businessUsername]);
  }

  /// @nodoc  清空 stores 所有记录
  Future<void> clearStores() async {
    // logV('Start clear table stores...');

    IsolateEvents.portDynamic!.send([DbDaoEnum.ClearStores]);
  }

  /// @nodoc 根据 businessUsername(可选)及storeType query stores 记录
  Future queryStores(
      {String? businessUsername,
      int? storeType,
      int? limit,
      int? offset}) async {
    // logV(
    //     'Start query table stores, businessUsername: $businessUsername, $storeType  ...');
    Completer _completer = new Completer.sync();

    //保存上下文
    String innerCompleterUuid = Uuid().v4();
    completers![innerCompleterUuid] = _completer;
    IsolateEvents.doSendPortDynamic([
      DbDaoEnum.QueryStores,
      innerCompleterUuid,
      businessUsername,
      storeType,
      limit,
      offset
    ]);

    return _completer.future;
  }

  /// queryStores 回调,
  onQueryStoresSuccess(String _uuid, List<Store> _stores) {
    if (completers!.containsKey(_uuid)) {
      //从上下文获取到对应的 _completer
      Completer _completer = completers![_uuid]!;
      // logV('onQueryStoresSuccess: $_stores');

      _completer.complete(_stores);
    }
  }

  /// @nodoc add增加一条 lottery 表记录
  Future insertLottery(
      [int? productId,
      int? type,
      String? content,
      int? createdAt,
      int? act]) async {
    // logV('Start inserting into lottery ...');
    Completer _completer = new Completer.sync();

    //保存上下文
    String innerCompleterUuid = Uuid().v4();
    completers![innerCompleterUuid] = _completer;
    Lottery _l = Lottery(
        productId: productId!,
        type: type!,
        content: content!,
        createdAt: createdAt!,
        act: act!);

    IsolateEvents.portDynamic!
        .send([DbDaoEnum.AddLottery, innerCompleterUuid, _l]);
    return _completer.future;
  }

  /// add lottery回调
  onInsertLotterySuccess(String _uuid, var result) {
    Completer _completer = completers![_uuid]!;
    // logV('onInsertLotterySuccess: $result');

    if (result is int) {
      _completer.complete(result);
    } else {
      _completer.completeError(result);
    }
  }

  ///删除lottery
  Future deleteLottery(int id) {
    // logV('Start deleting lottery ...');
    Completer _completer = new Completer.sync();

    //保存上下文
    String innerCompleterUuid = Uuid().v4();
    completers![innerCompleterUuid] = _completer;

    IsolateEvents.portDynamic!.send([
      DbDaoEnum.DeleteLottery,
      innerCompleterUuid,
      id,
    ]);
    return _completer.future;
  }

  /// deleteLottery回调
  onDeleteLotterySuccess(String _uuid, var result) {
    Completer _completer = completers![_uuid]!;
    // logV('onDeleteLotterySuccess: $result');

    if (result is int) {
      _completer.complete(result);
    } else {
      _completer.completeError(result);
    }
  }

  /// 查询Lottery
  Future queryLotterys([int? productId, int? type, int? act]) async {
    // logV('Start query table lottery ...');
    Completer _completer = new Completer.sync();

    //保存上下文
    String innerCompleterUuid = Uuid().v4();
    completers![innerCompleterUuid] = _completer;
    IsolateEvents.doSendPortDynamic(
        [DbDaoEnum.QueryLotterys, innerCompleterUuid, productId, type, act]);

    return _completer.future;
  }

  /// queryLotterys回调
  onQueryLotterysSuccess(String _uuid, var result) {
    Completer _completer = completers![_uuid]!;
    // logV('onQueryLotterysSuccess: $result');

    if (result is List<Lottery>) {
      _completer.complete(result);
    } else {
      _completer.completeError(result);
    }
  }

}
