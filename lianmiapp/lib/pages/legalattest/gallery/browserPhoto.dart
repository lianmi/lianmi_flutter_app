import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:lianmiapp/pages/legalattest/common/app_bar.dart';
import 'package:lianmiapp/util/app_navigator.dart';
import 'package:lianmiapp/widgets/my_app_bar.dart';
import 'package:linkme_flutter_sdk/manager/LogManager.dart';
import 'package:photo_view/photo_view.dart';

class BrowserPhoto extends StatefulWidget {
  final String locallyPhotoPath;

  BrowserPhoto(this.locallyPhotoPath);

  @override
  _BrowserPhotoState createState() => _BrowserPhotoState();
}

class _BrowserPhotoState extends State<BrowserPhoto> {
  final PhotoViewController _controller = PhotoViewController();
  var _quarterTurns = 0;
  String _locallyPhotoPath = '';

  @override
  void initState() {
    super.initState();
    _locallyPhotoPath = widget.locallyPhotoPath;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(
        centerTitle: '图片预览',
        actions: [],
      ),
      backgroundColor: Color(0XFFF4F5F6),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // const ExampleAppBar(
          //   title: "图片预览",
          //   showGoBack: true,
          // ),
          Expanded(
            child: Column(
              children: <Widget>[
                // Container(
                //   padding: const EdgeInsets.all(20.0),
                //   child: const Text(
                //     "Example without manual rotation, click the button to rotate",
                //     style: const TextStyle(fontSize: 18.0),
                //   ),
                // ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    height: 300.0,
                    child: ClipRect(
                      child: PhotoView(
                        controller: _controller,
                        imageProvider: FileImage(File(widget.locallyPhotoPath)),
                        maxScale: PhotoViewComputedScale.covered,
                        initialScale: PhotoViewComputedScale.contained * 0.8,
                        enableRotation: false,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.rotate_right),
        onPressed: _rotateRight90Degrees,
      ),
    );
  }

  void _rotateRight90Degrees() {
    // Set the rotation to either 0, 90, 180 or 270 degrees (value is in radians)
    _quarterTurns = _quarterTurns == 3 ? 0 : _quarterTurns + 1;
    _controller.rotation = math.pi / 2 * _quarterTurns;
  }

  _erasePhoto() {
    logW('_erasePhoto hit' + _locallyPhotoPath);

    AppNavigator.goBackWithParams(context, {'path': _locallyPhotoPath});
  }
}
