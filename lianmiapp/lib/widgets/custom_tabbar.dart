import 'package:flutter/material.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'package:lianmiapp/util/adapt.dart';
import 'package:lianmiapp/provider/main_tabbar_index_provider.dart';

class CustomTabbbar extends StatefulWidget {
  final double width;

  final double height;

  final String title;

//  final bool isSelected;
  final int index;

  final AssetImage defaultImage;

  final AssetImage selectedImage;

  final Color defaultColor;

  final Color selectedColor;

  final bool showRed;

  final Function? onTap;

  CustomTabbbar(
      this.width,
      this.height,
      this.title,
      this.index,
      this.defaultImage,
      this.selectedImage,
      this.defaultColor,
      this.selectedColor,
      {this.onTap,
      this.showRed = false});

  @override
  _CustomTabbbarState createState() => _CustomTabbbarState();
}

class _CustomTabbbarState extends State<CustomTabbbar> {
  Duration duration = Duration(milliseconds: 250);
  initState() {
    super.initState();
    // logD('更新2');
  }

  Widget build(BuildContext context) {
    // print('更新');
    return GestureDetector(
      onTap: () {
        if (widget.onTap != null) widget.onTap!();
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: Consumer<MainTabbarIndexProvider>(
                  builder: (context, main, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimatedSwitcher(
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                                child: child, scale: animation);
                          },
                          reverseDuration: duration,
                          duration: duration,
                          child: main.index == widget.index
                              ? _img(widget.selectedImage)
                              : _img(widget.defaultImage),
                        ),
                        Text(
                          widget.title,
                          style: TextStyle(
                              fontSize: 10.px,
                              color: widget.index == main.index
                                  ? widget.selectedColor
                                  : Colors.black),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
            Visibility(
                visible: widget.showRed,
                child: Positioned(
                  top: 7.px,
                  left: widget.width / 2 + 8.px,
                  child: Container(
                    width: 8.px,
                    height: 8.px,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(4.px)),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget _img(AssetImage url) {
    return Image(
      key: ValueKey<String>(url.assetName),
      image: url,
      width: 30.px,
      height: 30.px,
    );
  }
}
