///
//  Generated code. Do not modify.
//  source: api/proto/auth/KickedEvent.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'KickedEvent.pbenum.dart';

export 'KickedEvent.pbenum.dart';

class KickedEventRsp extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'KickedEventRsp', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'cloud.lianmi.im.auth'), createEmptyInstance: create)
    ..e<ClientType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'clientType', $pb.PbFieldType.OE, protoName: 'clientType', defaultOrMaker: ClientType.Ct_UnKnow, valueOf: ClientType.valueOf, enumValues: ClientType.values)
    ..e<KickReason>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'reason', $pb.PbFieldType.OE, defaultOrMaker: KickReason.KickReasonUndefined, valueOf: KickReason.valueOf, enumValues: KickReason.values)
    ..a<$fixnum.Int64>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'timeTag', $pb.PbFieldType.OF6, protoName: 'timeTag', defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  KickedEventRsp._() : super();
  factory KickedEventRsp({
    ClientType? clientType,
    KickReason? reason,
    $fixnum.Int64? timeTag,
  }) {
    final _result = create();
    if (clientType != null) {
      _result.clientType = clientType;
    }
    if (reason != null) {
      _result.reason = reason;
    }
    if (timeTag != null) {
      _result.timeTag = timeTag;
    }
    return _result;
  }
  factory KickedEventRsp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory KickedEventRsp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  KickedEventRsp clone() => KickedEventRsp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  KickedEventRsp copyWith(void Function(KickedEventRsp) updates) => super.copyWith((message) => updates(message as KickedEventRsp)) as KickedEventRsp; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static KickedEventRsp create() => KickedEventRsp._();
  KickedEventRsp createEmptyInstance() => create();
  static $pb.PbList<KickedEventRsp> createRepeated() => $pb.PbList<KickedEventRsp>();
  @$core.pragma('dart2js:noInline')
  static KickedEventRsp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<KickedEventRsp>(create);
  static KickedEventRsp? _defaultInstance;

  @$pb.TagNumber(1)
  ClientType get clientType => $_getN(0);
  @$pb.TagNumber(1)
  set clientType(ClientType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasClientType() => $_has(0);
  @$pb.TagNumber(1)
  void clearClientType() => clearField(1);

  @$pb.TagNumber(2)
  KickReason get reason => $_getN(1);
  @$pb.TagNumber(2)
  set reason(KickReason v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasReason() => $_has(1);
  @$pb.TagNumber(2)
  void clearReason() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get timeTag => $_getI64(2);
  @$pb.TagNumber(3)
  set timeTag($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTimeTag() => $_has(2);
  @$pb.TagNumber(3)
  void clearTimeTag() => clearField(3);
}

