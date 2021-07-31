import 'package:lianmiapp/header/common_header.dart';

class ProductDetailBottom extends StatelessWidget {
  final VoidCallback onTapChat;

  final VoidCallback onTapBuy;

  ProductDetailBottom({Key? key, required this.onTapChat, required this.onTapBuy}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.px,
      height: 55.px,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Container(
              //   margin: EdgeInsets.only(left:15.px),
              //   width: 50.px,
              //   height: double.infinity,
              //   child: Stack(
              //     children: [
              //       InkWell(
              //         child: Container(
              //           width: double.infinity,
              //           height: double.infinity,
              //           alignment: Alignment.center,
              //           child: Image.asset(
              //             ImageStandard.discoveryIconGouwuche,
              //             width: 40.px,
              //             height: 40.px,
              //           ),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              InkWell(
                child: Container(
                  margin: EdgeInsets.only(left: 16.px),
                  width: 50,
                  height: double.infinity,
                  alignment: Alignment.center,
                  child: Image.asset(
                    ImageStandard.discoveryIconLiaotian,
                    width: 40.px,
                    height: 40.px,
                  ),
                ),
                onTap: () {
                  if(onTapChat != null) onTapChat();
                },
              ),
            ],
          ),
          InkWell(
            onTap: () {
              if(onTapBuy != null) {
                onTapBuy();
              }
            },
            child: Container(
              margin: EdgeInsets.only(right:25.px),
              width: 160.px,
              height: 40.px,
              decoration: BoxDecoration(
                color: Colours.app_main,
                borderRadius: BorderRadius.all(Radius.circular(20.px)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   ImageStandard.discoveryIconJiahao,
                  //   width: 20.px,
                  //   height: 20.px,
                  // ),
                  // Padding(padding: EdgeInsets.only(right:8.px)),
                  Text(
                    // '加入购物车',
                    '购买',
                    style: TextStyle(
                      fontSize: 15.px,
                      color: Colors.white
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}