import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:lianmiapp/pages/me/page/userInfo/user_update_page.dart';
import 'package:lianmiapp/pages/me/page/user_qr_page.dart';
import 'package:lianmiapp/pages/me/widget/user_profile_widget.dart';
import 'package:lianmiapp/pages/me/widget/user_vip_widget.dart';
import 'package:lianmiapp/pages/me/widget/user_wallet_widget.dart';
import 'package:lianmiapp/res/colors.dart';
import 'package:lianmiapp/res/gaps.dart';
import 'package:lianmiapp/res/styles.dart';
import 'package:lianmiapp/res/view_standard.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.bg_color,
      appBar: AppBar(
        backgroundColor: Colours.bg_color,
        leading: SizedBox(),
        title: null,
        actions: [
          IconButton(icon: Icon(Icons.add_alert, color: Colours.text_gray, size: 30,), onPressed: (){
            ///跳转客服页面
          }),
          SizedBox(width: 16,),
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.topCenter,
              padding: ViewStandard.padding,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child:  Container(
                        height: 80,
                        alignment: Alignment.center,
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              child: Image.asset('assets/images/shop/tx.png'),
                            ),
                            Gaps.hGap8,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('李老板', style: TextStyles.font19(fontWeight: FontWeight.bold), ),
                                Gaps.vGap4,
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.phone_android, color: Colours.text_gray_c, size: 15,),
                                    Gaps.hGap5,
                                    Text('13729241677', style: TextStyles.font14(color: Colours.text_gray_c),)
                                  ],
                                )
                              ],
                            ),
                            Expanded(child: SizedBox()),
                            GestureDetector(
                              child: Icon(Icons.qr_code, size: 35, color: Colours.text_gray,),
                              onTap: (){
                                ///打开二维码页面
                                Navigator.of(context).push(
                                    CupertinoPageRoute(builder: (_) => UserQrPage())
                                );
                              },
                            )
                          ],
                        )
                      ),
                      onTap: (){
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(builder: (_) => UserUpdatePage())
                        // );
                      },
                    ),
                   
                    Gaps.vGap10,
                    UserProfileWidget()
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
