import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lianmiapp/res/colors.dart';
import 'package:lianmiapp/res/gaps.dart';
import 'package:lianmiapp/res/styles.dart';

class UserProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return                     Container(
			height: 140,
			decoration: BoxDecoration(
				color: Colours.back1,
				borderRadius: BorderRadius.circular(10),
			),
			child: Column(
				children: [
					Expanded(child: Row(
						children: [
							_expandedMessage(
									'邀请有礼',
									icon: Icon(Icons.card_giftcard, size: 25,),
									onTap: (){

									}
							),
							VerticalDivider(indent: 10, endIndent: 10, color: Colours.text_gray_c,),
							_expandedMessage(
									'联系客服',
									icon: Icon(Icons.message, size: 25,),
									onTap: (){

									}
							),
						],
					)),
					Divider(indent: 10, endIndent: 10, color: Colours.text_gray_c,),
					Expanded(child: Row(
						children: [
							_expandedMessage(
									'设置',
									icon: Icon(Icons.settings, size: 25,),
									onTap: (){

									}
							),
							VerticalDivider(indent: 10, endIndent: 10, color: Colours.text_gray_c,),
							_expandedMessage(
									'关于我们',
									icon: Icon(Icons.supervisor_account, size: 25,),
									onTap: (){

									}
							),
						],
					)),
				],
			),
		);
  }

	Widget _expandedMessage(String title, {required Widget icon, required Function onTap}) => Expanded(
			child: GestureDetector(
				child: Container(
					padding: EdgeInsets.all(5),
					color: Colors.transparent,
					alignment: Alignment.center,
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.center,
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							icon,
							Gaps.vGap8,
							Text(title, style: TextStyles.font12(),)
						],
					),
				),
				onTap: (){
					onTap();
				},
			)
	);
}
