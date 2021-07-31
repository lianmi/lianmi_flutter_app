import 'package:lianmiapp/header/common_header.dart';

class ActtionItem extends StatelessWidget {
  final String title;

  final String content;

  final Function? onTap;

  ActtionItem({
    required this.title,
    required this.content,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54.px,
      child: Row( 
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 80,
            child: Text(title,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff888888),
              )
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                if (onTap != null) onTap!();
              },
              child: Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.centerLeft,
                child: CommonText(
                  content,
                  fontSize: 14,
                  color: Colors.black,
                )
              ),
            )
          )
        ]
      )
    );
  }
}