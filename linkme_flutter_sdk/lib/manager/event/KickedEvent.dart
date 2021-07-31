import 'package:linkme_flutter_sdk/manager/LogManager.dart';
import 'package:linkme_flutter_sdk/base_enum.dart';
import 'package:linkme_flutter_sdk/manager/EventBase.dart';
import 'package:linkme_flutter_sdk/manager/AppManager.dart';
import 'package:linkme_flutter_sdk/manager/NetworkResponse.dart';
import 'package:linkme_flutter_sdk/api/proto/auth/KickedEvent.pb.dart';

///2-5 在线设备被踢下线事件
class OnKicked extends EventBase {
  @override
  onMessage(NetworkResponse response) async {
    KickedEventRsp rsp = KickedEventRsp.fromBuffer(response.msgBody!);

    logV(
        '2-5 在线设备被踢下线事件 clientType: ${rsp.clientType}, reason: ${rsp.reason}, timeTag: ${rsp.timeTag}');

    //判断此被踢的消息是不是离线
    if (rsp.timeTag.toInt() < AppManager.latestLoginTimeAt!) {
      logV('此被踢的消息是离线消息, latestLoginTimeAt: ${AppManager.latestLoginTimeAt}');
    } else {
      logD('此被踢的消息不是离线消息, latestLoginTimeAt: ${AppManager.latestLoginTimeAt}');
      //注意 ，不能调用signout，因为服务端已经删除了之前用户的token
      //删除数据库记录
      // AppManager.gRepository!.deletePrivInfo(AppManager.currentUsername!);

      //登出
      appManager.clearCache();
    }
  }

  @override
  int getType() {
    return BusinessTypeEnum.BT_Auth.index;
  }

  @override
  int getSubType() {
    return OpAuthSubType.KickedEvent.index;
  }
}
