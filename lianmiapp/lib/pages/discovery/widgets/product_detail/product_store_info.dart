import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/widgets/load_image.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
// import '../../models/store_info_model.dart';

class ProductStoreInfo extends StatelessWidget {
  final StoreInfo storeInfo;

  ProductStoreInfo(this.storeInfo);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _topArea(),
          _bottomArea(),
        ],
      ),
    );
  }

  Widget _topArea() {
    return Container(
      margin: EdgeInsets.only(left: 15.px, right: 15.px),
      height: 75.px,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12, width: 1))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LoadImage(
            storeInfo.avatar!,
            width: 40.px,
            height: 40.px,
            fit: BoxFit.fill,
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10.px),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    storeInfo.branchesName!,
                    style: TextStyle(fontSize: 16.px),
                  ),
                  Text(
                    '距离500m',
                    style: TextStyle(fontSize: 12.px, color: Colors.black54),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomArea() {
    return Container(
      padding: EdgeInsets.only(left: 15.px, right: 15.px),
      height: 55.px,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Color(0XFFF3F6F9), width: 10.px))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.location_on),
          Text(
            storeInfo.province! +
                storeInfo.city! +
                storeInfo.area! +
                storeInfo.address!,
            style: TextStyle(fontSize: 14.px),
          ),
        ],
      ),
    );
  }
}
