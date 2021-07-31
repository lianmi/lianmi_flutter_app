// import 'package:lianmiapp/header/common_header.dart';
// import 'package:lianmiapp/widgets/load_image.dart';
// import '../../models/product_info_model.dart';

// class ProductDetailPhotos extends StatelessWidget {
//   final ProductInfoModel productInfo;

//   ProductDetailPhotos(this.productInfo);

//   @override
//   Widget build(BuildContext context) {
//     List<String> _photos = [];

//     if(productInfo.descPics!=null) {
//       _photos.addAll(productInfo.descPics!);
//     }

//     return _photos.length>0?Container(
//       width: 375.px,
//       margin: EdgeInsets.only(bottom:55.px),
//       decoration: BoxDecoration(
//         border:Border(bottom: BorderSide(color: Color(0XFFF3F6F9),width: 10.px))
//       ),
//       child: ListView.builder(
//         scrollDirection: Axis.vertical,
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: _photos.length,
//         itemBuilder: (BuildContext context, int index) {
//           return InkWell(
//             child: Container(
//               width: 375.px,
//               child: LoadImage(
//                 _photos[index],  
//                 height: 280.px,
//                 fit: BoxFit.fill,
//               )
//             ),
//             onTap: () {
//             },
//           ); 
//         }
//       ),
//     ):SizedBox.shrink();
//   }
// }