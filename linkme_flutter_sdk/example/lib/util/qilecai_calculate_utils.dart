//七乐彩注数计算器
// http://zx.500.com/calculator/qlc.php

class QilecaiCalculateUtils {
  ///复式注数计算器
  static int calculateMultiple(int count) {
    if ((count < 7) || (count > 30)) {
      return 0;
    }

    return _combin(count, 7);
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
