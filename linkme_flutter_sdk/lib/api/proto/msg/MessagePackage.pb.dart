///
//  Generated code. Do not modify.
//  source: api/proto/msg/MessagePackage.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'MsgTypeEnum.pbenum.dart' as $0;

class MessagePackage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MessagePackage', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'cloud.lianmi.im.msg'), createEmptyInstance: create)
    ..e<$0.MessageScene>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scene', $pb.PbFieldType.OE, defaultOrMaker: $0.MessageScene.MsgScene_Undefined, valueOf: $0.MessageScene.valueOf, enumValues: $0.MessageScene.values)
    ..e<$0.MessageType>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: $0.MessageType.MsgType_Undefined, valueOf: $0.MessageType.valueOf, enumValues: $0.MessageType.values)
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'serverMsgId', protoName: 'serverMsgId')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'workflowID', protoName: 'workflowID')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uuid')
    ..a<$fixnum.Int64>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'seq', $pb.PbFieldType.OF6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..e<$0.MessageStatus>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: $0.MessageStatus.MOS_UDEFINE, valueOf: $0.MessageStatus.valueOf, enumValues: $0.MessageStatus.values)
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'from')
    ..aOS(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'to')
    ..a<$core.List<$core.int>>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'body', $pb.PbFieldType.OY)
    ..a<$fixnum.Int64>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'userUpdateTime', $pb.PbFieldType.OF6, protoName: 'userUpdateTime', defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(12, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'time', $pb.PbFieldType.OF6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  MessagePackage._() : super();
  factory MessagePackage({
    $0.MessageScene? scene,
    $0.MessageType? type,
    $core.String? serverMsgId,
    $core.String? workflowID,
    $core.String? uuid,
    $fixnum.Int64? seq,
    $0.MessageStatus? status,
    $core.String? from,
    $core.String? to,
    $core.List<$core.int>? body,
    $fixnum.Int64? userUpdateTime,
    $fixnum.Int64? time,
  }) {
    final _result = create();
    if (scene != null) {
      _result.scene = scene;
    }
    if (type != null) {
      _result.type = type;
    }
    if (serverMsgId != null) {
      _result.serverMsgId = serverMsgId;
    }
    if (workflowID != null) {
      _result.workflowID = workflowID;
    }
    if (uuid != null) {
      _result.uuid = uuid;
    }
    if (seq != null) {
      _result.seq = seq;
    }
    if (status != null) {
      _result.status = status;
    }
    if (from != null) {
      _result.from = from;
    }
    if (to != null) {
      _result.to = to;
    }
    if (body != null) {
      _result.body = body;
    }
    if (userUpdateTime != null) {
      _result.userUpdateTime = userUpdateTime;
    }
    if (time != null) {
      _result.time = time;
    }
    return _result;
  }
  factory MessagePackage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MessagePackage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MessagePackage clone() => MessagePackage()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MessagePackage copyWith(void Function(MessagePackage) updates) => super.copyWith((message) => updates(message as MessagePackage)) as MessagePackage; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MessagePackage create() => MessagePackage._();
  MessagePackage createEmptyInstance() => create();
  static $pb.PbList<MessagePackage> createRepeated() => $pb.PbList<MessagePackage>();
  @$core.pragma('dart2js:noInline')
  static MessagePackage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MessagePackage>(create);
  static MessagePackage? _defaultInstance;

  @$pb.TagNumber(1)
  $0.MessageScene get scene => $_getN(0);
  @$pb.TagNumber(1)
  set scene($0.MessageScene v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasScene() => $_has(0);
  @$pb.TagNumber(1)
  void clearScene() => clearField(1);

  @$pb.TagNumber(2)
  $0.MessageType get type => $_getN(1);
  @$pb.TagNumber(2)
  set type($0.MessageType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get serverMsgId => $_getSZ(2);
  @$pb.TagNumber(3)
  set serverMsgId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasServerMsgId() => $_has(2);
  @$pb.TagNumber(3)
  void clearServerMsgId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get workflowID => $_getSZ(3);
  @$pb.TagNumber(4)
  set workflowID($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasWorkflowID() => $_has(3);
  @$pb.TagNumber(4)
  void clearWorkflowID() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get uuid => $_getSZ(4);
  @$pb.TagNumber(5)
  set uuid($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasUuid() => $_has(4);
  @$pb.TagNumber(5)
  void clearUuid() => clearField(5);

  @$pb.TagNumber(6)
  $fixnum.Int64 get seq => $_getI64(5);
  @$pb.TagNumber(6)
  set seq($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasSeq() => $_has(5);
  @$pb.TagNumber(6)
  void clearSeq() => clearField(6);

  @$pb.TagNumber(7)
  $0.MessageStatus get status => $_getN(6);
  @$pb.TagNumber(7)
  set status($0.MessageStatus v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasStatus() => $_has(6);
  @$pb.TagNumber(7)
  void clearStatus() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get from => $_getSZ(7);
  @$pb.TagNumber(8)
  set from($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasFrom() => $_has(7);
  @$pb.TagNumber(8)
  void clearFrom() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get to => $_getSZ(8);
  @$pb.TagNumber(9)
  set to($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasTo() => $_has(8);
  @$pb.TagNumber(9)
  void clearTo() => clearField(9);

  @$pb.TagNumber(10)
  $core.List<$core.int> get body => $_getN(9);
  @$pb.TagNumber(10)
  set body($core.List<$core.int> v) { $_setBytes(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasBody() => $_has(9);
  @$pb.TagNumber(10)
  void clearBody() => clearField(10);

  @$pb.TagNumber(11)
  $fixnum.Int64 get userUpdateTime => $_getI64(10);
  @$pb.TagNumber(11)
  set userUpdateTime($fixnum.Int64 v) { $_setInt64(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasUserUpdateTime() => $_has(10);
  @$pb.TagNumber(11)
  void clearUserUpdateTime() => clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get time => $_getI64(11);
  @$pb.TagNumber(12)
  set time($fixnum.Int64 v) { $_setInt64(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasTime() => $_has(11);
  @$pb.TagNumber(12)
  void clearTime() => clearField(12);
}

