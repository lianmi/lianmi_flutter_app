import "package:flutter/material.dart";
import 'package:lianmiapp/util/image_utils.dart';

enum SlideDirection { right2left, bottom2top }

class me_utils {
  roundRectImage(double h, double w, String imageUrl, double radius1) {
    return Container(
      width: w,
      height: h,
      margin: EdgeInsets.only(right: 16),
      decoration: new BoxDecoration(
        color: Colors.white,
        image: new DecorationImage(
            image: ImageUtils.getImageProvider(imageUrl), fit: BoxFit.cover),
        shape: BoxShape.rectangle, // <-- 这里需要设置为 rectangle
        borderRadius: new BorderRadius.all(
          Radius.circular(radius1), // <-- rectangle 时，BorderRadius 才有效
        ),
      ),
    );
  }

  static Widget backButton(BuildContext context, Color color) {
    return IconButton(
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        Navigator.maybePop(context);
      },
      tooltip: 'Back',
      icon: Icon(
        Icons.arrow_back_ios,
        color: color,
      ),
    );
  }

  static Route createPageRouter(
      SlideDirection slideDirection, Widget destPage) {
    return PageRouteBuilder(pageBuilder: (BuildContext context,
        Animation animation, Animation secondaryAnimation) {
      return destPage;
    }, transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation, Widget child) {
      var begin = Offset(0, 1);
      if (slideDirection == SlideDirection.right2left) {
        begin = Offset(1, 0);
      }
      var end = Offset.zero;
      var curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(
        child: child,
        position: offsetAnimation,
      );
    });
  }
}
