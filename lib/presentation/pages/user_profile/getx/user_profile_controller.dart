import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/mapper/auth_mapper.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/data/model/auth_model/user_model.dart';
import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/domain/entity/auth_entity/user_entity.dart';
import 'package:new_sai/domain/entity/reels_entity/reels_entity.dart';
import 'package:new_sai/domain/entity/stories_entity/story_entity.dart';
import 'package:new_sai/domain/use_case/auth_use_case/cancel_friend_request_use_case.dart';
import 'package:new_sai/domain/use_case/auth_use_case/get_user_profile_by_id_use_case.dart';
import 'package:new_sai/domain/use_case/auth_use_case/send_friend_request_use_case.dart';
import 'package:new_sai/domain/use_case/reels_use_case/get_user_reels_use_case.dart';
import 'package:new_sai/domain/use_case/stories_use_case/get_user_stories_use_case.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/getx/profile_controller.dart';

class UserProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final appController = Get.find<AppController>();
  late int id;
  bool isFromChat = false;
  final userReelsController = ScrollController();
  final userStoryController = ScrollController();
  late TabController tabController;
  final GetUserProfileByIdUseCase _profileByIdUseCase =
      instance<GetUserProfileByIdUseCase>();
  final SendFriendRequestUseCase _friendRequestUseCase =
      instance<SendFriendRequestUseCase>();
  final CancelFriendRequestUseCase _cancelFriendRequestUseCase =
      instance<CancelFriendRequestUseCase>();
  final GetUserReelsUseCase _getUserReelsUseCase =
      instance<GetUserReelsUseCase>();
  final GetUserStoriesUseCase _getUserStoriesUseCase =
      instance<GetUserStoriesUseCase>();
  int userReelsPage = 1;
  int userStoriesPage = 1;
  final RxBool _loadingGetProfile = false.obs;
  final Rx<UserEntity> _user = UserModel().toDomain().obs;
  final RxInt _currentIndex = 0.obs;
  final RxBool _loadingSendCancelRequest = false.obs;
  final RxBool _loadingUserReels = false.obs;
  final RxBool _loadingUserReelsPagination = false.obs;
  final RxList<ReelsEntity> _userReels = <ReelsEntity>[].obs;
  final Rx<PaginationEntity> _userReelsPagination =
      PaginationModel().toDomain().obs;
  final RxBool _loadingUserStory = false.obs;
  final RxBool _loadingUserStoryPagination = false.obs;
  final RxList<StoryEntity> _userStory = <StoryEntity>[].obs;
  final Rx<PaginationEntity> _userStoryPagination =
      PaginationModel().toDomain().obs;

  bool get loadingGetProfile => _loadingGetProfile.value;
  UserEntity get user => _user.value;
  int get currentIndex => _currentIndex.value;
  bool get loadingSendCancelRequest => _loadingSendCancelRequest.value;
  bool get loadingUserReels => _loadingUserReels.value;
  bool get loadingUserReelsPagination => _loadingUserReelsPagination.value;
  List<ReelsEntity> get userReels => _userReels;
  PaginationEntity get userReelsPagination => _userReelsPagination.value;
  bool get loadingUserStory => _loadingUserStory.value;
  bool get loadingUserStoryPagination => _loadingUserStoryPagination.value;
  List<StoryEntity> get userStory => _userStory;
  PaginationEntity get userStoryPagination => _userStoryPagination.value;

  set loadingGetProfile(value) => _loadingGetProfile.value = value;
  set user(UserEntity value) => _user.value = value;
  set currentIndex(value) => _currentIndex.value = value;
  set loadingSendCancelRequest(value) =>
      _loadingSendCancelRequest.value = value;
  set loadingUserReels(value) => _loadingUserReels.value = value;
  set loadingUserReelsPagination(value) =>
      _loadingUserReelsPagination.value = value;
  set userReels(List<ReelsEntity> value) => _userReels.value = value;
  set userReelsPagination(PaginationEntity value) =>
      _userReelsPagination.value = value;
  set loadingUserStory(value) => _loadingUserStory.value = value;
  set loadingUserStoryPagination(value) =>
      _loadingUserStoryPagination.value = value;
  set userStory(List<StoryEntity> value) => _userStory.value = value;
  set userStoryPagination(PaginationEntity value) =>
      _userStoryPagination.value = value;

  getUserProfile() async {
    loadingGetProfile = true;
    (await _profileByIdUseCase.execute(id)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        user = r;
      },
    );
    loadingGetProfile = false;
  }

  sendFriendRequest() async {
    if (loadingSendCancelRequest) {
      return;
    }
    loadingSendCancelRequest = true;
    (await _friendRequestUseCase.execute(user.id.toInt())).fold(
      (l) {},
      (r) {
        getUserProfile();
        Get.find<ProfileController>().getMyProfile();
      },
    );
    loadingSendCancelRequest = false;
  }

  cancelFrindRequest() async {
    if (loadingSendCancelRequest) {
      return;
    }
    loadingSendCancelRequest = true;
    (await _cancelFriendRequestUseCase.execute(user.id.toInt())).fold(
      (l) {},
      (r) {
        getUserProfile();
        Get.find<ProfileController>().getMyProfile();
      },
    );
    loadingSendCancelRequest = false;
  }

  getUserReels({bool isPaginate = false}) async {
    if (isPaginate) {
      loadingUserReelsPagination = true;
    } else {
      loadingUserReels = true;
      userReels.clear();
      userReelsPage = 1;
    }
    (await _getUserReelsUseCase.execute({
      "id": user.id,
      "page": userReelsPage,
    }))
        .fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        userReels.addAll(r.data);
        userReelsPagination = r.pagination;
        userReelsPage++;
      },
    );
    loadingUserReels = false;
    loadingUserReelsPagination = false;
  }

  getUserStories({bool isPaginate = false}) async {
    if (isPaginate) {
      loadingUserStoryPagination = true;
    } else {
      loadingUserStory = true;
      userStory.clear();
      userStoriesPage = 1;
    }
    (await _getUserStoriesUseCase.execute({
      "id": user.id,
      "page": userStoriesPage,
    }))
        .fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        userStory.addAll(r.data);
        userStoryPagination = r.pagination;
        userStoriesPage++;
      },
    );
    loadingUserStory = false;
    loadingUserStoryPagination = false;
  }

  initController() async {
    loadingUserReels = true;
    loadingUserStory = true;
    await getUserProfile();
    await getUserStories();
    await getUserReels();
  }

  @override
  void onInit() async {
    id = Get.arguments?['id'] ?? 0;
    isFromChat = Get.arguments?['isFromChat'] ?? false;
    tabController = TabController(length: 2, vsync: this);
    userReelsController.addListener(() async {
      if (userReelsController.offset ==
          userReelsController.position.maxScrollExtent) {
        if (userReelsPagination.nextPageUrl.isNotEmpty &&
            !loadingUserReelsPagination) {
          await getUserReels(isPaginate: true);
        }
      }
    });
    userStoryController.addListener(() async {
      if (userStoryController.offset ==
          userStoryController.position.maxScrollExtent) {
        if (userStoryPagination.nextPageUrl.isNotEmpty &&
            !loadingUserStoryPagination) {
          await getUserStories(isPaginate: true);
        }
      }
    });
    await initController();
    super.onInit();
  }
}
