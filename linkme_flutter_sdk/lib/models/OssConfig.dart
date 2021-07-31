class OssConfig {
  String? endPoint;

  String? bucketName;

  String? accessKeyId;

  String? accessKeySecret;

  String ?securityToken;

  String? expiration;

  int ?expire;

  String ?directory;

  String toString() {
    return (StringBuffer('OssConfig(')
          ..write('endPoint: $endPoint, ')
          ..write('bucketName: $bucketName, ')
          ..write('accessKeyId: $accessKeyId, ')
          ..write('accessKeySecret: $accessKeySecret, ')
          ..write('securityToken: $securityToken, ')
          ..write('expiration: $expiration')
          ..write('expire: $expire, ')
          ..write('directory: $directory, ')
          ..write(')'))
        .toString();
  }
}
