import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lianmiapp/res/colors.dart';
import 'package:lianmiapp/res/styles.dart';
import 'package:lianmiapp/res/view_standard.dart';
import 'package:lianmiapp/util/adapt.dart';

class UserVipWidget extends StatelessWidget {
	bool _isVip;
	UserVipWidget(this._isVip);

  Widget build(BuildContext context) {
    return Container(
			height: Adapt.px(45),
			width: Adapt.px(330),
			padding: ViewStandard.padding,
			decoration: BoxDecoration(
				color: Colours.app_main,
				borderRadius: BorderRadius.vertical(top: Radius.circular(5))
			),
			child: Stack(
				children: [
					Positioned(
							top: -30,
							right: 20,
							child: Text('V', style: TextStyles.font88(
								color: Colors.white.withOpacity(0.3),
								fontWeight: FontWeight.w800,
							),)
					),
					SizedBox(
							width: double.infinity,
							height: double.infinity,
							child: Row(
								children: [
									Text('VIP ',
										style: TextStyles.font23(
												fontWeight: FontWeight.bold,
												fontStyle: FontStyle.italic,
												color: Colors.white
										),
									),
									Text(_isVip ? '当月已为您节省88元，预计节省909元/月' : '开通橙卡会员, 平均可省906元/年', style: TextStyles.font12(color: Colors.white),),
									Expanded(child: SizedBox()),
									_isVip ? SizedBox() : Container(
											width: 60,
											height: 20,
											alignment: Alignment.center,
											decoration: BoxDecoration(
													borderRadius: BorderRadius.circular(15),
													color: Colors.cyan[700]
											),
											child: Text('立即开通', style: TextStyles.font10(color: Colors.white,),)
									)
								],
							)
					)
				],
			),
		);
  }
}
