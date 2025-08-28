import 'dart:developer';

import 'package:flutter_story_presenter/flutter_story_presenter.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/mapper/story_mapper.dart';
import 'package:new_sai/data/model/story_model/story_model.dart';
import 'package:new_sai/domain/entity/stories_entity/story_entity.dart';
import 'package:new_sai/domain/use_case/stories_use_case/delete_story_use_case.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/getx/profile_controller.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class MyStoryController extends GetxController {
  final profileController = Get.find<ProfileController>();
  final Rx<StoryEntity> _story = StoryModel().toDomain().obs;
  final storyController = FlutterStoryController();
  final player = AudioPlayer();
  final DeleteStoryUseCase _deleteStoryUseCase = instance<DeleteStoryUseCase>();

  final RxInt _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;
  StoryEntity get story => _story.value;

  set currentIndex(value) => _currentIndex.value = value;
  set story(StoryEntity value) => _story.value = value;

  onChangedStoryIndex(value) {
    print('yazan');
    print(currentIndex);
    print(story.media.length);
    currentIndex = value;
  }

  deleteStory() async {
    storyController.pause();
    showAppLoadingDialog(barrierDismissible: true);
    (await _deleteStoryUseCase.execute(story.media[currentIndex].id)).fold(
      (l) {
        if (Get.isDialogOpen == true) {
          Get.back();
        }
        showSnackBarWidget(message: l.message);
      },
      (r) async {
        if (Get.isDialogOpen == true) {
          Get.back();
        }
        story.media.removeAt(currentIndex);
        _story.refresh();
        if (story.media.isEmpty) {
          Get.until((route) => Get.currentRoute == AppRoutes.mainRoute);
          await profileController.getUserStories();
          return;
        }

        if (currentIndex < story.media.length - 1) {
        } else {
          currentIndex = story.media.length - 1; // stay at last valid index
          storyController.previous(); // or show last story again
        }

        _story.refresh();
        await profileController.getUserStories();
      },
    );
    storyController.play();
  }

  bool isMe() {
    return story.user.id == Get.find<AppController>().user.id;
  }

  @override
  void onInit() async {
    story = Get.arguments;
    storyController.addListener(() {
      if (storyController.storyStatus == StoryAction.pause) {
        player.pause();
      } else if (storyController.storyStatus == StoryAction.play) {
        player.play();
      }
    });
    super.onInit();
  }

  @override
  void onReady() async {
    if (story.music.isNotEmpty) {
      storyController.pause();
      try {
        await player.setAudioSource(AudioSource.uri(Uri.parse(story.music)));
        if (Get.isBottomSheetOpen == false) {
          storyController.play();
        }
      } catch (e) {
        log(e.toString());
        storyController.play();
      }
    }
    super.onReady();
  }

  @override
  void onClose() {
    try {
      player.dispose();
      storyController.dispose();
    } catch (e) {
      log(e.toString());
    }
    super.onClose();
  }
}
