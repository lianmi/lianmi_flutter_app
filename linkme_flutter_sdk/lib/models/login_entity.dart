// import 'package:linkme_flutter_sdk/generated/json/base/json_convert_content.dart';
// import 'package:linkme_flutter_sdk/generated/json/base/json_filed.dart';

// class LoginEntity with JsonConvert<LoginEntity> {
//   @JSONField(name: "username")
//   String? username;

//   @JSONField(name: "mobile")
//   String? mobile;

//   @JSONField(name: "user_type")
//   int? userType;

//   @JSONField(name: "state")
//   int? state;

//   @JSONField(name: "audit_result")
//   String? auditResult;

//   @JSONField(name: "jwt_token")
//   String? jwtToken;

//   String toString() {
//     return (StringBuffer('LoginEntity(')
//           ..write('username: $username, ')
//           ..write('mobile: $mobile, ')
//           ..write('userType: $userType, ')
//           ..write('state: $state, ')
//           ..write('auditResult: $auditResult, ')
//           ..write('jwtToken: $jwtToken ')
//           ..write(')'))
//         .toString();
//   }
// }

class LoginEntity {
  String? username;
  String? mobile;
  int? userType;
  int? state;
  String? auditResult;
  String? jwtToken;

  LoginEntity(
      {this.username,
      this.mobile,
      this.userType,
      this.state,
      this.auditResult,
      this.jwtToken});

  LoginEntity.fromMap(Map<String, dynamic> json) {
    username = json['username'];
    mobile = json['mobile'];
    userType = json['user_type'];
    state = json['state'];
    auditResult = json['audit_result'];
    jwtToken = json['jwt_token'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['mobile'] = this.mobile;
    data['user_type'] = this.userType;
    data['state'] = this.state;
    data['audit_result'] = this.auditResult;
    data['jwt_token'] = this.jwtToken;
    return data;
  }

  String toString() {
    return (StringBuffer('LoginEntity(')
          ..write('username: $username, ')
          ..write('mobile: $mobile, ')
          ..write('userType: $userType, ')
          ..write('state: $state, ')
          ..write('auditResult: $auditResult, ')
          ..write('jwtToken: $jwtToken ')
          ..write(')'))
        .toString();
  }
}
