// // import 'package:flutter_swiper/flutter_swiper.dart';
// import 'package:lianmiapp/header/common_header.dart';
// import 'package:lianmiapp/widgets/load_image.dart';
// import '../../models/product_info_model.dart';

// class ProductDetailCarousel extends StatefulWidget {
//   final ProductInfoModel model;

//   ProductDetailCarousel(this.model);

//   @override
//   _ProductDetailCarouselState createState() => _ProductDetailCarouselState();
// }

// class _ProductDetailCarouselState extends State<ProductDetailCarousel> {
//   List<String> _photos = [];

//   int _currentPage = 1;

//   @override
//   Widget build(BuildContext context) {
//     _photos.clear();
//     for (ProductPicModel pic in widget.model.productPics!) {
//       _photos.add(pic.large!);
//     }

//     return Container(
//       width: double.infinity,
//       height: 250.px,
//       child: Stack(
//         children: [
//           // Positioned(
//           //   // child: _swiperDiy(),
//           // ),
//           Positioned(
//             child: InkWell(
//               child: Container(
//                 margin: EdgeInsets.only(left: 16.px),
//                 width: 40.px,
//                 height: 40.px,
//                 alignment: Alignment.centerLeft,
//                 child: Icon(Icons.arrow_back_ios),
//               ),
//               onTap: () {
//                 NavigatorUtils.goBack(context);
//               },
//             ),
//           ),
//           Positioned(
//             right: 15.px,
//             bottom: 8.px,
//             child: Container(
//               width: 40.px,
//               height: 18.px,
//               decoration: BoxDecoration(
//                 color: Color(0XFFC5C5C5),
//                 borderRadius: BorderRadius.all(Radius.circular(9.px)),
//               ),
//               alignment: Alignment.center,
//               child: Text(
//                 '$_currentPage/${_photos.length}',
//                 style: TextStyle(fontSize: 13.px, color: Colors.white),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   // Widget _swiperDiy() {
//   //   return Container(
//   //     width: double.infinity,
//   //     height: 280.px,
//   //     child: Swiper(
//   //       itemBuilder: (BuildContext context,int index){
//   //         return ClipRRect(
//   //           child: LoadImage(
//   //             _photos[index],
//   //             height: 280.px,
//   //             fit: BoxFit.fill,
//   //           ),
//   //           borderRadius: BorderRadius.circular(5),
//   //         );
//   //       },
//   //       itemCount: _photos.length,
//   //       autoplay: true,
//   //       onIndexChanged: (index) {
//   //         setState(() {
//   //           _currentPage = index+1;
//   //         });
//   //       },
//   //       onTap: (index){
//   //         print('点击banner$index');
//   //       },
//   //     ),
//   //   );
//   // }
// }
