import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerScreen({super.key, required this.videoUrl});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;
  bool _isVideoPlaying = false;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _isVideoInitialized = true;
          _videoController.play();
          _isVideoPlaying = true;
        });
      });

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    _videoController.addListener(_videoListener);
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.removeListener(_videoListener);
    _videoController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }

  void _videoListener() {
    if (_videoController.value.position == _videoController.value.duration) {
      setState(() {
        _isVideoPlaying = false;
      });
    }
  }

  void _toggleVideoPlayback() {
    setState(() {
      if (_isVideoPlaying) {
        _videoController.pause();
        _isVideoPlaying = false;
      } else {
        _videoController.play();
        _isVideoPlaying = true;
      }
    });
  }

  void _stopVideoPlayback() {
    setState(() {
      _videoController.pause();
      _videoController.seekTo(Duration.zero);
      _isVideoPlaying = false;
    });
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
      if (_isFullScreen) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
        SystemChrome.setPreferredOrientations(
            [DeviceOrientation.landscapeLeft]);
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isFullScreen
          ? null
          : AppBar(
              title: const Text('Video Player'),
            ),
      body: Stack(
        children: [
          Center(
            child: _isVideoInitialized
                ? AspectRatio(
                    aspectRatio: _videoController.value.aspectRatio,
                    child: VideoPlayer(_videoController),
                  )
                : const CircularProgressIndicator(),
          ),
        ],
      ),
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: IconButton(
              icon: Icon(_isVideoPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: _toggleVideoPlayback,
            ),
          ),
          Expanded(
            child: IconButton(
              icon: const Icon(Icons.stop),
              onPressed: _stopVideoPlayback,
            ),
          ),
          Expanded(
            child: IconButton(
              icon: Icon(
                  _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen),
              onPressed: _toggleFullScreen,
            ),
          ),
        ],
      ),
    );
  }
}
