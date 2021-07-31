// import 'package:lianmiapp/header/common_header.dart';
// import '../../models/product_info_model.dart';

// class ProductDetailInfo extends StatelessWidget {
//   final ProductInfoModel productInfo;

//   ProductDetailInfo(this.productInfo);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top:10.px),
//       padding: EdgeInsets.only(left:15.px),
//       width: double.infinity,
//       height: 80.px,
//       decoration: BoxDecoration(
//         border:Border(bottom: BorderSide(color: Color(0XFFF3F6F9),width: 10.px))
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             productInfo.productName!,
//             style: TextStyle(
//               fontSize: 20.px
//             ),
//           ),
//           Text(
//             '￥${productInfo.price}',
//             style: TextStyle(
//               fontSize: 20.px,
//               color: Colours.app_main
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }