// import 'dart:io';
// import 'dart:ui';
// import 'package:chewie/chewie.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:lianmiapp/header/common_header.dart';

// class VideoPlayPage extends StatefulWidget {
//   ///本地路径
//   final String? localUrl;
//   ///远程路径
//   final String? remoteUrl;
//   VideoPlayPage({this.localUrl, this.remoteUrl});

//   @override
//   _VideoPlayPageState createState() => _VideoPlayPageState();
// }

// class _VideoPlayPageState extends State<VideoPlayPage> {
//   late VideoPlayerController _videoPlayerController;
//   late ChewieController _chewieController;

//   @override
//   void initState() {
//     super.initState();
//     initializePlayer();
//   }

//   Future<void> initializePlayer() async {
//     if(widget.localUrl!=null && _isFileExist(widget.localUrl!)) {
//       _videoPlayerController = VideoPlayerController.file(File(widget.localUrl!));
//     } else {
//       _videoPlayerController = VideoPlayerController.network(widget.remoteUrl!);
//     }
//     await _videoPlayerController.initialize();
//     _chewieController = ChewieController(
//       videoPlayerController: _videoPlayerController,
//       autoPlay: true,
//       looping: false,
//       // fullScreenByDefault: true,
//       allowFullScreen: false
//     );
//     setState(() {
//     });
//     // Future.delayed(Duration(milliseconds: 100), (){
//     //   _chewieController.enterFullScreen();
//     // });

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Container(
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 Expanded(
//                   child: Center(
//                     child: _chewieController != null && _chewieController.videoPlayerController.value.isInitialized
//                       ? Chewie(
//                           controller: _chewieController,
//                         )
//                       : Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: const [
//                             CircularProgressIndicator(),
//                             SizedBox(height: 20),
//                             Text('加载中...'),
//                           ],
//                         ),
//                   ),
//                 ),
//               ],
//             ),
//             Positioned(
//               child: Container(
//                 margin: EdgeInsets.only(top:MediaQueryData.fromWindow(window).padding.top, right: 8.px),
//                 width: 375.px,
//                 height: 40.px,
//                 alignment: Alignment.centerRight,
//                 child: InkWell(
//                   child: Container(
//                     width: 40.px,
//                     height: 40.px,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.all(Radius.circular(20.px)),
//                       border: Border.all(color: Colors.white, width: 1)
//                     ),
//                     child: Icon(Icons.close,color: Colors.white),
//                   ),
//                   onTap: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               )
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   static bool _isFileExist(String path) {
//     if(path==null || path.length == 0) {
//       return false;
//     }
//     File file = File(path);
//     return file.existsSync();
//   }

//   void dispose() {
//     _videoPlayerController.dispose();
//     _chewieController.dispose();
//     super.dispose();
//   }
// }