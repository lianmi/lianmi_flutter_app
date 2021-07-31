import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'dart:io';

import 'package:crypto/crypto.dart';


// md5 加密
String generateMD5(String data) {
  // var content = new Utf8Encoder().convert(data);
  // var digest = md5.convert(content);
  // // 这里其实就是 digest.toString()
  // return hex.encode(digest.bytes);
  // logD('=======' + md5.convert(utf8.encode(data)).toString());
  return md5.convert(utf8.encode(data)).toString();
}

Future<String?> hash256(String filename) async {
  Hash hasher;
  hasher = sha256;

  var input = File(filename);

  if (!input.existsSync()) {
    // logE('File "$filename" does not exist.');
    // exitCode = 66; // An input file did not exist or was not readable.
    return null;
  }

  var value = await hasher.bind(input.openRead()).first;
  return value.toString();
}
