// import 'package:linkme_flutter_sdk/manager/LogManager.dart';
// import 'package:linkme_flutter_sdk/base_enum.dart';
// import 'package:linkme_flutter_sdk/manager/EventBase.dart';
// import 'package:linkme_flutter_sdk/api/proto/msg/SyncSystemMsg.pb.dart';
// import 'package:linkme_flutter_sdk/isolate/isolate_db/my_database.dart' as Db;
// import 'package:linkme_flutter_sdk/manager/NetworkResponse.dart';

// import '../AppManager.dart';

// ///5-9 同步系统公告事件
// class OnSyncSystemMsg extends EventBase {
//   @override
//   onMessage(NetworkResponse response) {
//     SyncSystemMsgRsp rsp = SyncSystemMsgRsp.fromBuffer(response.msgBody!);

//     logV('5-9 同步系统公告事件 \n timeTag: ${rsp.timeTag}');
//     /*
//     AppManager.gRepository!
//         .updateSyncTimeTag('systemMsgAt', DateTime.now().millisecondsSinceEpoch)
//         .then((value) {
//       logV('更新时间戳systemMsgAt success');

//       rsp.systemMsags.forEach((systemMsg) {
//         Db.SystemMsg _systemMsg = new Db.SystemMsg(
//           id: systemMsg.id.toInt(),
//           level: systemMsg.level,
//           title: systemMsg.title,
//           content: systemMsg.content,
//           createdAt: systemMsg.createdAt.toInt(),
//         );
//         AppManager.gRepository!
//             .querySystemMsgs(systemMsg.id.toInt())
//             .then((userTags) {
//           if (userTags.length == 0) {
//             AppManager.gRepository!
//                 .insertSystemMsg(_systemMsg)
//                 .then((value) => logD('insertSystemMsg success'))
//                 .catchError((err) => logE('insertSystemMsg Error: $err'));
//           }
//         });
//       });
//     }).catchError((err) {
//       logE(err);
//     });
//     */
//   }

//   @override
//   int getType() {
//     return BusinessTypeEnum.BT_Messages.index;
//   }

//   @override
//   int getSubType() {
//     return OpMsgSubType.SyncSystemMsgEvent.index;
//   }
// }
