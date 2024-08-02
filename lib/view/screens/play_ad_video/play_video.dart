import 'package:flutter/material.dart';
import 'package:game_of_fortune/core/constants/instances_constants.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';


/// Stateful widget to fetch and then display video content.
class VideoApp extends StatefulWidget {

   VideoApp({super.key});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
        '${adVideo}'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
        _controller.play();
      })..addListener((){
       if( _controller.value.isCompleted){
         Get.back();
       }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        )
            : Container(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}