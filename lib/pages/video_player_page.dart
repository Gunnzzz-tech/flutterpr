import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerPage({super.key, required this.videoUrl});

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    String? videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    if (videoId != null) {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
    } else {
      throw Exception('Invalid YouTube URL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Never gonna give you up ~")),
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        onReady: () {
          print('Player is ready');
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
