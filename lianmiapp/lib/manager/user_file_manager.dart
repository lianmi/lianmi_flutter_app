import 'dart:io';
import 'dart:math';
import 'package:lianmiapp/util/app.dart';
import 'package:path/path.dart'; 

class UserFileManager {
  ///是否存在某个文件
  static bool isExist(String path) {
    if(path==null || path.length == 0) {
      return false;
    }
    File file = File(path);
    return file.existsSync();
  }

  ///拷贝文件到APP的目录
  ///[fileSourcePath]源文件路径
  // ignore: missing_return
  static Future<String> copyFileToAppFolder(String fileSourcePath) async{
    if(fileSourcePath == null) {
      return '';
    }
    File file = File(fileSourcePath);
    String targetFileName = _randomFileName(basename(file.path));
    String targetPath = App.userImagesPath! + '/' + targetFileName;
    File newFile = await file.copy(targetPath);
    return newFile.absolute.path;
  }
}

//生成随机数
String _randomBit(int len) {
  String scopeF = '123456789'; //首位
  String scopeC = '0123456789'; //中间
  String result = '';
  for (int i = 0; i < len; i++) {
    if (i == 0) {
      result = scopeF[Random().nextInt(scopeF.length)];
    } else {
      result = result + scopeC[Random().nextInt(scopeC.length)];
    }
  }  return result;
}

//根据文件名生成随机文件名
String _randomFileName(String originName) {
  var ext = originName.split(".").last; 
  String targetFileName = '${DateTime.now().millisecondsSinceEpoch}_${_randomBit(6)}.$ext';
  return targetFileName;
}