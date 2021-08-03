class SSQCalculateUtils {
  ///复式注数计算器
  static int calculateMultiple(int redBallsCount, int blueBallsCount) {
    if ((redBallsCount < 6) || (redBallsCount > 20)) {
      return 0;
    }
    if ((blueBallsCount < 1) || (blueBallsCount > 16)) {
      return 0;
    }
    if (redBallsCount == 6) {
      return blueBallsCount;
    }
    return _combin(redBallsCount, 6) * _combin(blueBallsCount, 1);
  }

  ///胆拖注数计算器
  static int calculateDantuo(int danmaCount, int tuomaCount, int blueBallsCount) {
    if ((danmaCount < 1) || (danmaCount > 5)) {
      return 0;
    }
    if (tuomaCount > 20) {
      return 0;
    }
    if ((blueBallsCount < 1) || (blueBallsCount > 16)) {
      return 0;
    }
    return _combin(tuomaCount, 6 - danmaCount) * _combin(blueBallsCount, 1);
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