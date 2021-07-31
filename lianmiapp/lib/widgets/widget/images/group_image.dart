// import 'package:flutter/material.dart';
// import 'package:nine_grid_view/nine_grid_view.dart';
// import 'package:lianmiapp/util/adapt.dart';

// class GroupImage extends StatelessWidget {
//   final List<String>? images;

//   final double? width;

//   final double? height;

//   final double? borderRadius;

//   GroupImage(this.images, {this.width, this.height, this.borderRadius});

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.all(Radius.circular(borderRadius??0)),
//       child: NineGridView(
//         width: this.width??double.infinity,
//         height: this.height??double.infinity,
//         padding: EdgeInsets.all(2),
//         alignment: Alignment.center,
//         space: 3,
//         type: NineGridType.weChatGp,
//         itemCount: images!.length,
//         itemBuilder: (BuildContext context, int index) {
//           return _getWidget(images![index]);
//         },
//       )
//     );
//   }

//   Widget _getWidget(String url) {
//     if (url.startsWith('http')) {
//       //return CachedNetworkImage(imageUrl: url, fit: BoxFit.cover);
//       return Image.network(url, fit: BoxFit.cover);
//     }
//     if (url.endsWith('.png')) {
//       return Image.asset(url,
//           fit: BoxFit.cover);
//     }
//     //return Image.file(File(url), fit: BoxFit.cover);
//     return Image.asset(_getImgPath(url), fit: BoxFit.cover);
//   }

//   String _getImgPath(String name, {String format: 'png'}) {
//     return 'assets/images/$name.$format';
//   }
// }


