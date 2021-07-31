import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  T viewmodel;

  Widget? child;

  Function(BuildContext, T, Widget) builder;

  Function(T model)? load;

  ProviderWidget(
      {required this.viewmodel,
        this.child,
        required this.builder,
        this.load,
        Key? key})
      : super(key: key);

  @override
  _ProviderWidgetState createState() => _ProviderWidgetState<T>();
}

class _ProviderWidgetState<T extends ChangeNotifier>
    extends State<ProviderWidget<T>> {
  @override
  void initState() {
    super.initState();
    // 控件初始化
    if (widget.load != null) {
      widget.load!(widget.viewmodel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => widget.viewmodel,
        child: Consumer<T>(
          builder: (context, value, child) =>
              widget.builder(context, value, child??SizedBox()) as Widget,
          child: widget.child,
        ));
  }
}