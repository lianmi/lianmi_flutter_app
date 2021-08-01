/// @nodoc 数据dao操作， 由于isolate需要用枚举类型进行传递，因此所有数据操作都必须对应一个枚举
enum DbDaoEnum {
  /// @nodoc 关闭连接 0
  Close,

  /// @nodoc 初始化连接 1
  InitDb,

  /// @nodoc add增加一条记录，测试之用 2
  AddTest,

  /// @nodoc delete删除一条记录，测试之用 3
  DeleteTest,

  /// @nodoc update更新一条记录，测试之用 4
  UpdateTest,

  /// @nodoc query查询一条记录，测试之用 5
  QueryTest,

  /// @nodoc add增加一条 stores 表记录
  AddStore,

  /// @nodoc update stores 表记录
  UpdateStore,

  /// @nodoc  删除一条 stores  记录
  DeleteStore,

  /// 查询 stores 记录
  QueryStores,

  /// @nodoc  清空 stores 所有记录
  ClearStores,

  /// @nodoc 增加一条 lottery 记录
  AddLottery,

  /// @nodoc 删除一条lottery 记录
  DeleteLottery,

  /// @nodoc 查询彩票记录
  QueryLotterys,
}
