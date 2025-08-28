import 'package:better_player_plus/better_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoWidget extends StatefulWidget {
  final String path;
  final double? aspectRatio;

  const VideoWidget({super.key, required this.path, this.aspectRatio});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late BetterPlayerController controller;

  @override
  void initState() {
    controller = BetterPlayerController(
      BetterPlayerConfiguration(
        autoPlay: true,
        fit: BoxFit.contain,
        aspectRatio: widget.aspectRatio,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enableSubtitles: false,
          enableSkips: false,
          enableRetry: false,
          enableQualities: false,
          enableProgressText: true,
          enablePlaybackSpeed: false,
          enablePip: false,
          enableOverflowMenu: false,
          enableFullscreen: false,
          enableAudioTracks: false,
          controlBarColor: ColorManager.black.withOpacity(.1),
        ),
      ),
      betterPlayerDataSource: BetterPlayerDataSource(
        BetterPlayerDataSourceType.file,
        widget.path,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ValueKey(widget.path),
      onVisibilityChanged: (info) {
        var visiblePercentage = info.visibleFraction * 100;
        if (visiblePercentage == 100) {
          controller.play();
        } else {
          controller.pause();
        }
      },
      child: Center(
        child: AspectRatio(
          aspectRatio: (1080 / 1920),
          child: BetterPlayer(controller: controller),
        ),
      ),
    );
  }
}
