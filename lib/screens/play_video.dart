import 'package:educatednearby/screens/video_play_widget.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayVideo extends StatefulWidget {
  const PlayVideo({Key key}) : super(key: key);

  @override
  _PlayVideoState createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  // final asset = 'assets/education.mp4';
  VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    // controller = VideoPlayerController.network(
    //     'http://192.248.144.136/video/education_video.mp4')
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     controller.play();
    //     setState(() {});
    //   });


    controller = VideoPlayerController.asset("assets/video/education.mp4");
    controller.addListener(() {
      setState(() {});
    });
    controller.initialize().then((value) {
      controller.play();
      setState(() {});
    });

    print(controller.toString() + "HIIIIII");
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VideoPlayerWidget(
      controller: controller,
    );
  }
}
