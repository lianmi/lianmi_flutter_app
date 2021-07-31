import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/lottery/model/shuang_se_qiu/shuang_se_qiu_model.dart';
import 'package:lianmiapp/pages/lottery/provider/shuang_se_qiu_provider.dart';
import 'package:lianmiapp/pages/lottery/utils/ssq_calculate_utils.dart';
import 'package:lianmiapp/pages/lottery/widget/common/circle_button.dart';

class SSQDantuoListItem extends StatelessWidget {
  final List<ShuangseqiuModel> list;

  final Color? color;

  final Color? ballBorderColor;

  final bool showDelete;

  SSQDantuoListItem(this.list, {this.color, this.ballBorderColor, this.showDelete = true});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    list.forEach((element) {
      children.add(
        _oneLine(element)
      );
    });

    int count = 1;
    ShuangseqiuModel model = list.first;
    count = SSQCalculateUtils.calculateDantuo(model.danBalls!.length, model.redBalls!.length, model.blueBalls!.length);

    children.add(
      _titleWidget('${count}注')
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
      secondaryActions:showDelete?<Widget>[
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

  Widget _oneLine(ShuangseqiuModel model) {
    List<Widget> redDanChildren = [];
    model.danBalls!.forEach((element) {
      redDanChildren.add(
        CircleButton(
          '$element',
          color: Colors.white,
          borderColor: ballBorderColor??Colors.transparent,
          fontSize: 16.px,
          textColor: Color(0XFFFF4400),
        )
      );
    });
    List<Widget> redTuoChildren = [];
    model.redBalls!.forEach((element) {
      redTuoChildren.add(
        CircleButton(
          '$element',
          color: Colors.white,
          borderColor: ballBorderColor??Colors.transparent,
          fontSize: 16.px,
          textColor: Color(0XFFFF4400),
        )
      );
    });
    List<Widget> blueChildren = [];
    model.blueBalls!.forEach((element) {
      blueChildren.add(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _titleWidget('红球-胆'),
          _buildGrid(redDanChildren),
          _titleWidget('红球-拖'),
          _buildGrid(redTuoChildren),
          _titleWidget('蓝球'),
          _buildGrid(blueChildren),
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