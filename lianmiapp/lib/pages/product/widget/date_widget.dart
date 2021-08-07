import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/product/model/product_model.dart';
import 'package:lianmiapp/pages/product/utils/lottery_data.dart';
import 'package:lianmiapp/res/view_standard.dart';

class DateWidget extends StatelessWidget {
  final ProductModel model;
  final int maxLines;

  DateWidget(this.model, {this.maxLines = 2});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16.px, 8.px, 16.px, 8.px),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colours.line))),
      alignment: Alignment.centerLeft,
      child: CommonText(
        model.productDesc ?? '',
        maxLines: maxLines,
      ),
    );
  }
}
