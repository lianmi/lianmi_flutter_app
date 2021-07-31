import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/lottery/model/pl3/pl3_model.dart';
import 'package:lianmiapp/pages/lottery/provider/pl3_provider.dart';
import 'package:lianmiapp/pages/lottery/utils/pailie3_calculate_utils.dart';
import 'package:lianmiapp/pages/lottery/widget/common/circle_button.dart';

class Pl3FushiListItem extends StatelessWidget {
  final List<Pl3Model> list;

  final Color? color;

  final Color? ballBorderColor;

  final bool showDelete;

  Pl3FushiListItem(this.list,{this.color, this.ballBorderColor, this.showDelete = true});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    list.forEach((element) {
      children.add(
        _oneLine(element)
      );
    });

    int count = 1;
    Pl3Model model = list.first;
    count = PaiLie3CalculateUtils.calculateMultiple(model.geBalls!.length, model.shiBalls!.length, model.baiBalls!.length);

    children.add(
      Container(
        width: double.infinity,
        height: 20.px,
        alignment: Alignment.topLeft,
        child: CommonText(
          '${count}注',
          fontSize: 12.px,
          color: Color(0XFF666666),
        ),
      )
    );

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        padding: EdgeInsets.all(16.px),
        width: 375.px,
        color: color??Color(0XFFF4F5F6),
        child: Column(
          children: children,
        ),
      ),
      secondaryActions: showDelete?<Widget>[
        IconSlideAction(
          caption: '删除',
          color: Color(0XFFE5635C),
          iconWidget: const SizedBox(),
          onTap: (){
            Provider.of<Pl3Provider>(context, listen: false).deleteLotterys(list);
          }
        ),
      ]:[]
    );
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

  Widget _oneLine(Pl3Model model) {
    List<Widget> geChildren = [];
    model.geBalls!.forEach((element) {
      geChildren.add(
        CircleButton(
          '$element',
          color: Colors.white,
          borderColor: ballBorderColor??Colors.transparent,
          fontSize: 16.px,
          textColor: Colours.app_main
        )
      );
    });
    List<Widget> shiChildren = [];
    model.shiBalls!.forEach((element) {
      shiChildren.add(
        CircleButton(
          '$element',
          color: Colors.white,
          borderColor: ballBorderColor??Colors.transparent,
          fontSize: 16.px,
          textColor: Colours.app_main,
        )
      );
    });
    List<Widget> baiChildren = [];
    model.baiBalls!.forEach((element) {
      baiChildren.add(
        CircleButton(
          '$element',
          color: Colors.white,
          borderColor: ballBorderColor??Colors.transparent,
          fontSize: 16.px,
          textColor: Colours.app_main,
        )
      );
    });

    return Container(
      width: 375.px,
      margin: EdgeInsets.only(bottom: 10.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleWidget('个位'),
          _buildGrid(geChildren),
          _titleWidget('十位'),
          _buildGrid(shiChildren),
          _titleWidget('百位'),
          _buildGrid(baiChildren),
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
        childAspectRatio: 1
      ), 
      itemBuilder: (BuildContext context, int index) {
        return children[index];
      },
    );
  }
}