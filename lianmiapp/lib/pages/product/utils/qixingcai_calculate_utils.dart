//七星彩注数计算器
// http://zx.500.com/calculator/qxc.php

class QixingcaiCalculateUtils {
  ///复式注数计算器
  static int calculateMultiple(
      int oneLineCount,
      int twoLineCount,
      int threeLineCount,
      int fourLineCount,
      int fiveLineCount,
      int sixLineCount,
      int sevenLineCount) {
    if ((oneLineCount < 1) || (oneLineCount > 10)) {
      return 0;
    }
    if ((twoLineCount < 1) || (twoLineCount > 10)) {
      return 0;
    }
    if ((threeLineCount < 1) || (threeLineCount > 10)) {
      return 0;
    }
    if ((fourLineCount < 1) || (fourLineCount > 10)) {
      return 0;
    }
    if ((fiveLineCount < 1) || (fiveLineCount > 10)) {
      return 0;
    }
    if ((sixLineCount < 1) || (sixLineCount > 10)) {
      return 0;
    }
    if ((sevenLineCount < 1) || (sevenLineCount > 15)) {
      return 0;
    }

    return _combin(oneLineCount, 1) *
        _combin(twoLineCount, 1) *
        _combin(threeLineCount, 1) *
        _combin(fourLineCount, 1) *
        _combin(fiveLineCount, 1) *
        _combin(sixLineCount, 1) *
        _combin(sevenLineCount, 1);
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
  int n_m;
  if (n - m == 0) {
    n_m = 1;
  } else {
    n_m = _factorial((n - m).toInt());
  }

  int total = (a / (b * n_m)).round();

  return total;
}
