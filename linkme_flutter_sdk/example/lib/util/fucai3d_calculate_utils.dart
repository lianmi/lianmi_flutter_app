//福彩3d注数计算器
// http://zx.500.com/calculator/sd.php

class Fucai3dCalculateUtils {
  ///复式注数计算器
  ///geWeiCount 个位的号码总数
  ///shiWeiCount 十位的号码总数
  ///baiWeiCount 百位的号码总数
  static int calculateMultiple(
      int geWeiCount, int shiWeiCount, int baiWeiCount) {
    if ((geWeiCount < 1) || (geWeiCount > 10)) {
      return 0;
    }
    if ((shiWeiCount < 1) || (shiWeiCount > 10)) {
      return 0;
    }
    if ((baiWeiCount < 1) || (baiWeiCount > 10)) {
      return 0;
    }

    return _combin(geWeiCount, 1) *
        _combin(shiWeiCount, 1) *
        _combin(baiWeiCount, 1);
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
    num _t = n - m;
    n_m = _factorial(_t.toInt());
  }

  int total = (a / (b * n_m)).round();

  return total;
}
