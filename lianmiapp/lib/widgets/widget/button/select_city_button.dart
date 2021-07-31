// import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lianmiapp/res/styles.dart';

class SelectCityButton extends StatefulWidget {
  String title;
  Function select;
  SelectCityButton(this.title, this.select);
  _SelectCityButtonState createState() => _SelectCityButtonState();
}

class _SelectCityButtonState extends State<SelectCityButton> {
  String _city_str = '';
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          color: Colors.transparent,
          alignment: Alignment.centerLeft,
          child: Text(
            '${widget.title}:' + _city_str,
            style: TextStyles.font14(),
          )),
      onTap: () {
        onTap();
      },
    );
  }

  void onTap() async {
    // Result result = await CityPickers.showCityPicker(
    //     context: context,
    //     showType: ShowType.pca
    // );
    // setState(() {
    //   _city_str = result.provinceName
    //       + ' ' + result.cityName
    //       + ' ' + result.areaName;
    // });
    // widget.select(_city_str);
  }
}
