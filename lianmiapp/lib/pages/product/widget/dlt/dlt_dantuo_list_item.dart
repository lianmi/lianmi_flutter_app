import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/product/model/dlt/dlt_model.dart';
import 'package:lianmiapp/pages/product/provider/dlt_provider.dart';
import 'package:lianmiapp/pages/product/utils/daletou_calculate_utils.dart';
import 'package:lianmiapp/pages/product/widget/common/circle_button.dart';

class DltDantuoListItem extends StatelessWidget {
  final List<DltModel> list;

  final Color? color;

  final Color? ballBorderColor;

  final bool? showDelete;

  DltDantuoListItem(this.list,
      {this.color, this.ballBorderColor, this.showDelete = true});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    list.forEach((element) {
      children.add(_oneLine(element));
    });

    int count = 1;
    DltModel model = list.first;
    count = DLTCalculateUtils.calculateDantuo(model.danBalls!.length,
        model.frontBalls!.length, model.backBalls!.length);

    children.add(_titleWidget('${count}注'));

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
        secondaryActions: showDelete!
            ? <Widget>[
                IconSlideAction(
                    caption: '删除',
                    color: Color(0XFFE5635C),
                    iconWidget: const SizedBox(),
                    onTap: () {
                      Provider.of<DltProvider>(context, listen: false)
                          .deleteLotterys(list);
                    }),
              ]
            : []);
  }

  Widget _titleWidget(String title) {
    return Container(
      width: double.infinity,
      height: 20.px,
      alignment: Alignment.topLeft,
      child: CommonText(
        title,
        fontSize: 12.px,
        color: Color(0XFF666666),
      ),
    );
  }

  Widget _oneLine(DltModel model) {
    List<Widget> frontDanChildren = [];
    model.danBalls!.forEach((element) {
      frontDanChildren.add(CircleButton(
        '$element',
        color: Colors.white,
        borderColor: ballBorderColor ?? Colors.transparent,
        fontSize: 16.px,
        textColor: Color(0XFFFF4400),
      ));
    });
    List<Widget> frontTuoChildren = [];
    model.frontBalls!.forEach((element) {
      frontTuoChildren.add(CircleButton(
        '$element',
        color: Colors.white,
        borderColor: ballBorderColor ?? Colors.transparent,
        fontSize: 16.px,
        textColor: Color(0XFFFF4400),
      ));
    });
    List<Widget> backChildren = [];
    model.backBalls!.forEach((element) {
      backChildren.add(CircleButton(
        '$element',
        color: Colors.white,
        borderColor: ballBorderColor ?? Colors.transparent,
        fontSize: 16.px,
        textColor: Color(0XFF4289F5),
      ));
    });

    return Container(
      width: 375.px,
      margin: EdgeInsets.only(bottom: 10.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleWidget('前区-胆'),
          _buildGrid(frontDanChildren),
          _titleWidget('前区-拖'),
          _buildGrid(frontTuoChildren),
          _titleWidget('后区'),
          _buildGrid(backChildren),
        ],
      ),
    );
  }

  Widget _buildGrid(List<Widget> children) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      itemCount: children.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          crossAxisSpacing: 16.px,
          mainAxisSpacing: 8.px,
          childAspectRatio: 1),
      itemBuilder: (BuildContext context, int index) {
        return children[index];
      },
    );
  }
}
