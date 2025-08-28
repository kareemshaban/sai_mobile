import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/mapper/story_mapper.dart';
import 'package:new_sai/data/model/post_model/post_data_model.dart';
import 'package:new_sai/data/params/story_params/add_story_params.dart';
import 'package:new_sai/domain/entity/stories_entity/post_data_entity.dart';
import 'package:new_sai/domain/use_case/stories_use_case/add_stories_use_case.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/getx/profile_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/music/pages/add_music_view.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_permission_dialog.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';
import 'package:on_audio_query_forked/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';

class PostViewController extends GetxController {
  late bool isStory;
  late PostDataEntity postDataEntity;
  final appController = Get.find<AppController>();
  final AddStoriesUseCase _addStoryUseCase = AddStoriesUseCase(instance());
  final profileController = Get.find<ProfileController>();

  final RxString _musicFilePath = ''.obs;
  final Rx<bool> _isLoading = false.obs;

  String get musicFilePath => _musicFilePath.value;
  bool get isLoading => _isLoading.value;

  set musicFilePath(value) => _musicFilePath.value = value;
  set isLoading(value) => _isLoading.value = value;

  pickMusicFile() async {
    if (Platform.isAndroid) {
      Get.to(() => const AddMusicView(fromRoom: false,));
    } else {
      final OnAudioQuery audioQuery = OnAudioQuery();

      if (await audioQuery.checkAndRequest(
        retryRequest: true,
      )) {
        final picker = await FilePicker.platform.pickFiles(
          type: FileType.audio,
          allowMultiple: false,
        );
        if (picker != null) {
          for (var element in picker.files) {
            if (element.path != null) {
              musicFilePath = element.xFile.path;
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
  }

  clearMusicFile() {
    musicFilePath = '';
  }

  postStory() async {
    final videos = postDataEntity.mediaPathList
        .where((element) => element.type == AssetType.video);
    final photos = postDataEntity.mediaPathList
        .where((element) => element.type == AssetType.image);
    for (var element in videos) {
      final thumb = await getVideosThumbanail(element.path) ?? '';
      element.thumb = thumb;
    }
    final storyParameter = AddStoryParams(
      videos: videos.map((e) {
        return MediaParams(
          type: "video",
          file: e.path,
          thump: e.thumb,
        );
      }).toList(),
      images:
          photos.map((e) => MediaParams(type: "video", file: e.path)).toList(),
      viewState: 'all',
      canComment: true,
      location: null,
      description: '',
      music: musicFilePath.isEmpty ? null : musicFilePath,
    );

    if (isLoading) return;
    isLoading = true;
    var result = await _addStoryUseCase.execute(storyParameter);
    result.fold((failure) {
      isLoading = false;
      showSnackBarWidget(message: failure.message);
    }, (success) {
      isLoading = false;
      showSnackBarWidget(
          message: success.message ?? "", color: ColorManager.green);
      Get.until(
        (route) {
          if (Get.currentRoute == AppRoutes.mainRoute) {
            return true;
          }
          return false;
        },
      );
      profileController.getUserStories();
    });
  }

  Future<String?> getVideosThumbanail(String path) async {
    try {
      XFile thumbnailFile = await VideoThumbnail.thumbnailFile(
        video: path,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.PNG,
        maxHeight: 300,
        quality: 100,
      );

      if (thumbnailFile.path.isNotEmpty) {
        return thumbnailFile.path;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  @override
  void onInit() {
    isStory = Get.arguments['isStory'] ?? false;
    postDataEntity = Get.arguments['data'] ?? PostDataModel().toDomain();
    super.onInit();
  }
}
