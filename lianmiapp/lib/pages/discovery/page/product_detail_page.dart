// import 'package:lianmiapp/header/common_header.dart';
// import 'package:lianmiapp/pages/discovery/widgets/product_detail/product_store_info.dart';
// import 'package:lianmiapp/pages/product/lottery_router.dart';
// import '../widgets/product_detail/product_detail_info.dart';
// import '../widgets/product_detail/product_detail_bottom.dart';
// import '../widgets/product_detail/product_detail_photos.dart';
// import '../models/product_info_model.dart';
// import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

// class ProductDetailPage extends StatefulWidget {
//   final String businessUsername;

//   final String productId;

//   ProductDetailPage(this.businessUsername, this.productId);

//   @override
//   _ProductDetailPageState createState() => _ProductDetailPageState();
// }

// class _ProductDetailPageState extends State<ProductDetailPage> {
//   StoreInfo? _storeInfo;

//   ProductInfoModel? _productInfo;

//   @override
//   void initState() {
//     super.initState();
//     _requestStoreInfo();
//     _requestProductInfo();
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> children = [];

//     if (_productInfo != null) {
//       // children.add(ProductDetailCarousel(_productInfo!));
//       children.add(ProductDetailInfo(_productInfo!));
//     }

//     if (_storeInfo != null) {
//       children.add(ProductStoreInfo(_storeInfo!));
//     }

//     if (_productInfo?.descPics != null) {
//       children.add(ProductDetailPhotos(_productInfo!));
//     }

//     return Scaffold(
//       body: SafeArea(
//           child: Stack(
//         children: [
//           Positioned(
//             child: Container(
//               child: ListView(
//                 children: children,
//               ),
//             ),
//           ),
//           Positioned(
//             left: 0,
//             bottom: 0,
//             child: ProductDetailBottom(
//               onTapBuy: () {
//                 switch (_productInfo!.subType) {
//                   case 1:
//                     {
//                       NavigatorUtils.push(
//                           context,
//                           LotteryRouter.shuangseqiuPage +
//                               '?businessUsername=${widget.businessUsername}&productId=${widget.productId}');
//                     }
//                     break;
//                   default:
//                 }
//               },
//               onTapChat: () {},
//             ),
//           )
//         ],
//       )),
//     );
//   }

//   void _requestProductInfo() {
//     HubView.showLoading();
//     HttpUtils.get(HttpApi.productInfo + '/${widget.productId}').then((val) {
//       HubView.dismiss();
//       _productInfo = ProductInfoModel.fromJson(val);
//       logD(_productInfo!.productName);
//       setState(() {});
//     }).catchError((err) {
//       HubView.dismiss();
//     });
//   }

//   void _requestStoreInfo() {
//     HubView.showLoading();
//     HttpUtils.get(HttpApi.storeInfo + '/${widget.businessUsername}')
//         .then((val) {
//       HubView.dismiss();
//       _storeInfo = StoreInfo.fromMap(val); //lishijia
//       logD(_storeInfo!.openingHours);
//       setState(() {});
//     }).catchError((err) {
//       HubView.dismiss();
//     });
//   }
// }
