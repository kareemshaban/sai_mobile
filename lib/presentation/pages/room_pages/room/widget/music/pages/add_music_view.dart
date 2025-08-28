import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/presentation/pages/posts/post_view/getx/post_view_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/room/room_local_model/room_song_model.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:new_sai/presentation/widgets/app_permission_dialog.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';
import 'package:on_audio_query_forked/on_audio_query.dart';

class AddMusicView extends StatefulWidget {
  final bool fromRoom;
  const AddMusicView({
    super.key,
    this.fromRoom = true,
  });

  @override
  AddMusicViewState createState() => AddMusicViewState();
}

class AddMusicViewState extends State<AddMusicView> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final List<RoomSongModel> songs = [];

  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    LogConfig logConfig = LogConfig(logType: LogType.DEBUG);
    _audioQuery.setLogConfig(logConfig);
    checkAndRequestPermissions();
  }

  checkAndRequestPermissions({bool retry = false}) async {
    _hasPermission = await _audioQuery.checkAndRequest(
      retryRequest: retry,
    );
    _hasPermission
        ? setState(() {})
        : Get.dialog(
            AppPermissionDialog(
              message: AppStrings.youMustEnablePermissionToAccessAudioFiles,
            ),
          );
  }

  onAddItemTOList(SongModel item) async {
    if (widget.fromRoom) {
      if (!songs.any((element) => element.path == item.data)) {
        final image = await _audioQuery.queryArtwork(
          item.id,
          ArtworkType.AUDIO,
          size: 200,
          quality: 100,
          format: ArtworkFormat.PNG,
        );
        final itemDuration = Duration(milliseconds: item.duration ?? 0);
        songs.add(
          RoomSongModel(
            name: item.title,
            duration: itemDuration.inSeconds,
            path: item.data,
            image: image,
          ),
        );
      } else {
        final index = songs.indexWhere((element) => element.path == item.data);
        songs.removeAt(index);
      }
    } else {
      songs.clear();
      final image = await _audioQuery.queryArtwork(
        item.id,
        ArtworkType.AUDIO,
        size: 200,
        quality: 100,
        format: ArtworkFormat.PNG,
      );
      final itemDuration = Duration(milliseconds: item.duration ?? 0);
      songs.add(RoomSongModel(
        name: item.title,
        duration: itemDuration.inSeconds,
        path: item.data,
        image: image,
      ));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        leadingWidth: 60,
        title: Text(AppStrings.addMusic),
      ),
      body: Center(
        child: !_hasPermission
            ? noAccessToLibraryWidget()
            : FutureBuilder<List<SongModel>>(
                future: _audioQuery.querySongs(
                  sortType: SongSortType.DATE_ADDED,
                  orderType: OrderType.DESC_OR_GREATER,
                  uriType: UriType.EXTERNAL,
                  ignoreCase: true,
                ),
                builder: (context, item) {
                  if (item.hasError) {
                    return const SizedBox();
                  }
                  if (item.data == null) {
                    return const AppLoader();
                  }
                  if (item.data!.isEmpty) {
                    return Text(
                      AppStrings.noDataFound,
                      style: Get.textTheme.titleMedium!.copyWith(
                        fontSize: AppSize.s16(context),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: item.data!.length,
                    padding: const EdgeInsets.only(bottom: 50),
                    itemBuilder: (context, index) {
                      final itemDuration = Duration(
                        milliseconds: item.data![index].duration ?? 0,
                      );
                      return ListTile(
                        title: Text(
                          item.data![index].title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Get.textTheme.titleLarge!.copyWith(
                            fontSize: AppSize.s16(context),
                          ),
                        ),
                        subtitle: itemDuration.inSeconds != 0
                            ? Text(
                                durationText(itemDuration),
                                style: Get.textTheme.titleMedium!.copyWith(
                                  fontSize: AppSize.s14(context),
                                ),
                              )
                            : null,
                        leading: FutureBuilder(
                          future: _audioQuery.queryArtwork(
                            item.data![index].id,
                            ArtworkType.AUDIO,
                            size: 200,
                            quality: 100,
                            format: ArtworkFormat.PNG,
                          ),
                          builder: (context, item) {
                            if (item.data != null && item.data!.isNotEmpty) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.memory(
                                  item.data!,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, exception, stackTrace) {
                                    return const AppImage(
                                      image: Constants.musicIcon,
                                      width: 50,
                                      height: 50,
                                    );
                                  },
                                ),
                              );
                            }
                            return const AppImage(
                              image: Constants.musicIcon,
                              width: 50,
                              height: 50,
                              radius: 10,
                            );
                          },
                        ),
                        trailing: SizedBox(
                          width: 25,
                          height: 25,
                          child: Checkbox(
                            value: songs.any((element) =>
                                element.path == item.data![index].data),
                            onChanged: (value) async {
                              await onAddItemTOList(item.data![index]);
                            },
                          ),
                        ),
                        onLongPress: () async {
                          await onAddItemTOList(item.data![index]);
                        },
                        onTap: () async {
                          await onAddItemTOList(item.data![index]);
                        },
                      );
                    },
                  );
                },
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AppButton(
        title: AppStrings.addMusic,
        width: .8.w(context),
        onTap: () {
          if (songs.isEmpty) {
            showSnackBarWidget(message: AppStrings.pleaseSelectMusicFirst);
            return;
          }
          if (widget.fromRoom) {
            final roomController = Get.find<RoomController>();
            for (var element in songs) {
              roomController.songs.addIf(
                !roomController.songs.any((song) => song.path == element.path),
                element,
              );
            }
            roomController.songBox.deleteAll(roomController.songBox.keys);
            roomController.songBox.addAll(roomController.songs);
          } else {
            Get.find<PostViewController>().musicFilePath = songs.first.path!;
          }
          Get.back();
        },
      ),
    );
  }

  Widget noAccessToLibraryWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppStrings.applicationDoesntHaveAccessToTheLibrary,
          style: Get.textTheme.titleMedium!.copyWith(
            fontSize: AppSize.s16(context),
          ),
        ),
        10.verticalSpace(),
        AppButton(
          title: AppStrings.allow,
          onTap: () => checkAndRequestPermissions(retry: true),
        ),
      ],
    );
  }
}
