import 'dart:io';
import 'dart:typed_data';

import '../lib/oss_dart.dart';

void main() async {
  OssClient client = OssClient(
      bucketName: 'lianmi-ipfs',
      endpoint: 'oss-cn-hangzhou.aliyuncs.com',
      tokenGetter: getStsAccount);

  List<int> fileData = []; //上传文件的二进制

  // String fileKey = 'ABC.text'; //上传文件名
  String fileKey = 'testossfile.jpeg'; //上传文件名
  var response;
  //上传文件
  // response = await client.putObject(fileData, fileKey);
  //获取文件
  response = await client.getObject(fileKey);
  /*
  //分片上传
  //First get uploadId
  String uploadId = await client.initiateMultipartUpload(fileKey);
  //Second upload part
  num partNum = 1; //上传分块的序号
  String etag = await client.uploadPart(fileData, fileKey, uploadId, partNum);
  //Third complate multiUpload
  List etags = [etag]; //所有区块上传完成后返回的etag，按顺序排列
  response = await client.completeMultipartUpload(etags, fileKey, uploadId);
  //response 是阿里云返回的xml格式的数据，需要单独解析
  */
  print(response.body);
  File file = File(fileKey);
  var raf = file.openSync(mode: FileMode.write);
  // response.data is List<int> type
  var _content = new Uint8List.fromList(response.body.codeUnits);

  raf.writeFromSync(_content);
}

//获取阿里云临时账号，具体实现参考阿里云文档
Future<Map> getStsAccount() async {
/*
{
    "code": 200,
    "msg": "ok",
    "data": {
        "AccessKeyId": "STS.NUeVEgxAPZz1Ce6VxAUvaV8Fv",
        "AccessKeySecret": "5cge7JLfPwY9ez9UcMxRHZwZazCawEui95ZFSkjKGSmA",
        "Expiration": "2021-08-04T19:15:06Z",
        "SecurityToken": "CAISqQJ1q6Ft5B2yfSjIr5bQHf/TlZ5x7bjaQUOHsngUWflNuf3tlDz2IHhFfXNqBuwasfU+nGpX7vYblq94T55IQ1Cc1FTEEk0Qo22beIPkl5Gf+t5t0e+3ewW6Dxr8w7WlAYHQR8/cffGAck3NkjQJr5LxaTSlWS7KU/COkoU1LK4vPG+CYCFBGc1dKyZ7tcYeLgGxD/u2NQPwiWeiUCgXswFn22Rk8vb9kI/O7hvXilj7j+4NqZ+TU5GvdJtrJ4wtEYX3juh3f6zE0WtR8xZRs+VU9PUeom+b4o/NXgYNvUjYbLHun4cxfFMjVM8TALVZqfXwr/p8t9HImp7/oxQ3ZrkECn6FG9z8n5qVQLn2boZgb9H/On3L19GOLpfurBklfX8LlbXIzWmr1RUagAGT+kDzi2u9wPKAoX4VtM++g7xAYeyly3y5dRDZALqfil5vwI60Zz6bFXMcMbOdzYAqzjXrqB/97G+oMxP3dMPcVMnvFdE2w5ENPJnNQk7RjB4bgbLRTD77DDgK08TXXwMIsvOXx0YnsXjtsSIi6uI8kP+vTrs/m/PtDKvBoGCYvQ=="
    }
}
 */
  return {
    'AccessKeyId': 'STS.NUeVEgxAPZz1Ce6VxAUvaV8Fv',
    'AccessKeySecret': "5cge7JLfPwY9ez9UcMxRHZwZazCawEui95ZFSkjKGSmA",
    'SecurityToken':
        "CAISqQJ1q6Ft5B2yfSjIr5bQHf/TlZ5x7bjaQUOHsngUWflNuf3tlDz2IHhFfXNqBuwasfU+nGpX7vYblq94T55IQ1Cc1FTEEk0Qo22beIPkl5Gf+t5t0e+3ewW6Dxr8w7WlAYHQR8/cffGAck3NkjQJr5LxaTSlWS7KU/COkoU1LK4vPG+CYCFBGc1dKyZ7tcYeLgGxD/u2NQPwiWeiUCgXswFn22Rk8vb9kI/O7hvXilj7j+4NqZ+TU5GvdJtrJ4wtEYX3juh3f6zE0WtR8xZRs+VU9PUeom+b4o/NXgYNvUjYbLHun4cxfFMjVM8TALVZqfXwr/p8t9HImp7/oxQ3ZrkECn6FG9z8n5qVQLn2boZgb9H/On3L19GOLpfurBklfX8LlbXIzWmr1RUagAGT+kDzi2u9wPKAoX4VtM++g7xAYeyly3y5dRDZALqfil5vwI60Zz6bFXMcMbOdzYAqzjXrqB/97G+oMxP3dMPcVMnvFdE2w5ENPJnNQk7RjB4bgbLRTD77DDgK08TXXwMIsvOXx0YnsXjtsSIi6uI8kP+vTrs/m/PtDKvBoGCYvQ==",
    "Expiration": "2021-08-04T19:15:06Z",
  };
}
