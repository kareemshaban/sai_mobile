// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_media_metadata/flutter_media_metadata.dart';
// import 'package:get/get.dart';
// import 'package:new_sai/app/extensions.dart';
// import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
// import 'package:new_sai/presentation/pages/room_pages/room/room_local_model/room_song_model.dart';
// import 'package:new_sai/presentation/pages/room_pages/room/widget/music/song_item_widget.dart';
// import 'package:new_sai/presentation/resources/font_manger.dart';
// import 'package:new_sai/presentation/resources/string_manger.dart';
// import 'package:new_sai/presentation/widgets/app_back_button.dart';
// import 'package:new_sai/presentation/widgets/app_button.dart';
// import 'package:new_sai/presentation/widgets/app_permission_dialog.dart';
// import 'package:on_audio_query_forked/on_audio_query.dart';

// import 'add_music_view.dart';

// class MusicPlaylistView extends GetView<RoomController> {
//   const MusicPlaylistView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leadingWidth: 60,
//         leading: const AppBackButton(),
//         title: Text(AppStrings.myPlaylist),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: AppButton(
//         title: AppStrings.addMusic,
//         width: .8.w(context),
//         onTap: () async {
//           if (Platform.isAndroid) {
//             Get.to(() => const AddMusicView());
//           } else {
//             final OnAudioQuery audioQuery = OnAudioQuery();

//             if (await audioQuery.checkAndRequest(
//               retryRequest: true,
//             )) {
//               final picker = await FilePicker.platform.pickFiles(
//                 type: FileType.audio,
//                 allowMultiple: true,
//               );
//               if (picker != null) {
//                 for (var element in picker.files) {
//                   if (element.path != null) {
//                     final metadata =
//                         await MetadataRetriever.fromFile(File(element.path!));
//                     controller.songs.addIf(
//                       !controller.songs
//                           .any((song) => song.path == element.path),
//                       RoomSongModel(
//                         name: metadata.trackName ?? element.name,
//                         path: element.xFile.path,
//                         duration:
//                             ((metadata.trackDuration?.toDouble() ?? 0) / 1000)
//                                 .toInt(),
//                         image: metadata.albumArt,
//                       ),
//                     );
//                     controller.songBox.deleteAll(controller.songBox.keys);
//                     controller.songBox.addAll(controller.songs);
//                   }
//                 }
//               }
//             } else {
//               Get.dialog(
//                 AppPermissionDialog(
//                   message: AppStrings.youMustEnablePermissionToAccessAudioFiles,
//                 ),
//               );
//             }
//           }
//         },
//       ),
//       body: Obx(
//         () => controller.songs.isEmpty
//             ? Center(
//                 child: Text(
//                   AppStrings.pleaseAddMusicFromYourPhone,
//                   style: Get.textTheme.titleMedium!.copyWith(
//                     fontSize: AppSize.s14(context),
//                   ),
//                 ),
//               )
//             : ListView.builder(
//                 padding: const EdgeInsets.only(bottom: 50),
//                 itemBuilder: (BuildContext context, int index) {
//                   return Obx(
//                     () => SongItemWidget(
//                       song: controller.songs[index],
//                       isPlay: controller.isPlayingMusic &&
//                           controller.currentSongIndex == index,
//                       onTap: () async {
//                         await controller.onTapOnMusicItem(index);
//                       },
//                       onTapDelete: () {
//                         final songIndex = controller.songBox.values
//                             .toList()
//                             .indexWhere((element) =>
//                                 element.path == controller.songs[index].path);
//                         if (controller.musicPlayer.playing) {
//                           if (controller
//                                   .songs[controller.currentSongIndex].path ==
//                               controller.songs[songIndex].path) {
//                             controller.musicPlayer.stop();
//                             controller.mediaPlayer?.stop();
//                             controller.isPlayingMusic = false;
//                           }
//                         }
//                         controller.songs.removeAt(index);
//                         if (songIndex < controller.currentSongIndex) {
//                           controller.currentSongIndex =
//                               controller.decreaseSongLocalIndex();
//                         }
//                         controller.songBox.deleteAt(songIndex);
//                       },
//                     ),
//                   );
//                 },
//                 itemCount: controller.songs.length,
//               ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/room/room_local_model/room_song_model.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/music/song_item_widget.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_permission_dialog.dart';
import 'package:on_audio_query_forked/on_audio_query.dart';

import 'add_music_view.dart';

class MusicPlaylistView extends GetView<RoomController> {
  const MusicPlaylistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        leading: const AppBackButton(),
        title: Text(AppStrings.myPlaylist),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AppButton(
        title: AppStrings.addMusic,
        width: .8.w(context),
        onTap: () async {
          if (Platform.isAndroid) {
            Get.to(() => const AddMusicView());
          } else {
            final OnAudioQuery audioQuery = OnAudioQuery();

            if (await audioQuery.checkAndRequest(retryRequest: true)) {
              final picker = await FilePicker.platform.pickFiles(
                type: FileType.audio,
                allowMultiple: true,
              );
              if (picker != null) {
                for (var element in picker.files) {
                  final path = element.path;
                  if (path != null) {
                    try {
                      final metadata =
                          await MetadataRetriever.fromFile(File(path));
                      final song = RoomSongModel(
                        name: metadata.trackName ?? element.name,
                        path: path,
                        duration:
                            ((metadata.trackDuration?.toDouble() ?? 0) / 1000)
                                .toInt(),
                        image: metadata.albumArt,
                      );

                      controller.songs.addIf(
                        !controller.songs.any((s) => s.path == song.path),
                        song,
                      );
                      controller.songBox.clear();
                      controller.songBox.addAll(controller.songs);
                      print("✅ Added: ${song.name} (${song.duration}s)");
                    } catch (e) {
                      print("❌ Error reading metadata for: $path\n$e");
                    }
                  }
                }
              }
            } else {
              Get.dialog(
                AppPermissionDialog(
                  message: AppStrings.youMustEnablePermissionToAccessAudioFiles,
                ),
              );
            }
          }
        },
      ),
      body: Obx(
        () => controller.songs.isEmpty
            ? Center(
                child: Text(
                  AppStrings.pleaseAddMusicFromYourPhone,
                  style: Get.textTheme.titleMedium!.copyWith(
                    fontSize: AppSize.s14(context),
                  ),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.only(bottom: 60),
                itemCount: controller.songs.length,
                itemBuilder: (context, index) {
                  final song = controller.songs[index];
                  return SongItemWidget(
                    song: song,
                    isPlay: controller.isPlayingMusic &&
                        controller.currentSongIndex == index,
                    onTap: () async {
                      await controller.onTapOnMusicItem(index);
                    },
                    onTapDelete: () {
                      final songIndex = controller.songBox.values
                          .toList()
                          .indexWhere((e) => e.path == song.path);

                      if (controller.musicPlayer.playing &&
                          controller.songs[controller.currentSongIndex].path ==
                              song.path) {
                        controller.musicPlayer.stop();
                        controller.mediaPlayer?.stop();
                        controller.isPlayingMusic = false;
                      }

                      controller.songs.removeAt(index);
                      if (songIndex < controller.currentSongIndex) {
                        controller.currentSongIndex =
                            controller.decreaseSongLocalIndex();
                      }

                      controller.songBox.deleteAt(songIndex);
                    },
                  );
                },
              ),
      ),
    );
  }
}
