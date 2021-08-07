import 'package:flutter/material.dart';
import 'package:lianmiapp/header/common_header.dart';

class MultiInputItem extends StatelessWidget {
  final String title;

  final String hintText;

  final String text;

  final int maxline;

  final TextEditingController controller;

  final Function valid;

  final Widget button;

  final Function(String text)? onChange;

  MultiInputItem(
      {required this.title,
      required this.hintText,
      this.text = '',
      this.maxline = 1,
      required this.controller,
      required this.valid,
      required this.button,
      this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            width: 80,
            child: Text(title,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff888888),
                )),
          ),
          _input(hintText, controller, valid),
          button,
        ]));
  }

  Widget _input(
    String hintText,
    TextEditingController _controller,
    Function? _validator,
  ) {
    return Expanded(
        child: TextFormField(
      controller: _controller,
      cursorColor: Colours.app_main,
      decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          hintStyle: TextStyle(fontSize: 14, color: Color(0xFFCCCCCC))),
      style: TextStyle(fontSize: 14, color: Colors.black),
      maxLines: maxline,
      onChanged: onChange,
    ));
  }
}
