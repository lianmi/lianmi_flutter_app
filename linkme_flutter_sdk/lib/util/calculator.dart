/**
 * 
 * 各种浮点类型转换
 */

class Calculator {
  //取小数点后两位
  static String getTargetTextFromDouble(double x) {
    double targetX = double.parse(x.toStringAsFixed(2));

    int i = targetX.truncate();

    if (targetX == i) {
      return i.toString();
    }

    return targetX.toString();
  }

  
}
