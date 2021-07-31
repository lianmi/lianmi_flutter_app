import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/widgets/load_image.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import '../discovery_router.dart';
// import '../models/store_list_model.dart';

class DiscoverySearchItem extends StatelessWidget {
  final StoreInfo model;

  DiscoverySearchItem(this.model);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(bottom: 15.px),
        width: double.infinity,
        height: 90.px,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.only(left: 16.px)),
            _leftArea(),
            _middleArea(),
            _rightArea()
          ],
        ),
      ),
      onTap: () {
        NavigatorUtils.push(
            context,
            DiscoveryRouter.storePage +
                '?businessUsername=${model.userName}'); //lishijia
      },
    );
  }

  Widget _leftArea() {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(8.px)),
      child: Container(
        width: 80.px,
        height: 80.px,
        color: Color(0XFFF3F6F9),
        alignment: Alignment.center,
        child: LoadImage(model.avatar!, width: 70.px, height: 70.px),
      ),
    );
  }

  Widget _middleArea() {
    if (model.keys == null) model.keys = '';
    List<String> keys = model.keys!.split(' ');
    List<Widget> flags = [];
    keys.forEach((element) {
      flags.add(Container(
        margin: EdgeInsets.only(right: 8.px),
        padding: EdgeInsets.only(left: 5.px, right: 5.px),
        height: 18.px,
        decoration: BoxDecoration(
          color: Color(0XFFFFFE9E3),
          borderRadius: BorderRadius.all(Radius.circular(3.px)),
        ),
        alignment: Alignment.center,
        child: Text(
          element,
          style: TextStyle(fontSize: 12.px, color: Color(0XFFFF8D83)),
        ),
      ));
    });

    return Expanded(
        child: Container(
      margin: EdgeInsets.only(left: 12.px),
      height: 80.px,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model.branchesName!,
            style: TextStyle(fontSize: 17.px, color: Colors.black),
          ),
          Text(
            '营业:${model.openingHours}',
            style: TextStyle(fontSize: 12.px, color: Colors.black54),
          ),
          Row(
            children: flags,
          )
        ],
      ),
    ));
  }

  Widget _rightArea() {
    return Container(
      width: 50.px,
      height: 80.px,
      alignment: Alignment.centerLeft,
      child: Text(
        '<500m',
        style: TextStyle(fontSize: 12.px, color: Colors.black54),
      ),
    );
  }
}
