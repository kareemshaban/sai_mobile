import 'dart:io';

import 'package:better_player_plus/better_player_plus.dart';
import 'package:better_player_plus/src/video_player/video_player.dart'
    show VideoPlayerController;
import 'package:flutter/material.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ReelsWidget extends StatefulWidget {
  final String videoPath;
  final void Function(VideoPlayerController videoController) getVideoController;
  final bool withMusic;
  final int id;
  const ReelsWidget({
    super.key,
    required this.videoPath,
    required this.getVideoController,
    required this.id,
    this.withMusic = false,
  });

  @override
  State<ReelsWidget> createState() => _ReelsWidgetState();
}

class _ReelsWidgetState extends State<ReelsWidget> {
  late BetterPlayerController controller;

  @override
  void initState() {
    controller = BetterPlayerController(
      BetterPlayerConfiguration(
        startAt: const Duration(seconds: 0),
        looping: true,
        autoDispose: true,
        autoPlay: false,
        fit: BoxFit.contain,
        aspectRatio: 1080 / 1920,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enableAudioTracks: false,
          enableFullscreen: false,
          showControls: false,
          controlsHideTime: Duration.zero,
          controlBarColor: ColorManager.black.withOpacity(.2),
          enableMute: false,
          enableOverflowMenu: false,
          enablePip: false,
          enablePlaybackSpeed: false,
          enablePlayPause: false,
          enableProgressBar: false,
          enableProgressBarDrag: false,
          enableProgressText: false,
          enableQualities: false,
          enableRetry: false,
          enableSkips: false,
          enableSubtitles: false,
        ),
        placeholder: const Center(
          child: AppLoader(
            color: ColorManager.white,
          ),
        ),
      ),
      betterPlayerDataSource: BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        widget.videoPath,
        useAsmsAudioTracks: false,
        useAsmsSubtitles: false,
        useAsmsTracks: false,
        bufferingConfiguration: const BetterPlayerBufferingConfiguration(
          minBufferMs: 5000,
          maxBufferMs: 10000,
          bufferForPlaybackMs: 2000, // 2 seconds
          bufferForPlaybackAfterRebufferMs: 3000,
        ),
        cacheConfiguration: BetterPlayerCacheConfiguration(
          useCache: !Platform.isIOS,
          key: widget.videoPath,
          maxCacheSize: 2000 * 1024 * 1024,
          maxCacheFileSize: 100 * 1024 * 1024,
          preCacheSize: 3 * 1024 * 1024,
        ),
        liveStream: false,
      ),
    );
    controller.videoPlayerController?.addListener(() {
      if (controller.videoPlayerController != null) {
        widget.getVideoController(controller.videoPlayerController!);
      }
    });
    controller.videoPlayerController?.pause();
    if (widget.withMusic) {
      controller.videoPlayerController?.setVolume(0);
    }
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ValueKey(widget.videoPath),
      onVisibilityChanged: (info) {
        var visiblePercentage = info.visibleFraction * 100;
        if (visiblePercentage == 100) {
          controller.play();
        }
        if (visiblePercentage < 20) {
          controller.pause();
          controller.seekTo(const Duration(seconds: 0));
        }
      },
      child: Center(
        child: BetterPlayer(
          controller: controller,
        ),
      ),
    );
  }
}
