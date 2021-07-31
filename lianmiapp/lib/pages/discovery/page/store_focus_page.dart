import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/discovery/widgets/discovery_list_item.dart';
import 'package:lianmiapp/provider/store_focus_provider.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

class StoreFocusPage extends StatefulWidget {
  @override
  _StoreFocusPageState createState() => _StoreFocusPageState();
}

class _StoreFocusPageState extends State<StoreFocusPage> {
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance!.addPostFrameCallback((tim) {
      if (Provider.of<StoreFocusProvider>(context, listen: false)
              .storeFocus
              .length ==
          0) {
        Provider.of<StoreFocusProvider>(context, listen: false)
            .updateAllFocusStore();
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyCustomAppBar(
          centerTitle: '我的关注',
        ),
        backgroundColor: Color(0XFFF4F5F6),
        body: SafeArea(
            child: Container(
          width: double.infinity,
          child: _contentArea(),
        )));
  }

  Widget _contentArea() {
    return Consumer<StoreFocusProvider>(builder: (context, provider, child) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: provider.storeFocus.length,
        itemBuilder: (BuildContext context, int index) {
          StoreInfo model = provider.storeFocus[index];
          return Container(
              width: double.infinity,
              child: Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: DiscoveryListItem(model),
                  secondaryActions: <Widget>[
                    IconSlideAction(
                        caption: '取消关注',
                        color: Color(0XFFE5635C),
                        iconWidget: const SizedBox(),
                        onTap: () {
                          provider.unFocusStore(model.userName!);
                        }),
                  ]));
        },
      );
    });
  }
}
