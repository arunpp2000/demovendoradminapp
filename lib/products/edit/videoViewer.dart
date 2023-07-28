
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
class VideoViewer extends StatefulWidget {
  final String? video;
   VideoViewer( {Key? key, required this.video}) : super(key: key);

  @override
  _VideoViewerState createState() => _VideoViewerState();
}

class _VideoViewerState extends State<VideoViewer> {
 late FlickManager flickManager;
  @override
  void initState() {
    print('ppppppppppppppp');
    print(widget.video);

    super.initState();
    flickManager = FlickManager(
      videoPlayerController:
      VideoPlayerController.network(widget.video.toString()),
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 500,
      child: FlickVideoPlayer(
          flickManager: flickManager
      ),
    );
  }
}