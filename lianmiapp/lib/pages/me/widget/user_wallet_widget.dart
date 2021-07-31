import 'package:flutter/material.dart';
import 'package:lianmiapp/res/colors.dart';
import 'package:lianmiapp/res/gaps.dart';
import 'package:lianmiapp/res/styles.dart';

class UserWalletWidget extends StatelessWidget {
  bool _isVip;
  UserWalletWidget(this._isVip);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colours.back1),
          child: Row(
            children: [
              _expandedIcon(
                  Icon(
                    Icons.monetization_on,
                    size: 20,
                    color: Colours.app_main,
                  ),
                  title: '我的钱包',
                  onTap: () {}),
              VerticalDivider(
                indent: 10,
                endIndent: 10,
                color: Colours.text_gray_c,
              ),
              _expandedIcon(
                  Text(
                    '200',
                    style: TextStyles.font15(
                        bar: true, fontWeight: FontWeight.bold),
                  ),
                  title: '余额',
                  onTap: () {}),
              _expandedIcon(
                  Text(
                    '200',
                    style: TextStyles.font15(
                        bar: true, fontWeight: FontWeight.bold),
                  ),
                  title: '链包',
                  onTap: () {}),
              _expandedIcon(
                  Text(
                    '200',
                    style: TextStyles.font15(
                        bar: true, fontWeight: FontWeight.bold),
                  ),
                  title: '账单',
                  onTap: () {}),
              Expanded(
                  child: GestureDetector(
                child: Text(
                  'VIP',
                  style: TextStyles.font23(
                      bar: true,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: _isVip ? Colours.app_main : Colours.text_gray_c),
                ),
              ))
            ],
          ),
        ),
        Gaps.vGap10,
        Container(
          height: 60,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colours.back1),
          child: Row(
            children: [
              _expandedIcon(
                  Text(
                    '200',
                    style: TextStyles.font15(
                        bar: true, fontWeight: FontWeight.bold),
                  ),
                  title: '成交订单',
                  onTap: () {}),
              _expandedIcon(
                  Text(
                    '200',
                    style: TextStyles.font15(
                        bar: true, fontWeight: FontWeight.bold),
                  ),
                  title: '收藏夹',
                  onTap: () {}),
              _expandedIcon(
                  Text(
                    '20',
                    style: TextStyles.font15(
                        bar: true, fontWeight: FontWeight.bold),
                  ),
                  title: '我的关注',
                  onTap: () {}),
              _expandedIcon(
                  Text(
                    '999+',
                    style: TextStyles.font15(
                        bar: true, fontWeight: FontWeight.bold),
                  ),
                  title: '我的足迹',
                  onTap: () {}),
            ],
          ),
        ),
      ],
    );
  }

  Widget _expandedIcon(Widget child,
          {required Function onTap, required String title}) =>
      Expanded(
          child: GestureDetector(
        child: Container(
            color: Colors.transparent,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                child,
                Text(
                  title,
                  style: TextStyles.font12(),
                )
              ],
            )),
        onTap: () {
          onTap();
        },
      ));
}
