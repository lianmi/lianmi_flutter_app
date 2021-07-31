///
//  Generated code. Do not modify.
//  source: api/proto/msg/RecvMsgEvent.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'MsgTypeEnum.pbenum.dart' as $0;

class RecvMsgEventRsp extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RecvMsgEventRsp', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'cloud.lianmi.im.msg'), createEmptyInstance: create)
    ..e<$0.MessageScene>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'scene', $pb.PbFieldType.OE, defaultOrMaker: $0.MessageScene.MsgScene_Undefined, valueOf: $0.MessageScene.valueOf, enumValues: $0.MessageScene.values)
    ..e<$0.MessageType>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: $0.MessageType.MsgType_Undefined, valueOf: $0.MessageType.valueOf, enumValues: $0.MessageType.values)
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'body', $pb.PbFieldType.OY)
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'from')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fromDeviceId', protoName: 'fromDeviceId')
    ..aOS(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'recv')
    ..aOS(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'serverMsgId', protoName: 'serverMsgId')
    ..aOS(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'workflowID', protoName: 'workflowID')
    ..a<$fixnum.Int64>(9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'seq', $pb.PbFieldType.OF6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'uuid')
    ..a<$fixnum.Int64>(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'time', $pb.PbFieldType.OF6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  RecvMsgEventRsp._() : super();
  factory RecvMsgEventRsp({
    $0.MessageScene? scene,
    $0.MessageType? type,
    $core.List<$core.int>? body,
    $core.String? from,
    $core.String? fromDeviceId,
    $core.String? recv,
    $core.String? serverMsgId,
    $core.String? workflowID,
    $fixnum.Int64? seq,
    $core.String? uuid,
    $fixnum.Int64? time,
  }) {
    final _result = create();
    if (scene != null) {
      _result.scene = scene;
    }
    if (type != null) {
      _result.type = type;
    }
    if (body != null) {
      _result.body = body;
    }
    if (from != null) {
      _result.from = from;
    }
    if (fromDeviceId != null) {
      _result.fromDeviceId = fromDeviceId;
    }
    if (recv != null) {
      _result.recv = recv;
    }
    if (serverMsgId != null) {
      _result.serverMsgId = serverMsgId;
    }
    if (workflowID != null) {
      _result.workflowID = workflowID;
    }
    if (seq != null) {
      _result.seq = seq;
    }
    if (uuid != null) {
      _result.uuid = uuid;
    }
    if (time != null) {
      _result.time = time;
    }
    return _result;
  }
  factory RecvMsgEventRsp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RecvMsgEventRsp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RecvMsgEventRsp clone() => RecvMsgEventRsp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RecvMsgEventRsp copyWith(void Function(RecvMsgEventRsp) updates) => super.copyWith((message) => updates(message as RecvMsgEventRsp)) as RecvMsgEventRsp; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RecvMsgEventRsp create() => RecvMsgEventRsp._();
  RecvMsgEventRsp createEmptyInstance() => create();
  static $pb.PbList<RecvMsgEventRsp> createRepeated() => $pb.PbList<RecvMsgEventRsp>();
  @$core.pragma('dart2js:noInline')
  static RecvMsgEventRsp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RecvMsgEventRsp>(create);
  static RecvMsgEventRsp? _defaultInstance;

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
  $core.List<$core.int> get body => $_getN(2);
  @$pb.TagNumber(3)
  set body($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBody() => $_has(2);
  @$pb.TagNumber(3)
  void clearBody() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get from => $_getSZ(3);
  @$pb.TagNumber(4)
  set from($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFrom() => $_has(3);
  @$pb.TagNumber(4)
  void clearFrom() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get fromDeviceId => $_getSZ(4);
  @$pb.TagNumber(5)
  set fromDeviceId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasFromDeviceId() => $_has(4);
  @$pb.TagNumber(5)
  void clearFromDeviceId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get recv => $_getSZ(5);
  @$pb.TagNumber(6)
  set recv($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasRecv() => $_has(5);
  @$pb.TagNumber(6)
  void clearRecv() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get serverMsgId => $_getSZ(6);
  @$pb.TagNumber(7)
  set serverMsgId($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasServerMsgId() => $_has(6);
  @$pb.TagNumber(7)
  void clearServerMsgId() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get workflowID => $_getSZ(7);
  @$pb.TagNumber(8)
  set workflowID($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasWorkflowID() => $_has(7);
  @$pb.TagNumber(8)
  void clearWorkflowID() => clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get seq => $_getI64(8);
  @$pb.TagNumber(9)
  set seq($fixnum.Int64 v) { $_setInt64(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasSeq() => $_has(8);
  @$pb.TagNumber(9)
  void clearSeq() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get uuid => $_getSZ(9);
  @$pb.TagNumber(10)
  set uuid($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasUuid() => $_has(9);
  @$pb.TagNumber(10)
  void clearUuid() => clearField(10);

  @$pb.TagNumber(11)
  $fixnum.Int64 get time => $_getI64(10);
  @$pb.TagNumber(11)
  set time($fixnum.Int64 v) { $_setInt64(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasTime() => $_has(10);
  @$pb.TagNumber(11)
  void clearTime() => clearField(11);
}

