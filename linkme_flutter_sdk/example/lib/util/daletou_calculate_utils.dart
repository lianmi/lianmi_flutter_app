//大乐透注数计算器
// http://zx.500.com/calculator/dlt.php

class DLTCalculateUtils {
  /// 大乐透复式注数计算器
  ///  frontSectionCount p- 前区号码 1-35里选择至少5个,
  /// backSectionCount 并从后区号码中(1-12)任选2个号码的组合进行投注
  static int calculateMultiple(int frontSectionCount, int backSectionCount) {
    if ((frontSectionCount < 5) || (frontSectionCount > 20)) {
      return 0;
    }
    if ((frontSectionCount < 2) || (frontSectionCount > 12)) {
      return 0;
    }
    if (frontSectionCount == 5 && backSectionCount == 2) {
      return 1;
    }
    return _combin(frontSectionCount, 5) * _combin(backSectionCount, 2);
  }

  /// 大乐透胆拖注数计算器 https://www.17500.cn/widget/dlt/dt.html
  /// danmaFrontCount - 前区胆码总数
  /// tuomaFrontCount - 前区拖码总数
  /// backSectionCount -  后区号码总数
  static int calculateDantuo(
      int danmaFrontCount, int tuomaFrontCount, int backSectionCount) {
    if ((danmaFrontCount < 1) || (danmaFrontCount > 4)) {
      return 0;
    }

    if (tuomaFrontCount > 15) {
      return 0;
    }
    if ((backSectionCount < 2) || (backSectionCount > 12)) {
      return 0;
    }
    return _combin(tuomaFrontCount, 5 - danmaFrontCount) *
        _combin(backSectionCount, 2);
  }
}

int _factorial(int number) {
  var sum = 1;
  for (var i = 1; i <= number; i++) {
    sum *= i;
  }
  return sum;
}

int _combin(int n, m) {
  int a = _factorial(n);
  int b = _factorial(m);
  int n_m = 1;
  if (n - m == 0) {
    n_m = 1;
  } else {
    num _t = n - m;
    n_m = _factorial(_t.toInt());
  }

  int total = (a / (b * n_m)).round();

  return total;
}
