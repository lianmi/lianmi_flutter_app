import 'package:flutter/material.dart';
import 'package:lianmiapp/header/common_header.dart';
import 'package:linkme_flutter_sdk/linkme_flutter_sdk.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:dio/dio.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/cupertino.dart';

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper({
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex,
    @required this.galleryItems,
    this.scrollDirection = Axis.horizontal,
  }) : pageController = PageController(initialPage: initialIndex!);

  final LoadingBuilder? loadingBuilder;
  final BoxDecoration? backgroundDecoration;
  final dynamic? minScale;
  final dynamic? maxScale;
  final int? initialIndex;
  final PageController? pageController;
  final List? galleryItems;
  final Axis? scrollDirection;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  late int currentIndex;

  @override
  void initState() {
    currentIndex = widget.initialIndex ?? 0;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: _buildItem,
              itemCount: widget.galleryItems!.length,
              loadingBuilder: widget.loadingBuilder,
              backgroundDecoration: widget.backgroundDecoration,
              pageController: widget.pageController,
              onPageChanged: onPageChanged,
              scrollDirection: widget.scrollDirection!,
            ),
            Positioned(
              //图片index显示
              top: MediaQuery.of(context).padding.top + 15,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                    "${currentIndex + 1}/${widget.galleryItems!.length}",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
            Positioned(
              //右上角关闭按钮
              right: 10,
              top: MediaQuery.of(context).padding.top,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + 16,
              child: FlatButton(
                child: Text(
                  '保存图片到相册',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                onPressed: () {
                  if (Platform.isIOS) {
                    return _savenNetworkImage();
                  }
                  requestPermission().then((bool) {
                    if (bool) {
                      _savenNetworkImage();
                    }
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

//动态申请权限，ios 要在info.plist 上面添加
  Future<bool> requestPermission() async {
    var status = await Permission.photos.status;
    // if (status.isUndetermined) {
    //   Map<Permission, PermissionStatus> statuses = await [
    //     Permission.photos,
    //   ].request();
    //   print(statuses);
    // }
    return status.isGranted;
  }

  //保存网络图片到本地
  _savenNetworkImage() async {
    var status = await Permission.photos.status;
    logD(status);
    if (status.isDenied) {
      // We didn't ask for permission yet.
      logW('暂无相册权限');
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text('提示'),
              content: Text('您当前没有开启相册权限'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('取消'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                CupertinoDialogAction(
                  child: Text('去启动'),
                  onPressed: () {
                    openAppSettings();
                  },
                ),
              ],
            );
          });

      // showDialog(context: context,builder: (context){
      //   return AlertWidget(title: '微信提示',message: '您当前没有开启相册权限',confirm: '去开启',
      //   confirmCallback: (){
      //   //打开ios的设置
      //     openAppSettings();
      //   },);
      // });

      return;
    }

    EasyLoading.show(status: '加载中...');
    String imgPath = widget.galleryItems![currentIndex].resource;
    if (imgPath.contains('http')) {
      var response = await Dio()
          .get(imgPath, options: Options(responseType: ResponseType.bytes));
      final filePath =
          await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
      logI('网络图片文件: ${filePath.toString()}');
      if (Platform.isIOS) {
        if (filePath != null) {
          HubView.showToastAfterLoadingHubDismiss('保存成功');
        } else {
          HubView.showToastAfterLoadingHubDismiss('保存失败');
        }
      } else {
        if (filePath != null) {
          HubView.showToastAfterLoadingHubDismiss('保存成功');
        } else {
          HubView.showToastAfterLoadingHubDismiss('保存失败');
        }
      }
    } else {
      if (FileManager.instance.isExist(imgPath)) {
        final result = await ImageGallerySaver.saveFile(imgPath);
        logI(result);
        HubView.showToastAfterLoadingHubDismiss('保存成功');
      } else {
        HubView.showToastAfterLoadingHubDismiss('文件不存在');
      }
    }
    EasyLoading.dismiss();
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final GalleryExampleItem item = widget.galleryItems![index];
    return PhotoViewGalleryPageOptions(
      onTapUp: (BuildContext context, TapUpDetails details,
          PhotoViewControllerValue controllerValue) {
        Navigator.of(context).pop();
      },
      imageProvider: (item.resource!.contains('http')
          ? NetworkImage(item.resource!)
          : FileImage(File(item.resource!))) as ImageProvider<Object>?,
//      initialScale: PhotoViewComputedScale.contained,
//      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
//      maxScale: PhotoViewComputedScale.covered * 1.1,

      heroAttributes: PhotoViewHeroAttributes(tag: item.id!),
    );
  }
}

//Hero 动画组件
class GalleryExampleItemThumbnail extends StatelessWidget {
  const GalleryExampleItemThumbnail(
      {Key? key, this.galleryExampleItem, this.onTap})
      : super(key: key);

  final GalleryExampleItem? galleryExampleItem;

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Hero(
          tag: galleryExampleItem!.id!,
          child: Image.network(
            galleryExampleItem!.resource!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

//model
class GalleryExampleItem {
  GalleryExampleItem({this.id, this.resource, this.isSvg = false});
  //hero的id 不能重复
  String? id;
  String? resource;
  bool? isSvg;
}

class GalleryPhotoViewWrapperUtils {
  static void navigateToPhotoAblums(
      BuildContext context, List<String> imgUrls, int index) {
    List imgList = [];
    for (int x = 0; x < imgUrls.length; x++) {
      GalleryExampleItem item = GalleryExampleItem();
      item.id = 'tag${x}';
      item.resource = imgUrls[x];
      imgList.add(item);
    }
    Navigator.of(context).push(FadeRoute(
        page: GalleryPhotoViewWrapper(
      galleryItems: imgList,
      backgroundDecoration: const BoxDecoration(
        color: Colors.black,
      ),
      initialIndex: index,
    )));
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget? page;
  FadeRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page!,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
