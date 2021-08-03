import 'package:lianmiapp/header/common_header.dart';

class CircleButton extends StatelessWidget {
  final double? width;

  final double? height;

  final String? text;

  final Color? textColor;

  final double? fontSize;

  final Color? color;

  final Color? borderColor;

  final VoidCallback? onTap;

  CircleButton(this.text, {Key? key, this.width, this.height, this.textColor, this.fontSize, this.color, this.borderColor, this.onTap}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(12.px)),
      child: GestureDetector(
        onTap: () {
          if(this.onTap != null) onTap!();
        },
        child: Container(
          width: width??24.px,
          height: height??24.px,
          decoration: BoxDecoration(
            color: color??Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(width!=null?width!/2:22.px)),
            border: Border.all(width: 1, color: borderColor??Colors.transparent)
          ),
          alignment: Alignment.center,
          child: Text(
            text??'',
            style: TextStyle(
              fontSize: fontSize??12.px,
              color: textColor??Colors.black
            ),
          ),
        ),
      ),
    );
  }
}