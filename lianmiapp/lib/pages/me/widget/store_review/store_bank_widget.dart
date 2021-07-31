// import 'package:lianmiapp/header/common_header.dart';
// import 'package:lianmiapp/pages/me/provider/store_review_provider.dart';
// import 'package:lianmiapp/pages/me/widget/store_review/action_item.dart';
// import 'package:lianmiapp/pages/me/widget/store_review/input_item.dart';
// import 'package:lianmiapp/res/view_standard.dart';

// class StoreBankWidget extends StatefulWidget {
//   @override
//   _StoreBankWidgetState createState() => _StoreBankWidgetState();
// }

// class _StoreBankWidgetState extends State<StoreBankWidget> {
//   final TextEditingController _ctrlName = TextEditingController();
//   Function valiName = (value) {
//     if (value.isEmpty) {
//       return '姓名不能为空';
//     }
//   };

//   final TextEditingController _ctrlBankName = TextEditingController();
//   Function valiBankName = (value) {
//     if (value.isEmpty) {
//       return '银行名称不能为空';
//     }
//   };

//   final TextEditingController _ctrlBankBranchName = TextEditingController();
//   Function valiBankBranchName = (value) {
//     if (value.isEmpty) {
//       return '银行支行不能为空';
//     }
//   };

//   final TextEditingController _ctrlBankCode = TextEditingController();
//   Function valiBankCode = (value) {
//     if (value.isEmpty) {
//       return '银行卡号不能为空';
//     }
//   };

//   final TextEditingController _ctrlWX= TextEditingController();
//   Function valiWX = (value) {
//     if (value.isEmpty) {
//       return '微信号不能为空';
//     }
//   };

//   String? _imageLocalPath;

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<StoreReviewProvider>(
//       builder: (context, provider, child){
//         _ctrlName.text = provider.reviewData.cardOwner;
//         _ctrlBankName.text = provider.reviewData.bankName;
//         _ctrlBankBranchName.text = provider.reviewData.bankBranch;
//         _ctrlBankCode.text = provider.reviewData.cardNumber;
//         _ctrlWX.text = provider.reviewData.wechat;
//         return Container(
//           padding: ViewStandard.padding,
//           color: Colors.white,
//           child: Column(
//             children: [
//               InputItem(
//                 title: "姓        名", 
//                 hintText: '请输入姓名', 
//                 controller: _ctrlName, 
//                 valid: valiName, 
//                 button: Container(),
//                 onChange: (String text) {
//                   provider.reviewData.cardOwner = text;
//                 },
//               ),
//               InputItem(
//                 title: "银行名称", 
//                 hintText: '请输入银行名称', 
//                 controller: _ctrlBankName, 
//                 valid: valiBankName, 
//                 button: Container(),
//                 onChange: (String text) {
//                   provider.reviewData.bankName = text;
//                 },
//               ),
//               InputItem(
//                 title: "银行支行", 
//                 hintText: '请输入银行支行', 
//                 controller: _ctrlBankBranchName, 
//                 valid: valiBankBranchName, 
//                 button: Container(),
//                 onChange: (String text) {
//                   provider.reviewData.bankBranch = text;
//                 },
//               ),
//               InputItem(
//                 title: "银行卡号", 
//                 hintText: '请输入银行卡号', 
//                 controller: _ctrlBankCode, 
//                 valid: valiBankCode, 
//                 button: Container(),
//                 onChange: (String text) {
//                   provider.reviewData.cardNumber = text;
//                 },
//               ),
//               InputItem(
//                 title: "微  信  号", 
//                 hintText: '请输入微信号', 
//                 controller: _ctrlWX, 
//                 valid: valiWX, 
//                 button: Container(),
//                 onChange: (String text) {
//                   provider.reviewData.wechat = text;
//                 },
//               ),
//             ],
//           ),
//         );
//       }
//     );
//   }
// }