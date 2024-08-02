import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;

  VideoPlayerScreen({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
  }

  void _initializeVideoPlayer() async {
    try {
      
      _videoPlayerController = VideoPlayerController.network(widget.videoUrl);

      
      await _videoPlayerController.initialize();

      
      if (mounted) {
        setState(() {
          _chewieController = ChewieController(
            videoPlayerController: _videoPlayerController,
            aspectRatio: 16 / 9,
            autoInitialize: true,
            autoPlay: true, 
            looping: false,
            allowFullScreen: true,
            materialProgressColors: ChewieProgressColors(
              playedColor: Colors.red,
              handleColor: Colors.redAccent,
              backgroundColor: Colors.grey,
              bufferedColor: Colors.lightGreen,
            ),
            placeholder: Center(
              child: CircularProgressIndicator(),
            ),
            errorBuilder: (context, errorMessage) {
              return Center(
                child: Text(
                  'Failed to load video: $errorMessage',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          );
        });
      }
    } catch (error) {
      setState(() {
        _isError = true;
      });
      print('Video Player Error: $error');
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Text(""), 
        actions: [
          IconButton(
            icon: Icon(
              FontAwesomeIcons.windowClose,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: Center(
        child: _isError
            ? Text('Failed to load video')
            : _chewieController != null &&
                _chewieController!.videoPlayerController.value.isInitialized
            ? Chewie(
                controller: _chewieController!,
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
