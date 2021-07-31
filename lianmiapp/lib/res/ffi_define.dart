class FFIDefine {
  ///双色球单式
  static const kFFIBodyTypeLotterySSQDanshi = 5;
  ///双色球复式
  static const kFFIBodyTypeLotterySSQFushi = 6;
  ///双色球胆拖
  static const kFFIBodyTypeLotterySSQDantuo = 7;
  ///商品服务费
  static const kFFIBodyTypeLotteryServiceFee = 100;
  ///会员费
  static const kFFIBodyTypeLotteryMemberFee = 99;

  ///服务费的词语
  static const kServiceFeeText = '上链服务费';

  ///双色球的类型
  static const kSSQTypeList = [
    kFFIBodyTypeLotterySSQDanshi,
    kFFIBodyTypeLotterySSQFushi,
    kFFIBodyTypeLotterySSQDantuo,
  ];
}