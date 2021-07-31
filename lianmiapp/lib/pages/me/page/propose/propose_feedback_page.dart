import 'package:lianmiapp/header/common_header.dart';
import 'package:lianmiapp/pages/me/page/propose/propose_widget.dart';
import 'package:lianmiapp/pages/me/provider/propose_feedback_provider.dart';
import 'package:lianmiapp/widgets/widget/button/common_button.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';

class ProposeFeedbackPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return storeCenterState();
  }
}

class storeCenterState extends State<ProposeFeedbackPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          backgroundColor: Colors.white,
        ),
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  Navigator.of(context, rootNavigator: true)
                      .popUntil(ModalRoute.withName('/'));
                },
                tooltip: 'Back',
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xff333333),
                ),
              ),
              backgroundColor: Colors.white,
              title: Text('建议和反馈', style: TextStyle(color: Color(0xff333333))),
              centerTitle: true,
              actions: [],
              elevation: 0,
            ),
            body: SingleChildScrollView(child: _body())));
  }

  Widget _body() {
    return Form(
        child: Container(
            color: Color(0xffF3F6F9),
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [_contentWiget(), _bottomWidget()],
                  ),
                ),
              ],
            )));
  }

  Widget _contentWiget() {
    return ProposeFeedbackWidget();
  }

  Widget _bottomWidget() {
    return _twoBottom(
        nextTitle: '提交',
        onTapLast: () {
          setState(() {
            // _showPageIndex = 0;
          });
        },
        onTapNext: () {
          _submit();
        });
  }

  Widget _twoBottom(
      {required String nextTitle,
      required Function onTapLast,
      required Function onTapNext}) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.px, 12.px, 16.px, 12.px),
      width: double.infinity,
      height: 64.px,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: CommonButton(
              width: double.infinity,
              height: double.infinity,
              borderRadius: 4.px,
              color: Colours.app_main,
              text: nextTitle,
              fontSize: 16.px,
              textColor: Colors.white,
              boxShadow: BoxShadow(
                  color: Color(0XFFFF4400),
                  offset: Offset(0.0, 0.0),
                  blurRadius: 4.px,
                  spreadRadius: 0),
              onTap: () {
                onTapNext();
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _submit() {
    Provider.of<ProposeFeedbackProvider>(App.context!, listen: false).submit();
  }
}
