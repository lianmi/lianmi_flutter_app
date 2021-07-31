import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/me/provider/store_review_provider.dart';
// import 'package:lianmiapp/pages/me/widget/store_review/store_bank_widget.dart';
import 'package:lianmiapp/pages/me/widget/store_review/store_info_widget.dart';
import 'package:lianmiapp/pages/me/widget/store_review/store_legal_widget.dart';
import 'package:lianmiapp/widgets/widget/button/common_button.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

import '../recharge_page.dart';

class storeRegCenterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return storeCenterState();
  }
}

class storeCenterState extends State<storeRegCenterPage> {
  int _showPageIndex = 0;
  int _balance = 0; //余额

  @override
  void initState() {
    super.initState();

    _getBalance();
  }

  void _getBalance() {
    if (_balance == 0) {
      WalletMod.getBalance().then((value) {
        _balance = value;
      }).catchError((e) {
        _balance = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          backgroundColor: Colors.white,
        ),
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  Navigator.of(context, rootNavigator: true)
                      .popUntil(ModalRoute.withName('/'));
                },
                tooltip: 'Back',
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xff333333),
                ),
              ),
              backgroundColor: Colors.white,
              title:
                  Text('商户申请必填资料', style: TextStyle(color: Color(0xff333333))),
              centerTitle: true,
              actions: [],
              elevation: 0,
            ),
            body: SingleChildScrollView(child: _body())));
  }

  Widget _body() {
    return Form(
        child: Container(
            color: Color(0xffF3F6F9),
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      storeCenterState.Steper(_showPageIndex + 1),
                      _contentWiget(),
                      _bottomWidget()
                    ],
                  ),
                ),
              ],
            )));
  }

  Widget _contentWiget() {
    switch (_showPageIndex) {
      case 0:
        return StoreLegalWidget(); //法人
        break;
      case 1:
        return StoreInfoWidget(); //商户资料
        break;
      // case 2:
      //   return StoreBankWidget();
      //   break;
      default:
        return SizedBox();
    }
  }

  Widget _bottomWidget() {
    switch (_showPageIndex) {
      case 0:
        if (_balance >= 300) {
          return _oneBottomButton('下一步', onTap: () {
            setState(() {
              _showPageIndex = 1;
            });
          });
        } else {
          return _detailBottomButton('开通费300元，请先充值', topMargin: 40.px,
              onTap: () {
            AppNavigator.push(context, RechargePage());
          });
        }

        break;
      case 1:
        return _twoBottom(
            nextTitle: '提交',
            onTapLast: () {
              setState(() {
                _showPageIndex = 0;
              });
            },
            onTapNext: () {
              _submit();
              // setState(() {
              //   _showPageIndex = 2;
              // });
            });
        break;
      // case 2:
      //   return _twoBottom(
      //       nextTitle: '提交审核',
      //       onTapLast: () {
      //         setState(() {
      //           _showPageIndex = 1;
      //         });
      //       },
      //       onTapNext: () {
      //         _submit();
      //       });
      default:
        return SizedBox();
    }
  }

  Widget _detailBottomButton(String title,
      {double topMargin = 0, Function? onTap}) {
    return InkWell(
        onTap: () {
          onTap!();
        },
        child: Container(
          margin: EdgeInsets.only(top: topMargin),
          padding: EdgeInsets.fromLTRB(16.px, 12.px, 16.px, 12.px),
          height: 64.px,
          alignment: Alignment.center,
          color: Colors.white,
          child: Container(
            width: double.infinity,
            height: 40.px,
            decoration: BoxDecoration(
                color: Color(0XFFFF4400),
                borderRadius: BorderRadius.all(Radius.circular(4.px)),
                boxShadow: [
                  BoxShadow(
                      color: Color(0XFFFF4400),
                      offset: Offset(0.0, 0.0),
                      blurRadius: 4.px,
                      spreadRadius: 0)
                ]),
            alignment: Alignment.center,
            child: CommonText(
              title,
              fontSize: 16.px,
              color: Colors.white,
            ),
          ),
        ));
  }

  Widget _oneBottomButton(String title,
      {double topMargin = 0, Function? onTap}) {
    return InkWell(
        onTap: () {
          if (onTap != null) onTap();
        },
        child: Container(
          margin: EdgeInsets.only(top: topMargin),
          padding: EdgeInsets.fromLTRB(16.px, 12.px, 16.px, 12.px),
          height: 64.px,
          alignment: Alignment.center,
          color: Colors.white,
          child: Container(
            width: double.infinity,
            height: 40.px,
            decoration: BoxDecoration(
                color: Color(0XFFFF4400),
                borderRadius: BorderRadius.all(Radius.circular(4.px)),
                boxShadow: [
                  BoxShadow(
                      color: Color(0XFFFF4400),
                      offset: Offset(0.0, 0.0),
                      blurRadius: 4.px,
                      spreadRadius: 0)
                ]),
            alignment: Alignment.center,
            child: CommonText(
              title,
              fontSize: 16.px,
              color: Colors.white,
            ),
          ),
        ));
  }

  Widget _twoBottom(
      {required String nextTitle,
      required Function onTapLast,
      required Function onTapNext}) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.px, 12.px, 16.px, 12.px),
      width: double.infinity,
      height: 64.px,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: CommonButton(
              width: double.infinity,
              height: double.infinity,
              borderRadius: 4.px,
              color: Colours.app_main,
              text: '上一步',
              fontSize: 16.px,
              textColor: Colors.white,
              boxShadow: BoxShadow(
                  color: Color(0XFFFF4400),
                  offset: Offset(0.0, 0.0),
                  blurRadius: 4.px,
                  spreadRadius: 0),
              onTap: () {
                onTapLast();
              },
            ),
          ),
          SizedBox(width: 14.px),
          Expanded(
            child: CommonButton(
              width: double.infinity,
              height: double.infinity,
              borderRadius: 4.px,
              color: Colours.app_main,
              text: nextTitle,
              fontSize: 16.px,
              textColor: Colors.white,
              boxShadow: BoxShadow(
                  color: Color(0XFFFF4400),
                  offset: Offset(0.0, 0.0),
                  blurRadius: 4.px,
                  spreadRadius: 0),
              onTap: () {
                onTapNext();
              },
            ),
          ),
        ],
      ),
    );
  }

  static Widget Steper(int step) {
    return Container(
        padding: EdgeInsets.fromLTRB(35, 12, 35, 12),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Text('法人信息',
              style: TextStyle(
                color: step == 1 ? Colors.black : Color(0xff999999),
              )),
          Icon(
            Icons.arrow_right_alt,
            color: step == 1 ? Color(0xffFF4400) : Color(0xff999999),
          ),
          Text('商户资料',
              style: TextStyle(
                color: step == 2 ? Colors.black : Color(0xff999999),
              )),
          // Icon(
          //   Icons.arrow_right_alt,
          //   color: step == 2 ? Color(0xffFF4400) : Color(0xff999999),
          // ),
          // Text('开户银行',
          //     style: TextStyle(
          //       color: step == 3 ? Colors.black : Color(0xff999999),
          //     ))
        ]));
  }

  @override
  void dispose() {
    super.dispose();
    // Provider.of<StoreReviewProvider>(App.context!, listen: false).reset();
  }

  void _submit() {
    Provider.of<StoreReviewProvider>(App.context!, listen: false).submit();
  }
}
