import 'package:better_player_plus/src/video_player/video_player.dart'
    show VideoPlayerController;
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/domain/entity/reels_entity/reels_entity.dart';
import 'package:new_sai/domain/use_case/auth_use_case/send_friend_request_use_case.dart';
import 'package:new_sai/domain/use_case/reels_use_case/delete_reels_use_case.dart';
import 'package:new_sai/domain/use_case/reels_use_case/like_reel_use_case.dart';
import 'package:new_sai/domain/use_case/reels_use_case/save_reel_use_case.dart';
import 'package:new_sai/domain/use_case/reels_use_case/share_reel_use_case.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/getx/profile_controller.dart';
import 'package:new_sai/presentation/pages/main/pages/reels/widgets/reels_comment_bottom_sheet.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class UsersAndSavedReelsController extends GetxController
    with WidgetsBindingObserver {
  AudioPlayer? audioPlayer = AudioPlayer();
  final profileController = Get.find<ProfileController>();
  final reelsController = FlutterCarouselController();
  VideoPlayerController? videoPlayerController;
  String title = '';
  int initIndex = 0;
  final SendFriendRequestUseCase _friendRequestUseCase =
      instance<SendFriendRequestUseCase>();
  final LikeReelUseCase _likeReelUseCase = instance<LikeReelUseCase>();
  final SaveReelUseCase _saveReelUseCase = instance<SaveReelUseCase>();
  final DeleteReelsUseCase _deleteReelsUseCase = instance<DeleteReelsUseCase>();
  final ShareReelUseCase _shareReelUseCase = instance<ShareReelUseCase>();

  final RxList<ReelsEntity> _reels = <ReelsEntity>[].obs;
  final RxInt _reelsCurrentIndex = 0.obs;
  final RxBool _loadingSendFriendRequest = false.obs;
  final RxBool _loadingLike = false.obs;
  final RxBool _loadingSave = false.obs;
  final RxBool _loadingShare = false.obs;
  final RxInt _mediaCurrentIndex = 0.obs;
  final RxBool _isPlaying = false.obs;
  final RxBool _showControl = false.obs;

  List<ReelsEntity> get reels => _reels;

  int get reelsCurrentIndex => _reelsCurrentIndex.value;

  bool get loadingSendFriendRequest => _loadingSendFriendRequest.value;

  bool get loadingLike => _loadingLike.value;

  bool get loadingSave => _loadingSave.value;

  bool get loadingShare => _loadingShare.value;

  int get mediaCurrentIndex => _mediaCurrentIndex.value;
  bool get isPlaying => _isPlaying.value;
  bool get showControl => _showControl.value;

  set reels(value) => _reels.value = value;

  set reelsCurrentIndex(value) => _reelsCurrentIndex.value = value;

  set loadingSendFriendRequest(value) =>
      _loadingSendFriendRequest.value = value;

  set loadingLike(value) => _loadingLike.value = value;

  set loadingSave(value) => _loadingSave.value = value;

  set loadingShare(value) => _loadingShare.value = value;

  set mediaCurrentIndex(value) => _mediaCurrentIndex.value = value;
  set isPlaying(value) => _isPlaying.value = value;
  set showControl(value) => _showControl.value = value;

  onPageChanged(value) async {
    await audioPlayer?.stop();
    reelsCurrentIndex = value;
    if (reels[reelsCurrentIndex].music.isNotEmpty) {
      audioPlayer ??= AudioPlayer();
      await audioPlayer?.setAudioSource(
          AudioSource.uri(Uri.parse(reels[reelsCurrentIndex].music)));
      await audioPlayer?.play();
    }
  }

  likeReel() async {
    if (loadingLike) {
      return;
    }
    final lastStatus = reels[reelsCurrentIndex].isLike;
    final lastCount = reels[reelsCurrentIndex].countLikes;
    reels[reelsCurrentIndex].isLike = !lastStatus;
    if (lastStatus) {
      reels[reelsCurrentIndex].countLikes -= 1;
    } else {
      reels[reelsCurrentIndex].countLikes += 1;
    }
    _reels.refresh();
    loadingLike = true;
    (await _likeReelUseCase.execute(reels[reelsCurrentIndex].id)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
        reels[reelsCurrentIndex].isLike = lastStatus;
        reels[reelsCurrentIndex].countLikes = lastCount;
        _reels.refresh();
      },
      (r) {
        // reels[reelsCurrentIndex].isLike = !reels[reelsCurrentIndex].isLike;
        // if (reels[reelsCurrentIndex].isLike) {
        //   reels[reelsCurrentIndex].countLikes += 1;
        // } else {
        //   reels[reelsCurrentIndex].countLikes -= 1;
        // }
        // _reels.refresh();
      },
    );
    loadingLike = false;
  }

  saveReel() async {
    if (loadingSave) return;
    loadingSave = true;
    (await _saveReelUseCase.execute(reels[reelsCurrentIndex].id)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        reels[reelsCurrentIndex].isSave = !reels[reelsCurrentIndex].isSave;
        if (reels[reelsCurrentIndex].isSave) {
          reels[reelsCurrentIndex].countSaves += 1;
        } else {
          reels[reelsCurrentIndex].countSaves -= 1;
        }
        _reels.refresh();
      },
    );
    loadingSave = false;
  }

  onTapReelComment() {
    Get.bottomSheet(
      ReelsCommentBottomSheet(
        allowComment: reels[reelsCurrentIndex].isComment,
        reelsID: reels[reelsCurrentIndex].id,
      ),
      isScrollControlled: true,
    );
  }

  sendFriendRequest() async {
    if (loadingSendFriendRequest) {
      return;
    }
    loadingSendFriendRequest = true;
    (await _friendRequestUseCase.execute(reels[reelsCurrentIndex].user.id))
        .fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        reels[reelsCurrentIndex].isFriend = true;
        _reels.refresh();
      },
    );
    loadingSendFriendRequest = false;
  }

  onTapDeleteReels(index) async {
    showAppLoadingDialog();
    (await _deleteReelsUseCase.execute(reels[index].id)).fold(
      (l) {
        Get.back();
        showSnackBarWidget(message: l.message);
      },
      (r) async {
        Get.back();
        if (r.message != null && r.message!.isNotEmpty) {
          showSnackBarWidget(message: r.message!);
        }
        reels.removeAt(index);
        _reels.refresh();
        if (reels.isEmpty) {
          Get.until((route) => Get.currentRoute == AppRoutes.mainRoute);
        }
        await profileController.getUserReels();
        audioPlayer?.stop();
      },
    );
  }

  updateReelComment(int id) {
    reels.firstWhere((element) => element.id == id).countComments += 1;
    _reels.refresh();
  }

  onChangedMediaIndex(value) {
    mediaCurrentIndex = value;
  }

  onTapUserProfile() async {
    if (reels[reelsCurrentIndex].user.id != Get.find<AppController>().user.id) {
      videoPlayerController?.pause();
      audioPlayer?.pause();
      await Get.toNamed(
        AppRoutes.userProfileRoute,
        arguments: {
          'id': reels[reelsCurrentIndex].user.id,
          'isFromChat': false,
        },
      );
      audioPlayer?.play();
      videoPlayerController?.play();
    }
  }

  onTapShareReels() async {
    if (loadingShare) {
      return;
    }
    loadingShare = true;
    (await _shareReelUseCase.execute(reels[reelsCurrentIndex].id)).fold(
      (l) {},
      (r) {
        reels[reelsCurrentIndex].countShare += 1;
        _reels.refresh();
      },
    );
    loadingShare = false;
  }

  onTapOnMentionUser(int id) async {
    videoPlayerController?.pause();
    audioPlayer?.pause();
    await Get.toNamed(
      AppRoutes.userProfileRoute,
      arguments: {
        'id': id,
        'isFromChat': false,
      },
    );
    audioPlayer?.play();
    videoPlayerController?.play();
  }

  @override
  void onInit() async {
    WidgetsBinding.instance.addObserver(this);
    title = Get.arguments['title'] ?? '';
    for (var element in Get.arguments['reels'] ?? []) {
      reels.add(element);
    }
    initIndex = Get.arguments['initIndex'] ?? 0;
    reelsCurrentIndex = initIndex;
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        reelsController.jumpToPage(reelsCurrentIndex);
      },
    );
    if (reels[reelsCurrentIndex].music.isNotEmpty) {
      audioPlayer ??= AudioPlayer();
      await audioPlayer?.setAudioSource(
          AudioSource.uri(Uri.parse(reels[reelsCurrentIndex].music)));
      await audioPlayer?.play();
    }

    super.onInit();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    videoPlayerController?.dispose();
    audioPlayer?.dispose();
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      audioPlayer?.pause();
    } else if (state == AppLifecycleState.resumed) {
      audioPlayer?.play();
    }
  }
}
