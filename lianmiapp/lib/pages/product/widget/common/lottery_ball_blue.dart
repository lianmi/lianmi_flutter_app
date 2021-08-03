import 'package:lianmiapp/header/common_header.dart';
import 'circle_button.dart';

class LotteryBallBlue extends StatelessWidget {
  final int number;

  final VoidCallback? onTap;

  LotteryBallBlue(this.number, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return CircleButton(
      '${number}',
      color: Colors.blueAccent,
      fontSize: 16.px,
      textColor: Colors.white,
    );
  }
}