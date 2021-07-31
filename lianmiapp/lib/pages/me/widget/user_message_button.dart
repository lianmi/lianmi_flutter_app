import 'package:flutter/cupertino.dart';
import 'package:lianmiapp/res/colors.dart';
import 'package:lianmiapp/res/styles.dart';
import 'package:lianmiapp/res/view_standard.dart';
import 'package:lianmiapp/util/adapt.dart';

class UserMessageButton extends StatefulWidget {
	Function onTap;
	String title;
	Widget? rightWidget;
	String? rightText;
	UserMessageButton({
		required this.onTap,
		required this.title,
	 this.rightText,
		this.rightWidget
	});
  _UserMessageButtonState createState() => _UserMessageButtonState();
}

class _UserMessageButtonState extends State<UserMessageButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
			child: Container(
				padding: ViewStandard.padding,
				height: Adapt.px(60),
				color: Colours.back1,
				child: Row(
					children: [
						Text(widget.title, style: TextStyles.font16(fontWeight: FontWeight.w500),),
						Expanded(child: SizedBox()),
						widget.rightWidget ?? Row(
							children: [
								Text(widget.rightText ?? '请选择',
									style: TextStyles.font14(
											color: widget.rightText != null
													? Colours.text : Colours.text_gray),
								),
								Icon(CupertinoIcons.right_chevron, color: Colours.text_gray, size: Adapt.px(15),),
							],
						)
					],
				),
			),
			onTap: (){
				widget.onTap();
			},
		);
  }
}
