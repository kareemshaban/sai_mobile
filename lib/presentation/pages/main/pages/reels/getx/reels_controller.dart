import 'package:better_player_plus/src/video_player/video_player.dart'
    show VideoPlayerController;
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/domain/entity/reels_entity/reels_entity.dart';
import 'package:new_sai/domain/use_case/auth_use_case/send_friend_request_use_case.dart';
import 'package:new_sai/domain/use_case/reels_use_case/get_reels_use_case.dart';
import 'package:new_sai/domain/use_case/reels_use_case/like_reel_use_case.dart';
import 'package:new_sai/domain/use_case/reels_use_case/save_reel_use_case.dart';
import 'package:new_sai/domain/use_case/reels_use_case/share_reel_use_case.dart';
import 'package:new_sai/domain/use_case/reels_use_case/show_reels_use_case.dart';
import 'package:new_sai/presentation/pages/main/getx/main_controller.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/getx/profile_controller.dart';
import 'package:new_sai/presentation/pages/main/pages/reels/widgets/reels_comment_bottom_sheet.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class ReelsController extends GetxController with WidgetsBindingObserver {
  final GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();
  final reelsController = FlutterCarouselController();
  AudioPlayer? audioPlayer = AudioPlayer();
  final GetReelsUseCase _getReelsUseCase = instance<GetReelsUseCase>();
  final LikeReelUseCase _likeReelUseCase = instance<LikeReelUseCase>();
  final SaveReelUseCase _saveReelUseCase = instance<SaveReelUseCase>();
  final SendFriendRequestUseCase _friendRequestUseCase =
      instance<SendFriendRequestUseCase>();
  final ShowReelsUseCase _showReelsUseCase = instance<ShowReelsUseCase>();
  final ShareReelUseCase _shareReelUseCase = instance<ShareReelUseCase>();
  VideoPlayerController? videoPlayerController;
  int page = 1;
  bool isError = false;

  final RxBool _loadingGetReels = false.obs;
  final RxBool _loadingGetReelsPagination = false.obs;
  final RxList<ReelsEntity> _reels = <ReelsEntity>[].obs;
  final Rx<PaginationEntity> _pagination = PaginationModel().toDomain().obs;
  final RxInt _reelsFilter = 0.obs;
  final RxInt _reelsCurrentIndex = 0.obs;
  final RxBool _loadingSendFriend = false.obs;
  final RxBool _loadingLike = false.obs;
  final RxBool _loadingSave = false.obs;
  final RxBool _loadingShow = false.obs;
  final RxBool _loadingShare = false.obs;
  final RxInt _mediaCurrentIndex = 0.obs;
  final RxBool _isPlaying = false.obs;
  final RxBool _showControl = false.obs;

  bool get loadingGetReels => _loadingGetReels.value;
  bool get loadingGetReelsPagination => _loadingGetReelsPagination.value;
  List<ReelsEntity> get reels => _reels;
  PaginationEntity get pagination => _pagination.value;
  int get reelsFilter => _reelsFilter.value;
  int get reelsCurrentIndex => _reelsCurrentIndex.value;
  bool get loadingSendFriend => _loadingSendFriend.value;
  bool get loadingLike => _loadingLike.value;
  bool get loadingSave => _loadingSave.value;
  bool get loadingShow => _loadingShow.value;
  bool get loadingShare => _loadingShare.value;
  int get mediaCurrentIndex => _mediaCurrentIndex.value;
  bool get isPlaying => _isPlaying.value;
  bool get showControl => _showControl.value;

  set loadingGetReels(value) => _loadingGetReels.value = value;
  set loadingGetReelsPagination(value) =>
      _loadingGetReelsPagination.value = value;
  set reels(List<ReelsEntity> value) => _reels.value = value;
  set pagination(PaginationEntity value) => _pagination.value = value;
  set reelsFilter(value) => _reelsFilter.value = value;
  set reelsCurrentIndex(value) => _reelsCurrentIndex.value = value;
  set loadingSendFriend(value) => _loadingSendFriend.value = value;
  set loadingLike(value) => _loadingLike.value = value;
  set loadingSave(value) => _loadingSave.value = value;
  set loadingShow(value) => _loadingShow.value = value;
  set loadingShare(value) => _loadingShare.value = value;
  set mediaCurrentIndex(value) => _mediaCurrentIndex.value = value;
  set isPlaying(value) => _isPlaying.value = value;
  set showControl(value) => _showControl.value = value;

  getReels({bool isPaginate = false, bool isRefresh = false}) async {
    audioPlayer?.stop();
    audioPlayer = AudioPlayer();
    if (isPaginate) {
      loadingGetReelsPagination = true;
    } else {
      isError = false;
      if (!isRefresh) {
        loadingGetReels = true;
        reels.clear();
      }
      page = 1;
    }
    (await _getReelsUseCase.execute(
      {
        "is_friend": reelsFilter,
        "page": page,
      },
    ))
        .fold(
      (l) {
        showSnackBarWidget(message: l.message);
        isError = true;
      },
      (r) async {
        if (isRefresh) {
          reels.clear();
        }
        reels.addAll(r.data);
        pagination = r.pagination;
        page++;
        if (r.data.isNotEmpty) {
          if (!isPaginate) {
            if (r.data.first.music.isNotEmpty) {
              audioPlayer ??= AudioPlayer();
              await audioPlayer?.setAudioSource(
                  AudioSource.uri(Uri.parse(r.data.first.music)));
              if (Get.find<MainController>().currentIndex == 2) {
                if (Get.currentRoute == AppRoutes.mainRoute) {
                  await audioPlayer?.play();
                }
              }
            }
          }
        }
      },
    );
    loadingGetReels = false;
    loadingGetReelsPagination = false;
  }

  onChangeReelsFilter(int value) async {
    reelsFilter = value;
    await getReels();
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
    if (loadingSave) {
      return;
    }
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
        final profileController = Get.find<ProfileController>();
        profileController.getSavedReels();
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
    if (loadingSendFriend) {
      return;
    }

    final lastStatus = reels[reelsCurrentIndex].isFollowing;
    reels[reelsCurrentIndex].isFollowing = !lastStatus;
    _reels.refresh();

    loadingSendFriend = true;
    (await _friendRequestUseCase.execute(reels[reelsCurrentIndex].user.id))
        .fold(
      (l) {
        showSnackBarWidget(message: l.message);
        reels[reelsCurrentIndex].isFollowing = lastStatus;
        _reels.refresh();
      },
      (r) {},
    );
    loadingSendFriend = false;
  }

  showReels() async {
    if (loadingShow) return;
    loadingShow = true;
    (await _showReelsUseCase.execute(reels[reelsCurrentIndex].id)).fold(
      (l) {},
      (r) {
        reels[reelsCurrentIndex].isView = true;
      },
    );
    loadingShow = false;
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

  void onPageChanged(int newIndex) async {
    await audioPlayer?.stop();
    reelsCurrentIndex = newIndex;
    if (!isGuest() &&
        !reels[reelsCurrentIndex].isView &&
        reels[reelsCurrentIndex].user.id != Get.find<AppController>().user.id) {
      showReels();
    }
    if (newIndex == reels.length - 2) {
      if (pagination.nextPageUrl.isNotEmpty && !loadingGetReelsPagination) {
        await getReels(isPaginate: true);
      }
    }
    if (reels[reelsCurrentIndex].music.isNotEmpty) {
      audioPlayer ??= AudioPlayer();
      await audioPlayer?.setAudioSource(
          AudioSource.uri(Uri.parse(reels[reelsCurrentIndex].music)));
      if (Get.currentRoute == AppRoutes.mainRoute) {
        await audioPlayer?.play();
      }
    } else {
      audioPlayer = null;
    }
  }

  updateReelComment(int id) {
    reels.firstWhere((element) => element.id == id).countComments += 1;
    _reels.refresh();
  }

  onChangedMediaIndex(value) {
    mediaCurrentIndex = value;
  }

  @override
  void onInit() async {
    WidgetsBinding.instance.addObserver(this);
    await getReels();
    super.onInit();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    audioPlayer?.dispose();
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      audioPlayer?.pause();
    } else if (state == AppLifecycleState.resumed) {
      if (Get.find<MainController>().currentIndex == 2) {
        audioPlayer?.play();
      }
    }
  }
}
