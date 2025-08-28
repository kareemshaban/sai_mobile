import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/music/empty_music_list.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/music/music_player_widget.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/music/music_sound_slider.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';

class RoomMusicPlayer extends GetView<RoomController> {
  const RoomMusicPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: .75.w(context),
      decoration: BoxDecoration(
        color: ColorManager.darkGreyColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20.0), // Rounded corners
      ),
      child: Obx(
        () => controller.showMusicSound
            ? const MusicSoundSlider()
            : controller.songs.isNotEmpty
                ? const MusicPlayerWidget()
                : const EmptyMusicList(),
      ),
    );
  }
}
