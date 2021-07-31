///用户二维码
class UserQrPage extends StatelessWidget with QrEvents{
  GlobalKey _globalKey = new GlobalKey();
  Widget build(BuildContext context) {
    return Material(
      child: RepaintBoundary(
        key: _globalKey,
        child: Container(
          color: ColorStandard.back1,
          padding: ViewStandard.zhuPagePadding,
          child: Column(
            children: [
              SkipConfirmTop(
                title: '下载App二维码',
                rightWidget: Center(
                  child: Image.asset(
                    ImageStandard.iconMores,
                    width: ViewStandard.smallButtonSize,
                    height: ViewStandard.smallButtonSize,
                  )
                ),
                rightTap: (){
                  showMaterialModalBottomSheet(
                    context: context,
                    builder: (context) => _headlerQr()
                  );
                },
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _qrWidget(),
                    SizedBox(height: Adapt.px(16),),
                    Text('扫一扫加我为好友', style: FontStandard.font15(),),
                    SizedBox(height: Adapt.px(60),)
                  ],
                )
              )
            ],
          ),
        ),
      )
    );
  }


  ///二维码
  Widget _qrWidget() => QrImage(
      data: "#*UserInfoPage*#1234567890", ///#* *#内字段表示需跳转的路由， 后面嵌套的字符串表示请求用户数据的接口数据
      version: QrVersions.auto,
      size: 200.0,
      foregroundColor: ColorStandard.blue1,
      embeddedImageStyle: QrEmbeddedImageStyle(
        size: Size(Adapt.px(40), Adapt.px(40)),
      ),
      embeddedImage: AssetImage(ImageStandard.head1)
  );

  ///操作二维码
  Widget _headlerQr() => SingleChildScrollView(
    controller: ModalScrollController.of(Application.context),
    child: Container(
      height: Adapt.px(191),
      width: double.infinity,
      color: ColorStandard.back1,
      child: Column(
        children: [
          GestureDetector(
            onTap: (){
              saveImage(_globalKey);
            },
            child: Container(
              height: ViewStandard.userMessageButtonHeight,
              color: Colors.transparent,
              alignment: Alignment.center,
              child: Text('保存二维码', style: FontStandard.font15(),),
            ),
          ),
          DividerWidget(padding: Adapt.px(16),),
          GestureDetector(
            onTap: (){
              showDialog(
                context: Application.context,
                builder: (context) => RemindDialog(
                  remind: '重置二维码后,旧的二维码将失效',
                  cancelColor: ColorStandard.fontGrey,
                  cancel: (){
                    Navigator.of(context).pop();
                  },
                  confirm: (){
                    Navigator.of(context).pop();
                  },
                )
              );
            },
            child: Container(
              height: ViewStandard.userMessageButtonHeight,
              color: Colors.transparent,
              alignment: Alignment.center,
              child: Text('重置二维码', style: FontStandard.font15(),),
            ),
          ),
          Container(
            height: Adapt.px(10),
            color: ColorStandard.back2,
          ),
          GestureDetector(
            onTap: (){
              Navigator.of(Application.context).pop();
            },
            child: Container(
              height: ViewStandard.userMessageButtonHeight,
              color: Colors.transparent,
              alignment: Alignment.center,
              child: Text('取消', style: FontStandard.font15(),),
            ),
          ),
        ],
      ),
    ),
  );
}