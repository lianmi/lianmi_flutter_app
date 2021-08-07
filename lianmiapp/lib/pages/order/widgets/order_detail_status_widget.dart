import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:lianmiapp/header/common_header.dart';

class OrderDetailStatusWidget extends StatelessWidget {
  final int loterryType;
  final OrderStateEnum status;
  final double prize;

  OrderDetailStatusWidget(
      {required this.loterryType, required this.status, this.prize = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.px),
      width: double.infinity,
      height: 100.px,
      child: Column(
        children: _getContents(),
      ),
    );
  }

  List<Widget> _getContents() {
    Widget topWidget = SizedBox();
    Widget bottomWidget = SizedBox();
    switch (status) {
      case OrderStateEnum.OS_Prepare:
        {
          if (App.isShop) {
            topWidget = _item(title: '此用户下单', isSuccess: true);
            bottomWidget = _item(title: '请根据用户的付款方式及金额上传收款码', isSuccess: true);
          } else {
            topWidget = _item(title: '订单已经发送给商户', isSuccess: true);
            bottomWidget = _item(title: '正在等待商户上传收款码', isSuccess: true);
          }
        }
        break;
      case OrderStateEnum.OS_Taked:
        {
          if (App.isShop) {
            topWidget = _item(title: '此用户下单', isSuccess: true);
            bottomWidget = _item(title: '请留意用户是否付款', isSuccess: true);
          } else {
            topWidget = _item(title: '商户已接单', isSuccess: true);
            bottomWidget = _item(title: '请扫码收款码并确认支付成功', isSuccess: true);
          }
        }
        break;
      case OrderStateEnum.OS_IsPayed:
        {
          if (App.isShop) {
            topWidget = _item(title: '此用户已支付', isSuccess: true);
            bottomWidget = _item(title: '请尽快出票并拍照上传', isSuccess: true);
          } else {
            topWidget = _item(title: '已支付给到商户', isSuccess: true);
            bottomWidget = _item(title: '正在等待商户出票', isSuccess: true);
          }
        }
        break;
      case OrderStateEnum.OS_Done:
        {
          if (App.isShop) {
            topWidget = _item(title: '此用户已核实存证', isSuccess: true);
            bottomWidget = _item(title: '已上传拍照', isSuccess: true);
          } else {
            topWidget = _item(title: '商户确认收到支付信息', isSuccess: true);
            bottomWidget = _item(title: '商户已上传拍照', isSuccess: true);
          }
        }
        break;
      case OrderStateEnum.OS_UpChained:
        {
          if (App.isShop) {
            topWidget = _item(title: '已拍照上传', isSuccess: true);
            bottomWidget = _item(title: '存证生成完毕， 等待用户核对', isSuccess: true);
          } else {
            topWidget = _item(title: '存证生成完毕，请核对', isSuccess: true);
            bottomWidget = _item(title: '商户已上传拍照', isSuccess: true);
          }
        }
        break;
      case OrderStateEnum.OS_Confirm:
        {
          if (App.isShop) {
            topWidget = _item(title: '用户已确认存证真实', isSuccess: true);
            if (loterryType >= 1 && loterryType <= 7) {
              bottomWidget = _item(title: '等待开奖结果', isSuccess: true);
            } else {
              bottomWidget = _item(title: '业务结束', isSuccess: true);
            }
          } else {
            topWidget = _item(title: '已核实存证', isSuccess: true);
            if (loterryType >= 1 && loterryType <= 7) {
              bottomWidget = _item(title: '等待开奖结果', isSuccess: true);
            } else {
              bottomWidget = _item(title: '业务结束', isSuccess: true);
            }
          }
        }
        break;
      case OrderStateEnum.OS_Refuse:
        {
          if (App.isShop) {
            topWidget = _item(title: '此用户下单', isSuccess: true);
            bottomWidget = _item(title: '已拒绝接单，此单已作废', isSuccess: true);
          } else {
            topWidget = _item(title: '订单已发送给到商户', isSuccess: true);
            bottomWidget = _item(title: '商户拒绝接单，此单已作废', isSuccess: true);
          }
        }
        break;
      case OrderStateEnum.OS_Prizeed:
        {
          if (loterryType >= 1 && loterryType <= 7) {
            String prizeText = prize == 0
                ? '已开奖，此票未中奖'
                : '已开奖，此票中奖金额${prize.toStringAsFixed(0)}元';
            if (App.isShop) {
              topWidget = _item(title: '已通知用户中奖', isSuccess: true);
              bottomWidget = _item(title: prizeText, isSuccess: true);
            } else {
              topWidget = _item(title: '等待商户付款', isSuccess: true);
              bottomWidget = _item(title: prizeText, isSuccess: true);
            }
          }
        }
        break;
      case OrderStateEnum.OS_AcceptPrizeed:
        {
          if (loterryType >= 1 && loterryType <= 7) {
            String prizeText = prize == 0
                ? '已开奖，此票未中奖'
                : '已开奖，此票中奖金额${prize.toStringAsFixed(0)}元';
            if (App.isShop) {
              topWidget = _item(title: '此用户已确认', isSuccess: true);
              bottomWidget = _item(title: prizeText, isSuccess: true);
            } else {
              topWidget = _item(title: '已兑奖', isSuccess: true);
              bottomWidget = _item(title: prizeText, isSuccess: true);
            }
          }
        }
        break;
      default:
    }
    return [topWidget, _line(), bottomWidget];
  }

  Widget _item({String? title, bool? isSuccess}) {
    return Row(
      children: [
        Container(
          width: 10.px,
          height: 10.px,
          decoration: BoxDecoration(
              color: isSuccess! ? Colours.app_main : Colors.transparent,
              border: Border.all(
                  width: 1.px,
                  color: isSuccess ? Colors.transparent : Color(0XFFD1D1D1)),
              borderRadius: BorderRadius.all(Radius.circular(5.px))),
        ),
        Gaps.hGap8,
        CommonText(
          title!,
          fontSize: 14.px,
          color: isSuccess ? Color(0XFF666666) : Color(0XFFD1D1D1),
        )
      ],
    );
  }

  Widget _line() {
    return Container(
      width: double.infinity,
      height: 20.px,
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(left: 4.5.px),
        width: 1.px,
        height: double.infinity,
        color: Color(0XFFD1D1D1),
      ),
    );
  }
}
