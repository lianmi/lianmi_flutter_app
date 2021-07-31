class MathUtils {
  ///项目需要显示的数字
  static String getTargetTextFromDouble(double x){
    double targetX = double.parse(x.toStringAsFixed(2));


    int i = targetX.truncate() ;

    if(targetX == i){
      return i.toString();
    }

    return targetX.toString();
  }
}