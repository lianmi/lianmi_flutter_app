///
//  Generated code. Do not modify.
//  source: api/proto/auth/KickedEvent.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class ClientType extends $pb.ProtobufEnum {
  static const ClientType Ct_UnKnow = ClientType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Ct_UnKnow');
  static const ClientType Ct_Android = ClientType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Ct_Android');
  static const ClientType Ct_iOS = ClientType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Ct_iOS');
  static const ClientType Ct_RESTApi = ClientType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Ct_RESTApi');
  static const ClientType Ct_Windows = ClientType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Ct_Windows');
  static const ClientType Ct_MacOS = ClientType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Ct_MacOS');
  static const ClientType Ct_Web = ClientType._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Ct_Web');

  static const $core.List<ClientType> values = <ClientType> [
    Ct_UnKnow,
    Ct_Android,
    Ct_iOS,
    Ct_RESTApi,
    Ct_Windows,
    Ct_MacOS,
    Ct_Web,
  ];

  static final $core.Map<$core.int, ClientType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ClientType? valueOf($core.int value) => _byValue[value];

  const ClientType._($core.int v, $core.String n) : super(v, n);
}

class ClientMode extends $pb.ProtobufEnum {
  static const ClientMode Clm_UnKnow = ClientMode._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Clm_UnKnow');
  static const ClientMode Clm_Im = ClientMode._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Clm_Im');
  static const ClientMode Clm_ImEncrypted = ClientMode._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Clm_ImEncrypted');

  static const $core.List<ClientMode> values = <ClientMode> [
    Clm_UnKnow,
    Clm_Im,
    Clm_ImEncrypted,
  ];

  static final $core.Map<$core.int, ClientMode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ClientMode? valueOf($core.int value) => _byValue[value];

  const ClientMode._($core.int v, $core.String n) : super(v, n);
}

class KickReason extends $pb.ProtobufEnum {
  static const KickReason KickReasonUndefined = KickReason._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'KickReasonUndefined');
  static const KickReason SamePlatformKick = KickReason._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SamePlatformKick');
  static const KickReason Blacked = KickReason._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Blacked');
  static const KickReason OtherPlatformKick = KickReason._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OtherPlatformKick');

  static const $core.List<KickReason> values = <KickReason> [
    KickReasonUndefined,
    SamePlatformKick,
    Blacked,
    OtherPlatformKick,
  ];

  static final $core.Map<$core.int, KickReason> _byValue = $pb.ProtobufEnum.initByValue(values);
  static KickReason? valueOf($core.int value) => _byValue[value];

  const KickReason._($core.int v, $core.String n) : super(v, n);
}

