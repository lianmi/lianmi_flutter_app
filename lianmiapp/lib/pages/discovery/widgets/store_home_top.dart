import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/provider/store_focus_provider.dart';
import 'package:lianmiapp/res/view_standard.dart';
import 'package:lianmiapp/util/location_utils.dart';
import 'package:lianmiapp/widgets/load_image.dart';
import 'package:lianmiapp/widgets/widget/images/avatar_image.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
// import '../models/store_info_model.dart';

class StoreHomeTop extends StatefulWidget {
  final StoreInfo model;

  StoreHomeTop(this.model);

  @override
  _StoreHomeTopState createState() => _StoreHomeTopState();
}

class _StoreHomeTopState extends State<StoreHomeTop> {
  late StoreInfo model;

  @override
  void initState() {
    super.initState();
    model = widget.model;
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: 375.px,
        height: 240.px,
        color: Color(0XFFF3F6F9),
        child: Stack(
          children: [
            Positioned(
              child: Container(
                width: 375.px,
                height: 160.px,
                color: Colours.app_main,
              ),
            ),
            Positioned(
              top: 30.px,
              child: Container(
                width: 375.px,
                height: 40.px,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        Navigator.maybePop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    CommonText(
                      model.branchesName!,
                      fontSize: 20.px,
                      color: Colors.white,
                    ),
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(right: 16.px),
                        width: 24.px,
                        height: 24.px,
                        alignment: Alignment.center,
                      ),
                      onTap: () {},
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 96.px,
              child: Container(
                width: 375.px,
                height: 140.px,
                padding: ViewStandard.padding,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8.px)),
                  ),
                  child: Row(
                    children: [
                      _leftArea(),
                      Gaps.hGap8,
                      _infoArea(context),
                      Gaps.hGap16,
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _leftArea() {
    return Container(
      padding: EdgeInsets.only(top: 16.px, left: 24.px),
      width: 72.px,
      height: double.infinity,
      alignment: Alignment.topLeft,
      child: AvatarImage(
        model.avatar!,
        width: 32.px,
        height: 32.px,
      ),
    );
  }

  Widget _infoArea(BuildContext context) {
    String fullAddress = '';
    if (isValidString(model.province)) fullAddress += model.province!;
    if (isValidString(model.city)) fullAddress += model.city!;
    if (isValidString(model.area)) fullAddress += model.area!;
    // if(isValidString(model.street)) fullAddress += model.street!;
    if (isValidString(model.address)) fullAddress += model.address!;
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.vGap10,
            CommonText(
              model.branchesName!,
              fontSize: 18.px,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonText(
                  '营业:${model.openingHours ?? ''}',
                  fontSize: 12.px,
                  color: Color(0XFF99A0AD),
                ),
                CommonText(
                  LocationUtils.showShopDistance(double.parse(model.latitude!),
                      double.parse(model.longitude!)),
                  fontSize: 12.px,
                  color: Color(0XFF99A0AD),
                )
              ],
            ),
            Gaps.vGap8,
            CommonText(
              '地址：${fullAddress}',
              fontSize: 12.px,
              maxLines: 2,
              color: Color(0XFF99A0AD),
            ),
           
            _bottomArea(context)
          ],
        ),
      ),
    );
  }


  Widget _bottomArea(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              child: Container(
                width: 60.px,
                height: 24.px,
                decoration: BoxDecoration(
                    color: Color(0XFFFFF3EE),
                    borderRadius: BorderRadius.all(Radius.circular(8.px))),
                alignment: Alignment.center,
                child: CommonText(
                  '联系商户',
                  color: Color(0XFFFF4400),
                  fontSize: 12.px,
                ),
              ),
              onTap: () {
                _showChat(context);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                    child: Image.asset(
                  ImageStandard.discoveryStoreCall,
                  width: 32.px,
                  height: 24.px,
                )),
                Gaps.hGap16,
                InkWell(
                    child: Image.asset(
                  ImageStandard.discoveryStoreGroup,
                  width: 32.px,
                  height: 24.px,
                )),
                Gaps.hGap16,
                Consumer<StoreFocusProvider>(
                    builder: (context, provider, child) {
                  return InkWell(
                      onTap: () {
                        if (provider.isFocus(model.userName!)) {
                          provider.unFocusStore(model.userName!);
                        } else {
                          provider.focusStore(model.userName!);
                        }
                      },
                      child: Image.asset(
                        ImageStandard.discoveryStoreFocus,
                        width: 32.px,
                        height: 24.px,
                        // color: provider.isFocus(model.businessUsername)?null:Colors.black38
                      ));
                })
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showChat(BuildContext context) {}
}
