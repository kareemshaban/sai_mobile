import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_story_presenter/flutter_story_presenter.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/params/reels_params/reels_comment_params.dart';
import 'package:new_sai/domain/entity/stories_entity/story_entity.dart';
import 'package:new_sai/domain/use_case/stories_use_case/comment_on_story_use_case.dart';
import 'package:new_sai/domain/use_case/stories_use_case/show_story_use_case.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class StoryViewController extends GetxController {
  late StoryEntity story;
  final commentController = TextEditingController();
  final storyController = FlutterStoryController();
  final player = AudioPlayer();
  final focusNode = FocusNode();
  final CommentOnStoryUseCase _commentOnStoryUseCase =
      instance<CommentOnStoryUseCase>();
  final ShowStoryUseCase _showStoryUseCase = instance<ShowStoryUseCase>();

  final RxInt _currentIndex = 0.obs;
  final RxBool _loadingComment = false.obs;

  int get currentIndex => _currentIndex.value;
  bool get loadingComment => _loadingComment.value;

  set currentIndex(value) => _currentIndex.value = value;
  set loadingComment(value) => _loadingComment.value = value;

  onChangedStoryIndex(value) {
    currentIndex = value;
    showStory();
  }

  commentOnStory() async {
    if (loadingComment) {
      return;
    }
    loadingComment = true;
    final params = ReelsCommentParams(
      id: story.media[currentIndex].id,
      comment: commentController.text,
    );
    (await _commentOnStoryUseCase.execute(params)).fold(
      (l) {
        focusNode.unfocus();
        showSnackBarWidget(message: l.message);
      },
      (r) {
        commentController.clear();
        focusNode.unfocus();
        showSnackBarWidget(
          message: r.message ?? "",
          color: ColorManager.green,
          snackPosition: SnackPosition.TOP,
        );
      },
    );
    loadingComment = false;
  }

  showStory() async {
    if (!story.media[currentIndex].isView) {
      (await _showStoryUseCase.execute(story.media[currentIndex].id)).fold(
        (l) {},
        (r) {
          story.media[currentIndex].isView = true;
        },
      );
    }
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
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        storyController.pause();
      } else {
        storyController.play();
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
        if (Get.isBottomSheetOpen == false && !focusNode.hasFocus) {
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
