import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/widgets/widget/button/common_button.dart';

class TypeChoose {
  static void show(
    {required String title,
     required List<String> list,
     required Function(int) onTap}
  ) {
    double lineHeight = 50.px;
    List<Widget> children = [];
    list.forEach((element) {
      children.add(
        CommonButton(
          width: double.infinity,
          height: 50.px,
          color: Colors.white,
          text: element,
          textColor: Colors.black,
          fontSize: 16.px,
          onTap: () {
            Navigator.of(App.context!).pop();
            onTap(list.indexOf(element));
          },
        )
      );
    });
    showModalBottomSheet(
      context: App.context!,
      builder: (BuildContext context) {
        return Container(
            height: lineHeight * (list.length + 1),
            child: ListView(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: lineHeight,
                alignment: Alignment.center,
                color: Colors.white,
                child: CommonText(
                  title,
                  fontSize: 18.px,
                  color: Colors.black,
                ),
              ),
              ...children
            ],
          )
        );
      }
    );
  }
}