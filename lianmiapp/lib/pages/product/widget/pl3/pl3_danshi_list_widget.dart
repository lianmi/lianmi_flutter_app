import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/product/model/pl3/pl3_model.dart';
import 'package:lianmiapp/pages/product/provider/pl3_provider.dart';
import 'package:lianmiapp/pages/product/widget/common/circle_button.dart';

class Pl3DanshiListItem extends StatelessWidget {
  final List<Pl3Model> list;

  final Color? color;

  final Color? ballBorderColor;

  final bool showDelete;

  Pl3DanshiListItem(this.list,
      {this.color, this.ballBorderColor, this.showDelete = true});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    list.forEach((element) {
      children.add(_oneLine(element));
    });

    children.add(Container(
      width: double.infinity,
      height: 20.px,
      alignment: Alignment.topLeft,
      child: CommonText(
        '${list.length}注',
        fontSize: 12.px,
        color: Color(0XFF666666),
      ),
    ));

    return Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          padding: EdgeInsets.all(16.px),
          width: 375.px,
          color: color ?? Color(0XFFF4F5F6),
          child: Column(
            children: children,
          ),
        ),
        secondaryActions: showDelete
            ? <Widget>[
                IconSlideAction(
                    caption: '删除',
                    color: Color(0XFFE5635C),
                    iconWidget: const SizedBox(),
                    onTap: () {
                      Provider.of<Pl3Provider>(context, listen: false)
                          .deleteLotterys(list);
                    }),
              ]
            : []);
  }

  Widget _oneLine(Pl3Model model) {
    return Container(
      width: 375.px,
      margin: EdgeInsets.only(bottom: 10.px),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CommonText(
            '个位:',
            fontSize: 16.px,
            color: Colors.black,
          ),
          Gaps.hGap5,
          CircleButton('${model.geBalls!.first}',
              color: Colors.white,
              borderColor: ballBorderColor ?? Colors.transparent,
              fontSize: 16.px,
              textColor: Colours.app_main),
          Gaps.hGap16,
          CommonText(
            '十位:',
            fontSize: 16.px,
            color: Colors.black,
          ),
          Gaps.hGap5,
          CircleButton('${model.shiBalls!.first}',
              color: Colors.white,
              borderColor: ballBorderColor ?? Colors.transparent,
              fontSize: 16.px,
              textColor: Colours.app_main),
          Gaps.hGap16,
          CommonText(
            '百位:',
            fontSize: 16.px,
            color: Colors.black,
          ),
          Gaps.hGap5,
          CircleButton('${model.baiBalls!.first}',
              color: Colors.white,
              borderColor: ballBorderColor ?? Colors.transparent,
              fontSize: 16.px,
              textColor: Colours.app_main),
        ],
      ),
    );
  }
}
