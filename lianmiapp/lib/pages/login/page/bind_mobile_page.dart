import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/provider/base/provider_widget.dart';
import 'package:lianmiapp/provider/me/bindmobile_view_model.dart';
import 'package:lianmiapp/res/gaps.dart';
import 'package:lianmiapp/res/view_standard.dart';
import 'package:lianmiapp/util/keyboard_utils.dart';
import 'package:lianmiapp/widgets/widget/button/common_button.dart';
import 'package:lianmiapp/widgets/widget/divider_widget.dart';

class BindMobilePage extends StatefulWidget {
  _BindMobilePageState createState() => _BindMobilePageState();
}

class _BindMobilePageState extends State<BindMobilePage>
    with WidgetsBindingObserver {
  late TextEditingController _phone;
  late TextEditingController _idCode;

  BindMobileViewModel _bindMobileViewModel = BindMobileViewModel();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
  }

  Widget build(BuildContext context) {
    return ProviderWidget<BindMobileViewModel>(
      viewmodel: _bindMobileViewModel,
      builder: (BuildContext context, value, Widget child) {
        _phone = value.phone!;
        _idCode = value.idCode!;

        return Scaffold(
          appBar: MyCustomAppBar(
            centerTitle: '绑定手机号',
            isShowBack: false,
          ),
          backgroundColor: Colors.white,
          body: Container(
              width: double.infinity,
              color: Colors.white,
              child: Stack(children: [
                Positioned(
                  child: SafeArea(
                      child: Column(
                    children: [
                      _contentWidget(value),
                    ],
                  )),
                ),
              ])),
        );
      },
    );
  }

  Widget _contentWidget(BindMobileViewModel value) {
    return Flexible(
        child: Column(children: [
      Flexible(
          child: Container(
        child: ListView(
          children: [
            SizedBox(height: 20.px),
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
                          FilteringTextInputFormatter.digitsOnly, //只允许输入数字
                          LengthLimitingTextInputFormatter(11)
                        ],
                        onChanged: (e) {
                          if (e.length >= 10) {
                            value.checkSub();
                          }
                        },
                        decoration: const InputDecoration(
                            hintText: '输入手机号码', border: InputBorder.none),
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
                          FilteringTextInputFormatter.digitsOnly, //只允许输入数字
                          LengthLimitingTextInputFormatter(6)
                        ],
                        onChanged: (e) {
                          if (e.length >= 5) {
                            value.checkSub();
                          }
                        },
                        decoration: const InputDecoration(
                            hintText: '输入验证码', border: InputBorder.none),
                      ),
                    ),
                  ),
                  CommonButton(
                    width: 90.px,
                    height: double.infinity,
                    color: Colors.white,
                    text: value.timerText,
                    fontSize: 14.px,
                    textColor: value.timerText == '获取验证码'
                        ? Colours.app_main
                        : Colours.text_gray,
                    onTap: () {
                      if (value.timerText == '获取验证码') {
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
                '温馨提示：未注册的手机号码将自动为你注册',
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
              text: '绑定',
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
                        '我已阅读并同意',
                        fontSize: 12.px,
                        color: Color(0X66000000),
                      )),
                  CommonText(
                    '《易上链App服务协议》',
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

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance!.removeObserver(this);
  }
}
