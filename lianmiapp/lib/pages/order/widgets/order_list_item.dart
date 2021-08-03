import 'package:flutter/material.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/legalattest/page/hetongorder_detail_page.dart';
// import 'package:lianmiapp/pages/legalattest/page/order_detail_page.dart';
import 'package:lianmiapp/pages/product/model/order_model.dart';
import 'package:lianmiapp/pages/product/page/order_detail_page.dart';
import 'package:lianmiapp/res/view_standard.dart';
import 'package:lianmiapp/util/date_time_utils.dart';
import 'package:lianmiapp/widgets/load_image.dart';
import 'package:lianmiapp/widgets/widget/button/common_button.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

class OrderListItem extends StatefulWidget {
  final OrderModel model;

  OrderListItem(this.model);

  @override
  _OrderListItemState createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  late OrderModel order;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    order = widget.model;
    return InkWell(
      onTap: () {
        logI('order.loterryType: ${order.loterryType}');
        //TODO  判断order的商品类型，然后跳转到相应的下单页面
        if (order.loterryType! <= 7) {
          AppNavigator.pushResult(context, OrderDetailPage(order), (result) {});
        } else {
          //除了彩票类的所有存证
          logI('除了彩票类的所有存证的订单详情页面');
          AppNavigator.pushResult(
              context, HetongOrderDetailPage(order), (result) {});
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 16.px),
        padding: ViewStandard.padding,
        width: double.infinity,
        child: Container(
          width: double.infinity,
          padding: ViewStandard.padding,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8.px)),
              boxShadow: [
                BoxShadow(
                    color: Color(0XFFF1E8E8),
                    offset: Offset(0.0, 4.px),
                    blurRadius: 4.px,
                    spreadRadius: 0)
              ]),
          child: Column(
            children: [_topWidget(), _middleWidget() /*, _bottomArea()*/],
          ),
        ),
      ),
    );
  }

  Widget _topWidget() {
    if (App.isShop) return SizedBox();
    return Container(
      width: double.infinity,
      height: 48.px,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 1.px, color: Color(0XFFF5F5F5)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: CommonText(
              order.shopName ?? '订单',
              fontSize: 16.px,
            ),
          ),
          CommonText(
            '${_getStatusText()} >',
            fontSize: 14.px,
            color: Color(0xFF333333),
          )
        ],
      ),
    );
  }

  Widget _middleWidget() {
    double amount = order.cost! * 100;

    Color shopStatusColor = Colours.app_main;
    if (widget.model.status == OrderStateEnum.OS_Prizeed &&
        widget.model.prize == 0) {
      shopStatusColor = Colors.black45;
    }
    return Container(
      width: double.infinity,
      height: 104.px,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8.px)),
            child: LoadImageWithHolder(
              widget.model.orderImageUrl ?? ImageStandard.logo,
              holderImg: ImageStandard.logo,
              width: 72.px,
              height: 72.px,
            ),
          ),
          Gaps.hGap8,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CommonText(
                        order.orderShowName, //
                        fontSize: 16.px,
                        color: Color(0XFF2E2E33),
                      ),
                      App.isShop
                          ? CommonText(
                              '${_getStatusText()} >',
                              fontSize: 14.px,
                              color: shopStatusColor,
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                Gaps.vGap8,
                CommonText(
                  (widget.model.loterryType! <= 7)
                      ? '${(amount).toStringAsFixed(2)}元 ${order.count}注${order.multiple}倍'
                      : '${(amount).toStringAsFixed(2)}元',
                  fontSize: 14.px,
                  color: Color(0XFF666666),
                ),
                Gaps.vGap16,
                Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CommonText(
                        '出票码:${order.ticketCode}',
                        fontSize: 14.px,
                        color: Color(0XFF666666),
                      ),
                      CommonText(
                        '${DateTimeUtils.orderTimeFromTimestamp(order.orderTime!)}',
                        fontSize: 10.px,
                        color: Color(0XFF999999),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String _getStatusText() {
    String statusText = '';
    if (App.isShop) {
      switch (widget.model.status) {
        case OrderStateEnum.OS_Prepare:
          {
            statusText = '待接单';
          }
          break;
        case OrderStateEnum.OS_Taked:
          {
            statusText = ' 已接单';
          }
          break;
        case OrderStateEnum.OS_IsPayed:
          {
            statusText = '已支付';
          }
          break;
        case OrderStateEnum.OS_Done:
          {
            statusText = '已完成';
          }
          break;
        case OrderStateEnum.OS_UpChained:
          {
            statusText = '已存证';
          }
          break;
        case OrderStateEnum.OS_Confirm:
          {
            statusText = '已确认';
          }
          break;
        case OrderStateEnum.OS_Refuse:
          {
            statusText = '已拒单';
          }
          break;
        case OrderStateEnum.OS_Prizeed:
          {
            if (widget.model.prize != null && widget.model.prize! > 0) {
              statusText = '中奖金额:${widget.model.prize!.toStringAsFixed(0)}元';
            } else {
              statusText = '未中奖';
            }
          }
          break;
        case OrderStateEnum.OS_AcceptPrizeed:
          {
            statusText = '已兑奖';
          }
          break;
        default:
      }
    } else {
      switch (widget.model.status) {
        case OrderStateEnum.OS_Prepare:
          {
            statusText = '待接单';
          }
          break;
        case OrderStateEnum.OS_Taked:
          {
            statusText = '已接单';
          }
          break;
        case OrderStateEnum.OS_IsPayed:
          {
            statusText = '待出票';
          }
          break;
        case OrderStateEnum.OS_Done:
          {
            statusText = '已完成';
          }
          break;
        case OrderStateEnum.OS_UpChained:
          {
            statusText = '已存证';
          }
          break;
        case OrderStateEnum.OS_Confirm:
          {
            statusText = '已确认';
          }
          break;

        case OrderStateEnum.OS_Refuse:
          {
            statusText = '已拒单';
          }
          break;
        case OrderStateEnum.OS_Prizeed:
          {
            if (widget.model.prize != null && widget.model.prize! > 0) {
              statusText = '中奖金额:${widget.model.prize!.toStringAsFixed(0)}元';
            } else {
              statusText = '未中奖';
            }
          }
          break;
        case OrderStateEnum.OS_AcceptPrizeed:
          {
            statusText = '已兑奖';
          }
          break;
        default:
      }
    }
    return statusText;
  }
}
