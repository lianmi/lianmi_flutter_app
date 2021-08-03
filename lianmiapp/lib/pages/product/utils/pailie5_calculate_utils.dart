//体彩排列五注数计算器
// http://zx.500.com/calculator/plw.php

class PaiLie5CalculateUtils {
  ///复式注数计算器
  ///geWeiCount 个位的号码总数
  ///shiWeiCount 十位的号码总数
  ///baiWeiCount 百位的号码总数
  ///qianWeiCount  千位的号码总数
  ///wanWeiCount 万位的号码总数
  static int calculateMultiple(int geWeiCount, int shiWeiCount, int baiWeiCount,
      int qianWeiCount, int wanWeiCount) {
    if ((geWeiCount < 1) || (geWeiCount > 10)) {
      return 0;
    }
    if ((shiWeiCount < 1) || (shiWeiCount > 10)) {
      return 0;
    }
    if ((baiWeiCount < 1) || (baiWeiCount > 10)) {
      return 0;
    }
    if ((qianWeiCount < 1) || (qianWeiCount > 10)) {
      return 0;
    }
    if ((wanWeiCount < 1) || (wanWeiCount > 10)) {
      return 0;
    }

    return _combin(geWeiCount, 1) *
        _combin(shiWeiCount, 1) *
        _combin(baiWeiCount, 1) *
        _combin(qianWeiCount, 1) *
        _combin(wanWeiCount, 1);
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
