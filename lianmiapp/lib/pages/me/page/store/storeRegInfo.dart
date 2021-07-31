import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class storeRegInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // throw UnimplementedError();
    return storeRegInfoState();
  }
}

class storeRegInfoState extends State<storeRegInfoPage> {
  final TextEditingController _ctrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  FocusNode _fnText = FocusNode();

  Function vali_holder = (value) {
    if (value.isEmpty) {
      return '法人不能为空';
    }
  };

  final TextEditingController _ctrlCardNo = TextEditingController();
  Function vali_cardNo = (value) {
    // RegExp mobile = new RegExp(r"\d{16}$|\d{17}$|\d{18}$|\d{19}$");
    if (value.isEmpty) {
      return '身份证不能为空';
    }
  };
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          // brightness: Brightness.dark,
          // appBarTheme: AppBarTheme(),
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
              title: Text('申请商户的资料填写', style: TextStyle(color: Color(0xff333333))),
              centerTitle: true,
              actions: [],
              elevation: 0,
            ),
            body: SingleChildScrollView(child: _body())));
  }

  Widget _body() {
    return SizedBox();
  }
}
