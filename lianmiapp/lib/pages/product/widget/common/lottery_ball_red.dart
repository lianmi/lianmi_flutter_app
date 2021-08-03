import 'package:lianmiapp/header/common_header.dart';
import 'circle_button.dart';

class LotteryBallRed extends StatelessWidget {
  final int number;

  final VoidCallback? onTap;

  LotteryBallRed(this.number, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return CircleButton(
      '${number}',
      width: 44.px,
      height: 44.px,
      color: Colors.redAccent,
      fontSize: 16.px,
      textColor: Colors.white,
    );
  }
}