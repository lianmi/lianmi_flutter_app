import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:moor/moor.dart';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:linkme_flutter_sdk/isolate/isolate_events/isolate_f_events.dart';
import 'package:moor/ffi.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
part 'my_database.g.dart';

///请使用命令行运行 flutter pub run build_runner build 创建[my_datebase.moor]里构建的数据库
@UseMoor(
  include: {'my_database.moor'},
)
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());
  MyDatabase.connect(DatabaseConnection connection) : super.connect(connection);

  static const Expression<bool> ISTRUE = const CustomExpression('(TRUE)');

  ///测试数据库是否可用, 测试使用
  Future<int> testDemo() async {
    Test _test = Test.fromJson({
      'id': Random().nextInt(99999999),
      'keyname': 'testName',
      'keyids': 'testId',
      'circle': 'testCircle'
    });
    return await this.into(test).insert(_test);
  }

  ///test表增加操作
  Future<int> insertDemo(Test _t) async {
    // logV('进行添加操作');

    int _i = await this.into(test).insert(_t);
    // logV('添加操作结果:$_i');
    return _i;
  }

  ///test表删除操作
  Future<int> deleteDemo(int id) async {
    int _i = await (this.delete(test)..where((tbl) => tbl.id.equals(id))).go();
    // logV('删除操作结果:$_i');
    return _i;
  }

  ///test表修改操作
  Future<int> updateDemo(Test _test) async {
    // logV('进行修改操作');
    int _i = await (this.update(test)..where((tbl) => tbl.id.equals(_test.id)))
        .write(_test);
    // logV('修改操作结果:$_i');
    return _i;
  }

  ///test表查询操作
  Future<List<Test>> selectDemo(int id) async {
    // logV('进行查询操作');
    List<Test> _t =
        await (this.select(test)..where((tbl) => tbl.id.equals(id))).get();
    // logV('查询操作完成:${_t.length}');
    return _t;
  }

  ///stores 表增加操作
  Future<int> insertStore(Store _t) async {
    // logV('进行stores表增加操作');

    int _i = await this.into(stores).insert(_t);
    // logV('增加stores表操作结果:$_i');
    return _i;
  }

  ///stores表删除操作
  Future<int> deleteStore(String businessUsername) async {
    int _i = await (this.delete(stores)
          ..where((tbl) => businessUsername == null
              ? ISTRUE
              : tbl.businessUsername.equals(businessUsername)))
        .go();
    // logV('删除kstores操作结果:$_i');
    return _i;
  }

  ///stores表清空操作
  Future<int> clearStores() async {
    int _i = await (this.delete(stores).go());
    // logV('stores表清空操作结果:$_i');
    return _i;
  }

  /// 只更新stores表部分字段
  Future<int> updateStore(Store _store) async {
    // logV('进行stores表部分字段修改操作');
    int _i = await (this.update(stores)
          ..where(
              (tbl) => tbl.businessUsername.equals(_store.businessUsername)))
        .write(_store);
    // logV('进行stores表部分字段修改操作结果:$_i');
    return _i;
  }

  /// 根据 storeType 从stores表查询操作， 空 返回所有记录
  Future<List<Store>> selectStores(
      {String? businessUsername,
      int? storeType,
      int? limit,
      int? offset}) async {
    // logV(
    //     '根据  businessUsername: $businessUsername storeType: $storeType, 进行stores查询操作');

    List<Store> _t = await (this.select(stores)
          ..where((tbl) => businessUsername == null
              ? ISTRUE
              : tbl.businessUsername.equals(businessUsername))
          ..where((tbl) =>
              storeType == null ? ISTRUE : tbl.storeType.equals(storeType))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(limit ?? 999999, offset: offset ?? 0))
        .get();
    // logV('查询stores操作完成:${_t.length}');
    return _t;
  }

  ///添加彩票
  Future<int> insertLottery(Lottery _l) {
    // logV('进行添加彩票操作');
    return this.into(lottery).insert(_l);
  }

  ///删除彩票
  Future<int> deleteLottery(int id) {
    // logV('进行会话彩票操作');
    return (this.delete(lottery)..where((tbl) => tbl.id.equals(id))).go();
  }

  ///查询彩票
  Future<List<Lottery>> queryLotterys(int productId, int type, int act) {
    // logV('进行查询彩票操作');
    return (this.select(lottery)
          ..where((tbl) => tbl.productId.equals(productId))
          ..where((tbl) => tbl.type.equals(type))
          ..where((tbl) => tbl.act.equals(act)))
        .get();
  }

  ///处理报错信息
  static const _logStatements = kDebugMode;

  ///获取数据库链接
  static Future<String> getDatabasePath() async {
    final dir = await getApplicationDocumentsDirectory();
    // logV('getDatabasePath, userId= ${IsolateFuEvents.userId}');
    String base = 'lianmidb_';
    String userIdMd5 = getMd5(IsolateFuEvents.userId);

    /// 已用户id为基准，id需由主线程sendPort透传
    ///透传链接
    return join(dir.path, '$base$userIdMd5.sqlite');
  }

  ///打开数据库获取数据库
  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      return VmDatabase(
        File(await getDatabasePath()),
        // logStatements: _logStatements,
      );
    });
  }

  @override
  int get schemaVersion => 1;

  ///构建版本号,在数据库大改时需用到

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) {
        return m.createAll();
      },
      onUpgrade: (m, from, to) async {
        for (int v = from; v < to; v++) {
          switch (v) {
            case 1:
              await m.createTable(test);
              break;
          }
        }
      },
    );
  }
}

///转换bool to int
int _change(bool bol) {
  if (bol != null && bol) {
    return 1;
  } else {
    return 0;
  }
}

///获取MD5
String getMd5(String str) {
  var firstChunk = utf8.encode(str);
  return md5.convert(firstChunk).toString();
}
