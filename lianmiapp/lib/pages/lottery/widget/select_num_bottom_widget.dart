import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/lottery/model/lottery_product_model.dart';
import 'package:lianmiapp/pages/lottery/provider/lottery_provider.dart';
import 'package:lianmiapp/pages/lottery/utils/lottery_data.dart';
import 'package:lianmiapp/res/view_standard.dart';

class SelectNumBottomWidget extends StatefulWidget {
  final Function onTapClearAll;

  final Function onTapConfirm;

  SelectNumBottomWidget(
      {required this.onTapClearAll, required this.onTapConfirm});

  @override
  _SelectNumBottomWidgetState createState() => _SelectNumBottomWidgetState();
}

class _SelectNumBottomWidgetState extends State<SelectNumBottomWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.px,
      height: 100.px,
      child: Column(
        children: [
          _topArea(),
          _bottomArea(),
        ],
      ),
    );
  }

  Widget _topArea() {
    return Container(
        padding: ViewStandard.padding,
        width: double.infinity,
        height: 40.px,
        child: Consumer<LotteryProvider>(builder: (context, provider, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonText(
                '${provider.count}注${provider.multiple}倍',
                fontSize: 18.px,
                color: Color(0XFF5D5C5C),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CommonText(
                    '加倍',
                    fontSize: 18.px,
                    color: Color(0XFF535252),
                  ),
                  Gaps.hGap10,
                  _beiWidget('-', onTap: () {
                    provider.minusMultiple();
                  }),
                  // Gaps.hGap5,
                  CommonText(
                    '${provider.multiple}',
                    fontSize: 18.px,
                    color: Color(0XFF535252),
                  ),
                  // Gaps.hGap5,
                  _beiWidget('+', onTap: () {
                    provider.addMultiple();
                  }),
                ],
              )
            ],
          );
        }));
  }

  Widget _beiWidget(String title, {Function? onTap}) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      child: Container(
        width: 40.px,
        height: 40.px,
        alignment: Alignment.center,
        child: Container(
          width: 24.px,
          height: 24.px,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: Color(0XFFD8D8D8)),
              borderRadius: BorderRadius.all(Radius.circular(12.px))),
          alignment: Alignment.center,
          child: CommonText(
            title,
            fontSize: 20.px,
            color: Color(0XFFD8D8D8),
          ),
        ),
      ),
    );
  }

  Widget _bottomArea() {
    return Container(
      padding: ViewStandard.padding,
      width: 375.px,
      height: 60.px,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(width: 1, color: Color(0XFFD8D8D8)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer<LotteryProvider>(builder: (context, provider, child) {
            LotteryProductModel product =
                LotteryData.instance.getProduct(provider.lotteryId)!;
            double price = product.productPrice! *
                provider.count *
                provider.multiple /
                100;
            return CommonText(
              '合计：￥${price.toStringAsFixed(2)}',
              color: Color(0XFF686767),
              fontSize: 20.px,
            );
          }),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  widget.onTapClearAll();
                },
                child: Container(
                  width: 88.px,
                  height: 44.px,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8.px)),
                      border: Border.all(width: 1, color: Color(0XFFD8D8D8))),
                  alignment: Alignment.center,
                  child: CommonText(
                    '清除所有',
                    fontSize: 16.px,
                    color: Colors.black,
                  ),
                ),
              ),
              Gaps.hGap16,
              GestureDetector(
                  onTap: () {
                    widget.onTapConfirm();
                  },
                  child: Container(
                      width: 88.px,
                      height: 44.px,
                      decoration: BoxDecoration(
                          color: Colours.app_main,
                          borderRadius:
                              BorderRadius.all(Radius.circular(8.px))),
                      alignment: Alignment.center,
                      child: CommonText(
                        '确认',
                        fontSize: 16.px,
                        color: Colors.white,
                      )))
            ],
          )
        ],
      ),
    );
  }
}
