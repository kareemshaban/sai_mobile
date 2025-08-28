import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';

class MusicPlayerWidget extends GetView<RoomController> {
  const MusicPlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: controller.onTapHideMusicPlayer,
            child: const Icon(
              CupertinoIcons.chevron_down,
              size: 20,
              color: ColorManager.white,
            ),
          ),
          5.verticalSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  controller.showMusicSound = !controller.showMusicSound;
                },
                child: const Icon(
                  CupertinoIcons.volume_down,
                  color: ColorManager.white,
                  size: 20,
                ),
              ),
              8.horizontalSpace(),
              Flexible(
                fit: FlexFit.tight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      controller.songs[controller.currentSongIndex].name ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Get.textTheme.bodySmall!.copyWith(
                        fontSize: AppSize.s12(context),
                      ),
                    ),
                    Text(
                      controller.songs[controller.increaseSongLocalIndex()]
                              .name ??
                          '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Get.textTheme.bodySmall!.copyWith(
                        fontSize: AppSize.s9(context),
                      ),
                    ),
                  ],
                ),
              ),
              8.horizontalSpace(),
              InkWell(
                onTap: controller.stopMusic,
                child: const Icon(
                  CupertinoIcons.power,
                  size: 20,
                  color: ColorManager.white,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                durationText(
                    Duration(seconds: controller.songSliderValue.toInt())),
                style: Get.textTheme.bodySmall!.copyWith(
                  fontSize: AppSize.s12(context),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Slider(
                  value: controller.songSliderValue,
                  max: controller.songDuration.inSeconds.toDouble(),
                  onChanged: controller.seekMusic,
                ),
              ),
              Text(
                durationText(controller.songDuration),
                style: Get.textTheme.bodySmall!.copyWith(
                  fontSize: AppSize.s12(context),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  controller.shouldCycle = !controller.shouldCycle;
                },
                child: controller.shouldCycle
                    ? const Icon(
                        CupertinoIcons.repeat_1,
                        color: ColorManager.white,
                        size: 20,
                      )
                    : const Icon(
                        CupertinoIcons.repeat,
                        color: ColorManager.white,
                        size: 20,
                      ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      controller.onSkipMusicAction(false);
                    },
                    child: const Icon(
                      Icons.skip_next_rounded,
                      color: ColorManager.white,
                    ),
                  ),
                  8.horizontalSpace(),
                  controller.isPlayingMusic
                      ? InkWell(
                          onTap: controller.pauseMusic,
                          child: const Icon(
                            CupertinoIcons.pause_fill,
                            color: ColorManager.white,
                          ),
                        )
                      : InkWell(
                          onTap: controller.playMusic,
                          child: const Icon(
                            CupertinoIcons.play_arrow_solid,
                            color: ColorManager.white,
                          ),
                        ),
                  8.horizontalSpace(),
                  InkWell(
                    onTap: () {
                      controller.onSkipMusicAction(true);
                    },
                    child: const Icon(
                      Icons.skip_previous_rounded,
                      color: ColorManager.white,
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: controller.openMusicPlaylistView,
                child: const Icon(
                  Icons.queue_music_rounded,
                  color: ColorManager.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
