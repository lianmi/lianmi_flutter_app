import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/order/page/order_search_page.dart';
import 'package:lianmiapp/res/view_standard.dart';

class OrderTypeWidget extends StatefulWidget {
  final List<String> icons;

  final List<String> titles;

  final Function(int) onTap;

  OrderTypeWidget({required this.icons, required this.titles, required this.onTap});

  @override
  _OrderTypeWidgetState createState() => _OrderTypeWidgetState();
}

class _OrderTypeWidgetState extends State<OrderTypeWidget> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 143.px,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(16.px, 10.px, 16.px, 0),
              width: 375.px,
              height: 117.px,
              color: Colours.app_main,
              alignment: Alignment.topCenter,
              child: Container(
                width: double.infinity,
                height: 70.px,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gaps.hGap16,
                    CommonText(
                      '订单',
                      fontSize: 20.px,
                      color: Colors.white,
                    ),
                    InkWell(
                      onTap: () {
                        AppNavigator.push(context, OrderSearchPage());
                      },
                      child: Container(
                        width: 24.px,
                        height: 24.px,
                        alignment: Alignment.center,
                        child: Image.asset(
                          ImageStandard.imConversationTopSearch,
                          width: 24.px,
                          height: 24.px,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              padding: ViewStandard.padding,
              width: 375.px,
              height: 72.px,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(4.px)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0XFFEEEEEE),
                      offset: Offset(0.0, 2.px),
                      blurRadius: 2.px,
                      spreadRadius: 0
                    )
                  ]
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.titles.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        widget.onTap(index);
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      child: Container(
                        width: (375.px - 32.px)/widget.titles.length,
                        height: double.infinity,
                        child: Stack(
                          children: [
                            Positioned(
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      widget.icons[index],
                                      width: 24.px,
                                      height: 24.px,
                                    ),
                                    SizedBox(height: 6.px),
                                    CommonText(
                                      widget.titles[index],
                                      fontSize: 14.px,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                width: (375.px - 32.px)/widget.titles.length,
                                height: 3.px,
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: ((375.px - 32.px)/widget.titles.length - 30.px).px,
                                  height: 3.px,
                                  decoration: BoxDecoration(
                                    color: _currentIndex == index?Colours.app_main:Colors.transparent,
                                    borderRadius: BorderRadius.all(Radius.circular(1.5.px))
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        
                      ),
                    );
                  },
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}