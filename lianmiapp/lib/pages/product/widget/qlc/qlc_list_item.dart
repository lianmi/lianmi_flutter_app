import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/product/model/qlc/qlc_model.dart';
import 'package:lianmiapp/pages/product/provider/qlc_provider.dart';
import 'package:lianmiapp/pages/product/utils/qilecai_calculate_utils.dart';
import 'package:lianmiapp/pages/product/widget/common/circle_button.dart';

class QlcListItem extends StatelessWidget {
  final List<QlcModel> list;

  final Color? color;

  final Color? ballBorderColor;

  final bool showDelete;

  QlcListItem(this.list,
      {this.color, this.ballBorderColor, this.showDelete = true});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    list.forEach((element) {
      children.add(_oneLine(element));
    });

    int count = 1;
    QlcModel model = list.first;
    count = QilecaiCalculateUtils.calculateMultiple(model.balls!.length);

    children.add(Container(
      width: double.infinity,
      height: 20.px,
      alignment: Alignment.topLeft,
      child: CommonText(
        '${count}注',
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
                      Provider.of<QlcProvider>(context, listen: false)
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

  Widget _oneLine(QlcModel model) {
    List<Widget> children = [];
    model.balls!.forEach((element) {
      children.add(CircleButton('$element',
          color: Colors.white,
          borderColor: ballBorderColor ?? Colors.transparent,
          fontSize: 16.px,
          textColor: Colours.app_main));
    });

    return Container(
      width: 375.px,
      margin: EdgeInsets.only(bottom: 10.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGrid(children),
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
