import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/lottery/model/ball_num_model.dart';
import 'package:lianmiapp/pages/lottery/model/lottery_product_model.dart';
import 'package:lianmiapp/pages/lottery/model/shuang_se_qiu/shuang_se_qiu_model.dart';
import 'package:lianmiapp/pages/lottery/provider/shuang_se_qiu_provider.dart';
import 'package:lianmiapp/pages/lottery/utils/lottery_data.dart';
import 'package:lianmiapp/pages/lottery/widget/common/circle_button.dart';
import 'package:lianmiapp/res/view_standard.dart';

class SSQDanshiListItem extends StatelessWidget {
  final List<ShuangseqiuModel> list;

  final Color? color;

  final Color? ballBorderColor;

  final bool showDelete;

  SSQDanshiListItem(this.list,{this.color, this.ballBorderColor, this.showDelete = true});

  @override
  Widget build(BuildContext context) {

    List<Widget> children = [];
    list.forEach((element) {
      children.add(
        _oneLine(element)
      );
    });

    children.add(
      Container(
        width: double.infinity,
        height: 20.px,
        alignment: Alignment.topLeft,
        child: CommonText(
          '${list.length}注',
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
            Provider.of<ShuangseqiuProvider>(context, listen: false).deleteLotterys(list);
          }
        ),
      ]:[]
    );
  }

  Widget _oneLine(ShuangseqiuModel model) {
    List<Widget> children = [];
    model.redBalls!.forEach((element) {
      children.add(
        CircleButton(
          '$element',
          color: Colors.white,
          borderColor: ballBorderColor??Colors.transparent,
          fontSize: 16.px,
          textColor: Color(0XFFFF4400),
        )
      );
    });
    model.blueBalls!.forEach((element) {
      children.add(
        CircleButton(
          '$element',
          color: Colors.white,
          borderColor: ballBorderColor??Colors.transparent,
          fontSize: 16.px,
          textColor: Color(0XFF4289F5),
        )
      );
    });

    return Container(
      width: 375.px,
      margin: EdgeInsets.only(bottom: 10.px),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        itemCount: 7,
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
      )
    );
  }
}