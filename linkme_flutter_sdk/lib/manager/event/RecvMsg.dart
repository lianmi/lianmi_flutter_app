import 'package:linkme_flutter_sdk/api/proto/order/Product.pb.dart';

import 'package:linkme_flutter_sdk/manager/LogManager.dart';
import 'package:linkme_flutter_sdk/manager/NetworkResponse.dart';
import 'package:linkme_flutter_sdk/sdk/SdkEnum.dart';
import 'package:linkme_flutter_sdk/api/proto/msg/RecvMsgEvent.pb.dart';
import 'package:linkme_flutter_sdk/base_enum.dart';
import 'package:linkme_flutter_sdk/manager/EventBase.dart';
import 'package:linkme_flutter_sdk/manager/AppManager.dart';
import 'package:linkme_flutter_sdk/models/OrderInfo.dart';
import 'package:linkme_flutter_sdk/api/proto/msg/RecvMsgEvent.pbserver.dart';

///5-2 消息接收事件
class OnRecvMsg extends EventBase {
  @override
  onMessage(NetworkResponse response) async {
    RecvMsgEventRsp rsp = RecvMsgEventRsp.fromBuffer(response.msgBody!);

    final scene = MessageSceneEnum.values[rsp.scene.value];
    final type = MessageTypeEnum.values[rsp.type.value];

    switch (scene) {
      case MessageSceneEnum.MsgScene_S2C: // 服务端主动推送给（用户, 商户）订单消息
        switch (type) {
        
          case MessageTypeEnum.MsgType_Order: //订单类型的消息
            _processOrderMessage(rsp);
            break;

          default:
            logW('此消息类型未处理， type: ${rsp.type}');
        }

        break;

      default:
        logW('此消息的scene没有处理程序， scene: $scene');
    }
  }

  @override
  int getType() {
    return BusinessTypeEnum.BT_Messages.index;
  }

  @override
  int getSubType() {
    return OpMsgSubType.RecvMsgEvent.index;
  }

  /// @nodoc 处理订单消息方法
  void _processOrderMessage(RecvMsgEventRsp rsp) async {
    OrderProductBody orderProductBody = OrderProductBody.fromBuffer(rsp.body);

    if (orderProductBody.orderID == '') {
      logW('订单ID不能为空');
      return;
    }

    OrderInfoData _orderInfoData = new OrderInfoData();
    _orderInfoData.orderId = orderProductBody.orderID;
    _orderInfoData.ticketCode = orderProductBody.ticketCode.toInt();
    _orderInfoData.orderTime = orderProductBody.orderTime.toInt();
    _orderInfoData.productId = orderProductBody.productID;
    _orderInfoData.buyerUsername = orderProductBody.buyerUserName;
    _orderInfoData.storeUsername = orderProductBody.storeUserName;
    _orderInfoData.totalAmount = orderProductBody.totalAmount; //彩票金额
    _orderInfoData.fee = orderProductBody.fee; //手续费
    _orderInfoData.payMode = orderProductBody.payMode; //支付方式
    _orderInfoData.body = orderProductBody.body; //订单内容
    _orderInfoData.orderImagefile = orderProductBody.orderImageFile; //彩票拍照
    _orderInfoData.imageHash = orderProductBody.imageHash; //彩票图片哈希
    _orderInfoData.prize = orderProductBody.prize; //中奖金额
    _orderInfoData.blockNumber = orderProductBody.blockNumber.toInt(); //区块高度
    _orderInfoData.txHash = orderProductBody.txHash; //交易哈希

    //订单状态
    _orderInfoData.state = orderProductBody.state.value;
    logV(
        '收到服务端下发的订单消息:\n scene: ${rsp.scene}, \n type: ${rsp.type}, \n serverMsgId: ${rsp.serverMsgId}, \n time: ${rsp.time}, \n 订单数据: ${_orderInfoData.toJson()}');

    //回调UI层
    if (AppManager.onReceiveOrder != null) {
      AppManager.onReceiveOrder!(_orderInfoData);
    } else {
      // UI层没设置订单回调监听
      logW("UI层没设置订单回调监听");
    }
  }
}
