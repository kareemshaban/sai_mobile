import 'dart:async';

import 'package:flutter/material.dart';

class ReelsProgressBar extends StatelessWidget {
  final StreamController<double> videoProgressController;
  final dynamic videoPlayerController;
  const ReelsProgressBar(
      {super.key,
      required this.videoProgressController,
      this.videoPlayerController});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: videoProgressController.stream,
      builder: (context, snapshot) {
        return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              thumbShape: SliderComponentShape.noThumb,
              overlayShape: SliderComponentShape.noOverlay,
              trackHeight: 2,
            ),
            child: Slider(
              value: (snapshot.data ?? 0).clamp(0.0, 1.0),
              min: 0.0,
              max: 1.0,
              activeColor: Colors.white,
              inactiveColor: Colors.black,
              onChanged: (value) {
                final position =
                    videoPlayerController.value.duration.inMilliseconds * value;
                videoPlayerController
                    .seekTo(Duration(milliseconds: position.toInt()));
              },
            ),
          ),
        );
      },
    );
  }
}
