import 'package:lianmiapp/header/common_header.dart';
import 'circle_button.dart';

class LotteryAddButton extends StatelessWidget {
  final VoidCallback? onTap;

  LotteryAddButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return CircleButton(
      '+',
      color: Colours.app_main,
      fontSize: 18.px,
      textColor: Colors.white,
      onTap: onTap,
    );
  }
}