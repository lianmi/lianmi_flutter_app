import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lianmiapp/res/resources.dart';
import 'package:lianmiapp/util/app.dart';
import 'package:lianmiapp/util/theme_utils.dart';

/// 自定义AppBar
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar(
      {Key? key,
      this.backgroundColor,
      this.title = '',
      this.centerTitle = '',
      this.actionName = '',
      this.backImg = 'assets/images/ic_back_black.png',
      this.onPressed,
      this.isBack = true})
      : super(key: key);

  final Color? backgroundColor;
  final String title;
  final String centerTitle;
  final String backImg;
  final String actionName;
  final VoidCallback? onPressed;
  final bool isBack;

  @override
  Widget build(BuildContext context) {
    Color _backgroundColor;

    if (backgroundColor == null) {
      _backgroundColor = context.backgroundColor;
    } else {
      _backgroundColor = backgroundColor!;
    }

    final SystemUiOverlayStyle _overlayStyle =
        ThemeData.estimateBrightnessForColor(_backgroundColor) ==
                Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark;

    final Widget back = isBack
        ? IconButton(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              Navigator.maybePop(context);
            },
            tooltip: 'Back',
            padding: const EdgeInsets.all(12.0),
            icon: Image.asset(
              backImg,
              color: ThemeUtils.getIconColor(context),
            ),
          )
        : Gaps.empty;

    final Widget action = actionName.isNotEmpty
        ? Positioned(
            right: 0.0,
            child: Theme(
              data: Theme.of(context).copyWith(
                buttonTheme: const ButtonThemeData(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  minWidth: 60.0,
                ),
              ),
              child: FlatButton(
                child: Text(actionName, key: const Key('actionName')),
                textColor: context.isDark ? Colours.dark_text : Colours.text,
                highlightColor: Colors.transparent,
                onPressed: onPressed,
              ),
            ),
          )
        : Gaps.empty;

    final Widget titleWidget = Semantics(
      namesRoute: true,
      header: true,
      child: Container(
        alignment:
            centerTitle.isEmpty ? Alignment.centerLeft : Alignment.center,
        width: double.infinity,
        child: Text(
          title.isEmpty ? centerTitle : title,
          style: const TextStyle(
            fontSize: Dimens.font_sp18,
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 48.0),
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      child: Material(
        color: _backgroundColor,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              titleWidget,
              back,
              action,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48.0);
}


/// 自定义AppBar
class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const MyCustomAppBar(
      {Key? key,
      this.backgroundColor = Colours.app_main,
      this.title = '',
      this.centerTitle = '',
      this.backImg = 'assets/images/ic_back_black.png',
      this.isShowBack = true,
      this.actions})
      : super(key: key);

  final Color backgroundColor;
  final String title;
  final String centerTitle;
  final String backImg;
  final bool isShowBack;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final Widget back = isShowBack
        ? IconButton(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              Navigator.maybePop(context);
            },
            tooltip: 'Back',
            icon: Icon(
              Icons.arrow_back_ios,
              color: isShowBack?Colors.black:Colors.white,
            ),
          )
        : Gaps.empty;

    final Widget titleWidget = Text(
      title.isEmpty ? centerTitle : title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: Dimens.font_sp20,
        color: isShowBack?Colors.black:Colors.white
      ),
    );

    return AppBar(
      title: titleWidget,
      centerTitle: true,
      leading: back,
      actions: actions??[],
      backgroundColor: isShowBack?Colors.white:null,
      brightness: isShowBack?Brightness.light:Brightness.dark
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48.0);
}
