import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:lianmiapp/util/app.dart';
import 'package:path/path.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class FileManager {
  factory FileManager() =>_getInstance();
  static FileManager get instance => _getInstance();
  static FileManager? _instance;
  FileManager._internal() {
  }
  static FileManager _getInstance() {
    if (_instance == null) {
      _instance = new FileManager._internal();
    }
    return _instance!;
  }

  ///是否存在某个文件
  bool isExist(String path) {
    if(path==null || path.length == 0) {
      return false;
    }
    File file = File(path);
    return file.existsSync();
  }

  ///拷贝文件到APP的目录
  ///[fileSourcePath]源文件路径
  // ignore: missing_return
  Future<String> copyFileToAppFolder(String fileSourcePath) async{
    if(fileSourcePath == null) {
      return '';
    }
    File file = File(fileSourcePath);
    String targetFileName = _randomFileName(basename(file.path));
    String targetPath = App.userIMPath! + targetFileName;
    File newFile = await file.copy(targetPath);
    return newFile.absolute.path;
  }

  ///拷贝U8文件到APP的目录
  ///[u8File]源文件u8
  // ignore: missing_return
  Future<String> copyU8ListFileToAppFolder(Uint8List u8File) async{
    if(u8File == null) return '';
    String targetFileName = _randomFileName('xxx.png');
    String targetPath = App.userIMPath! + targetFileName;
    File file = File(targetPath);
    try {
      await file.writeAsBytes(u8File);
    } catch (e) {
      return Future.error('保存出错');
    }
    return file.absolute.path;
  }

  ///生成文件路径
  String createFilePath(String ext) {
    if(ext == null) {
      return '';
    }
    String targetFileName = _randomFileName(basename('xxx.$ext'));
    String targetPath = App.userIMPath! + targetFileName;
    return targetPath;
  }

  ///存储视频封面图
  Future<String> saveVideoCover(String videoPath) async {
    final uint8list = await VideoThumbnail.thumbnailData(
      video: videoPath,
      imageFormat: ImageFormat.JPEG,
    );
    String localCoverPath = await copyU8ListFileToAppFolder(uint8list!);
    return localCoverPath;
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