import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/provider/base/provider_widget.dart';
import 'package:lianmiapp/provider/me/login_view_model.dart';
import 'package:lianmiapp/res/gaps.dart';
import 'package:lianmiapp/res/view_standard.dart';
import 'package:lianmiapp/util/keyboard_utils.dart';
import 'package:lianmiapp/widgets/widget/button/common_button.dart';
import 'package:lianmiapp/widgets/widget/button/custom_icon_button.dart';
import 'package:lianmiapp/widgets/widget/divider_widget.dart';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late TextEditingController _phone;
  late TextEditingController _idCode;
  bool _isShowKeyboard = false;

  LoginViewModel _loginViewModel = LoginViewModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        if (MediaQuery.of(context).viewInsets.bottom == 0) {
          _isShowKeyboard = false;
        } else {
          _isShowKeyboard = true;
        }
      });
    });
  }

  Widget build(BuildContext context) {
    return ProviderWidget<LoginViewModel>(
      viewmodel: _loginViewModel,
      builder: (BuildContext context, value, Widget child) {
        _phone = value.phone!;
        _idCode = value.idCode!;

        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
              width: double.infinity,
              color: Colors.white,
              child: Stack(children: [
                Positioned(
                  child: SafeArea(
                      child: Column(
                    children: [_contentWidget(value), _thirdLoginWidget(value)],
                  )),
                ),
              ])),
        );
      },
    );
  }

  Widget _contentWidget(LoginViewModel value) {
    return Flexible(
        child: Column(children: [
      Flexible(
          child: Container(
        child: ListView(
          children: [
            SizedBox(height: 20.px),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: CommonText('????????????', fontSize: 18.px, color: Colors.black),
            ),
            SizedBox(height: 90.px),
            Container(
              padding: EdgeInsets.only(left: 24.px, right: 24.px),
              width: double.infinity,
              height: 54.px,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ImageStandard.loginPhone,
                    width: 13.px,
                    height: 20.px,
                  ),
                  Gaps.hGap10,
                  Expanded(
                    child: Container(
                      height: ViewStandard.widgetHeight,
                      width: double.infinity,
                      child: TextField(
                        controller: _phone,
                        cursorColor: Colours.app_main,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly, //?????????????????????
                          LengthLimitingTextInputFormatter(11)
                        ],
                        onChanged: (e) {
                          if (e.length >= 10) {
                            value.checkSub();
                          }
                        },
                        decoration: const InputDecoration(
                            hintText: '??????????????????', border: InputBorder.none),
                      ),
                    ),
                  )
                ],
              ),
            ),
            DividerWidget(),
            Container(
              padding: EdgeInsets.only(left: 24.px, right: 24.px),
              width: double.infinity,
              height: 54.px,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    ImageStandard.loginPassword,
                    width: 13.px,
                    height: 20.px,
                  ),
                  Gaps.hGap10,
                  Expanded(
                    child: Container(
                      child: TextField(
                        controller: _idCode,
                        cursorColor: Colours.app_main,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly, //?????????????????????
                          LengthLimitingTextInputFormatter(6)
                        ],
                        onChanged: (e) {
                          if (e.length >= 5) {
                            value.checkSub();
                          }
                        },
                        decoration: const InputDecoration(
                            hintText: '???????????????', border: InputBorder.none),
                      ),
                    ),
                  ),
                  CommonButton(
                    width: 90.px,
                    height: double.infinity,
                    color: Colors.white,
                    text: value.timerText,
                    fontSize: 14.px,
                    textColor: value.timerText == '???????????????'
                        ? Colours.app_main
                        : Colours.text_gray,
                    onTap: () {
                      if (value.timerText == '???????????????') {
                        value.getCode();
                      }
                    },
                  )
                ],
              ),
            ),
            DividerWidget(),
            Container(
              padding: EdgeInsets.only(left: 24.px, right: 24.px),
              width: double.infinity,
              height: 40.px,
              alignment: Alignment.centerLeft,
              child: CommonText(
                '????????????????????????????????????????????????????????????',
                fontSize: 13.px,
                color: Color(0XFF999999),
              ),
            ),
            SizedBox(height: 90.px),
            CommonButton(
              margin: ViewStandard.padding,
              width: double.infinity,
              height: 54.px,
              borderRadius: 8.px,
              color: Colours.app_main,
              text: '??????',
              fontSize: 16.px,
              textColor: Colors.white,
              onTap: () {
                KeyboardUtils.hideKeyboard(context);
                value.isSub ? value.sub(context) : null;
              },
            ),
            Container(
              padding: EdgeInsets.only(left: 24.px, right: 24.px),
              width: double.infinity,
              height: 50.px,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        value.setAgree();
                      },
                      child: Container(
                          width: 14.px,
                          height: 14.px,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.px, color: Color(0XFFB5B5B5))),
                          alignment: Alignment.center,
                          child: value.isAgree
                              ? Image.asset(
                                  ImageStandard.loginAgree,
                                  width: 10.px,
                                  height: 8.px,
                                )
                              : SizedBox())),
                  Gaps.hGap5,
                  InkWell(
                      onTap: () {
                        value.setAgree();
                      },
                      child: CommonText(
                        '?????????????????????',
                        fontSize: 12.px,
                        color: Color(0X66000000),
                      )),
                  CommonText(
                    '????????????App???????????????',
                    fontSize: 12.px,
                    color: Colours.app_main,
                  )
                ],
              ),
            ),
          ],
        ),
      ))
    ]));
  }

  Widget _thirdLoginWidget(LoginViewModel value) {
    if (_isShowKeyboard) return SizedBox();
    return Container(
      margin: EdgeInsets.only(bottom: 20.px),
      width: double.infinity,
      height: 120.px,
      alignment: Alignment.center,
      child: CustomIconButton(
        width: 50.px,
        height: 50.px,
        icon: ImageStandard.wx,
        onTap: () {
          value.wxLogin();
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }
}
