import 'package:lianmiapp/header/common_header.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

class StoreHomMiddle extends StatefulWidget {
  final StoreInfo model;

  StoreHomMiddle(this.model);

  @override
  _StoreHomMiddleState createState() => _StoreHomMiddleState();
}

class _StoreHomMiddleState extends State<StoreHomMiddle> {
  late StoreInfo model;

  @override
  void initState() {
    super.initState();
    model = widget.model;
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              height: 6,
              // child: ,
            ),
          ),
          Text(
            '商户支持以下存证智能合约',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xAA001133),
            ),
          )
        ],
      ),
    );
  }
}
