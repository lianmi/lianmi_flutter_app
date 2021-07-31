import 'dart:ui';

import 'package:lianmiapp/header/common_header.dart';
import '../models/store_type_model.dart';

class DiscoveryTypesWidget extends StatefulWidget {
  final List<StoreTypeModel> types;

  final ValueSetter<int> onTap;

  DiscoveryTypesWidget({required this.types,required this.onTap});

  @override
  _DiscoveryTypesWidgetState createState() => _DiscoveryTypesWidgetState();
}

class _DiscoveryTypesWidgetState extends State<DiscoveryTypesWidget> {
  @override
  Widget build(BuildContext context) {
    if(widget.types==null) return SizedBox.shrink();

    return Container(
      margin: EdgeInsets.only(top:8.px, bottom: 10.px),
      padding: EdgeInsets.only(left:8.px, right:8.px),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        itemCount: widget.types.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 8.px,
          mainAxisSpacing: 8.px,
          childAspectRatio: 2
        ), 
        itemBuilder: (BuildContext context, int index) {
          return _typeItem(widget.types[index]);
        }
      ),
    );
  } 

  Widget _typeItem(StoreTypeModel type) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: Color(0XFFEEF0F3),
          borderRadius: BorderRadius.all(Radius.circular(4.px)),
        ),
        alignment: Alignment.center,
        child: Text(
          type.name!,
          style: TextStyle(
            fontSize: 12.px,
            color: Colors.black87
          ),
        ),
      ),
      onTap: () {
        widget.onTap(type.storeType!);
      },
    );
  }
}