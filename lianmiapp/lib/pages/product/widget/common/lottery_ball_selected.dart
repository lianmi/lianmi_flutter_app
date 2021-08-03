import 'package:lianmiapp/header/common_header.dart';
import 'circle_button.dart';

class LotteryBallSelected extends StatelessWidget {
  final int number;

  final VoidCallback? onTap;

  LotteryBallSelected(this.number, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return CircleButton(
      '${number}',
      color: Colors.black54,
      fontSize: 16.px,
      textColor: Colors.white,
    );
  }
}