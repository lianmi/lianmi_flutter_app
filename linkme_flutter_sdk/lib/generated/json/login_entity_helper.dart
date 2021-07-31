import 'package:linkme_flutter_sdk/models/login_entity.dart';

loginEntityFromJson(LoginEntity data, Map<String, dynamic> json) {
  if (json['username'] != null) {
    data.username = json['username']?.toString();
  }
  if (json['mobile'] != null) {
    data.username = json['mobile']?.toString();
  }
  if (json['user_type'] != null) {
    data.userType = json['user_type']?.toInt();
  }
  if (json['state'] != null) {
    data.state = json['state']?.toInt();
  }
  if (json['audit_result'] != null) {
    data.auditResult = json['audit_result']?.toString();
  }
  if (json['jwt_token'] != null) {
    data.jwtToken = json['jwt_token']?.toString();
  }
  return data;
}

Map<String, dynamic> loginEntityToJson(LoginEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['username'] = entity.username;
  data['mobile'] = entity.mobile;
  data['user_type'] = entity.userType;
  data['state'] = entity.state;
  data['audit_result'] = entity.auditResult;
  data['jwt_token'] = entity.jwtToken;
  return data;
}
