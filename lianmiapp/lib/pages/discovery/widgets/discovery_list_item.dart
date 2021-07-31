import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/res/view_standard.dart';
import 'package:lianmiapp/util/location_utils.dart';
import 'package:lianmiapp/widgets/load_image.dart';
import '../discovery_router.dart';
// import '../models/store_list_model.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

class DiscoveryListItem extends StatelessWidget {
  final StoreInfo model;

  DiscoveryListItem(this.model);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.fromLTRB(16.px, 16.px, 16.px, 0.px),
        width: double.infinity,
        height: 240.px,
        color: Colours.bg_color,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            children: [_topArea(), _bottomArea()],
          ),
        ),
      ),
      onTap: () {
        NavigatorUtils.push(context,
            DiscoveryRouter.storePage + '?businessUsername=${model.userName}',
            routeSettings: RouteSettings(name: DiscoveryRouter.storePage));
      },
    );
  }

  Widget _topArea() {
    return Container(
      width: double.infinity,
      height: 48.px,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gaps.hGap8,
              LoadImageWithHolder(
                model.avatar ?? '',
                holderImg: ImageStandard.logo,
                width: 32.px,
                height: 32.px,
              ),
              Gaps.hGap5,
              CommonText(
                model.branchesName ?? '',
                fontSize: 14.px,
              )
            ],
          ),
          Container(
            padding: ViewStandard.padding,
            child: CommonText(
              LocationUtils.showShopDistance(double.parse(model.latitude!),
                  double.parse(model.longitude!)),
              fontSize: 12.px,
              color: Color(0XFF666666),
            ),
          )
        ],
      ),
    );
  }

  Widget _middleArea() {
    return Container(
      padding: EdgeInsets.only(left: 30.px),
      width: double.infinity,
      height: 160.px,
      alignment: Alignment.centerLeft,
      child: LoadImage(
        model.imageUrl!,
        // width: 40.px,
        height: 150.px,
        fit: BoxFit.fitHeight,
      ),
    );
  }

  Widget _bottomArea() {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
              child: LoadImageWithHolder(
                model.imageUrl ?? '',
                holderImg: ImageStandard.logo,
                fit: BoxFit.contain,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Positioned(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: ViewStandard.padding,
                  width: double.infinity,
                  height: 50.px,
                  color: Color(0X99000000),
                  alignment: Alignment.centerLeft,
                  child: CommonText(
                    model.address!,
                    fontSize: 14.px,
                    maxLines: 2,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
    // return Container(
    //   padding: EdgeInsets.only(left:50.px, right:16.px),
    //   height: 30.px,
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       Text(
    //         '1km',
    //         style: TextStyle(
    //           fontSize: 14.px,
    //           color: Colors.black38
    //         ),
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.end,
    //         children: [
    //           Text(
    //             '${model.commentcount??''}',
    //             style: TextStyle(
    //               fontSize: 16.px,
    //               color: Colors.black38
    //             ),
    //           ),
    //           Image.asset(
    //             ImageStandard.discoveryIconPinglun,
    //             width: 16.px,
    //             height: 16.px,
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(right:25.px)
    //           ),
    //           Text(
    //             '${model.likes??0}',
    //             style: TextStyle(
    //               fontSize: 16.px,
    //               color: Colors.black38
    //             ),
    //           ),
    //           Image.asset(
    //             ImageStandard.discoveryIconAixin,
    //             width: 16.px,
    //             height: 16.px,
    //           )
    //         ],
    //       )
    //     ],
    //   ),
    // );
  }
}
