import 'package:flutter/material.dart';
import 'package:lianmiapp/res/image_standard.dart';
import 'package:lianmiapp/widgets/load_image.dart';

class AvatarImage extends StatelessWidget {
  final String? iconPath;

  final double? width;

  final double? height;

  final double? borderRadius;

  AvatarImage(this.iconPath,{this.width, this.height, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    double targetBorderRadius = 0.0;
    if(borderRadius == null) {
      targetBorderRadius = width!=null?width!/2:0;
    } else {
      targetBorderRadius = borderRadius!;
    }
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(targetBorderRadius)),
      child: LoadImageWithHolder(
        iconPath,
        holderImg: ImageStandard.logo,
        width: width??double.infinity,
        height: height??double.infinity,
      ),
    );
  }
}