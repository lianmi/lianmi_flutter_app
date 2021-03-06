import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lianmiapp/res/resources.dart';
import 'package:lianmiapp/util/image_utils.dart';
import 'package:lianmiapp/util/theme_utils.dart';
import 'package:lianmiapp/util/toast.dart';
import 'package:image_picker/image_picker.dart';

class SelectedImage extends StatefulWidget {
  const SelectedImage({
    Key? key,
    this.size = 80.0,
  }) : super(key: key);

  final double size;

  @override
  SelectedImageState createState() => SelectedImageState();
}

class SelectedImageState extends State<SelectedImage> {
  File? imageFile;
  final ImagePicker picker = ImagePicker();

  Future<void> _getImage() async {
    try {
      final PickedFile? pickedFile =
          await picker.getImage(source: ImageSource.gallery, maxWidth: 800);
      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      Toast.show('没有权限，无法打开相册！');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '选择图片',
      hint: '跳转相册选择图片',
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
        onTap: _getImage,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            // 图片圆角展示
            borderRadius: BorderRadius.circular(16.0),
            image: DecorationImage(
                image: imageFile == null
                    ? ImageUtils.getAssetImage('store/icon_zj')
                    : FileImage(imageFile!),
                fit: BoxFit.cover,
                colorFilter: imageFile == null
                    ? ColorFilter.mode(
                        ThemeUtils.getDarkColor(
                            context, Colours.dark_unselected_item_color)!,
                        BlendMode.srcIn)
                    : null),
          ),
        ),
      ),
    );
  }
}
