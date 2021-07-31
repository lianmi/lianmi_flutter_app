class LastUserInfo {
  String? username;
  String? mobile;
  String? jwtToken;
  int? userType;
  int? state;
  int? updateTime;

  String toString() {
    return (StringBuffer('LastUserInfo(')
          ..write('username: $username, ')
          ..write('mobile: $mobile, ')
          ..write('jwtToken: $jwtToken, ')
          ..write('userType: $userType, ')
          ..write('state: $state, ')
          ..write('updateTime: $updateTime')
          ..write(')'))
        .toString();
  }
}
