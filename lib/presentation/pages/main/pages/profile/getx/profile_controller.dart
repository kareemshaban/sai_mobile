import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/domain/entity/auth_entity/user_entity.dart';
import 'package:new_sai/domain/entity/reels_entity/reels_entity.dart';
import 'package:new_sai/domain/entity/stories_entity/story_entity.dart';
import 'package:new_sai/domain/use_case/auth_use_case/get_my_profile_use_case.dart';
import 'package:new_sai/domain/use_case/auth_use_case/get_my_visitors_use_case.dart';
import 'package:new_sai/domain/use_case/auth_use_case/get_users_type_use_case.dart';
import 'package:new_sai/domain/use_case/notification_use_case/get_notification_count_use_case.dart';
import 'package:new_sai/domain/use_case/reels_use_case/get_saved_reels_use_case.dart';
import 'package:new_sai/domain/use_case/reels_use_case/get_user_reels_use_case.dart';
import 'package:new_sai/domain/use_case/stories_use_case/get_user_stories_use_case.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class ProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final scrollController = ScrollController();
  final refreshController = RefreshController();
  final savedReelsController = ScrollController();
  final userReelsController = ScrollController();
  final userStoryController = ScrollController();
  final userVisitorsController = ScrollController();
  final userFrindsController = ScrollController();
  final userFollowController = ScrollController();
  late TabController tabController;
  final appController = Get.find<AppController>();
  final GetMyProfileUseCase _getMyProfileUseCase =
      instance<GetMyProfileUseCase>();
  final GetNotificationCountUseCase _countUseCase =
      instance<GetNotificationCountUseCase>();
  final GetSavedReelsUseCase _getSavedReelsUseCase =
      instance<GetSavedReelsUseCase>();
  final GetUserReelsUseCase _getUserReelsUseCase =
      instance<GetUserReelsUseCase>();
  final GetUserStoriesUseCase _getUserStoriesUseCase =
      instance<GetUserStoriesUseCase>();
  final GetMyVisitorsUseCase _getMyVisitorsUseCase =
      instance<GetMyVisitorsUseCase>();
  final GetUsersTypeUseCase _getUsersTypeUseCase =
      instance<GetUsersTypeUseCase>();
  int savedReelsPage = 1;
  int userReelsPage = 1;
  int userStoriesPage = 1;
  int userNumbersPage = 1;

  final RxInt _currentIndex = 0.obs;
  final RxBool _loadingGetProfile = false.obs;
  final RxInt _notificationCount = 0.obs;
  final RxBool _loadingSavedReels = false.obs;
  final RxBool _loadingSavedReelsPagination = false.obs;
  final RxList<ReelsEntity> _savedReels = <ReelsEntity>[].obs;
  final Rx<PaginationEntity> _savedReelsPagination =
      PaginationModel().toDomain().obs;
  final RxBool _loadingUserReels = false.obs;
  final RxBool _loadingUserReelsPagination = false.obs;
  final RxList<ReelsEntity> _userReels = <ReelsEntity>[].obs;
  final Rx<PaginationEntity> _userReelsPagination =
      PaginationModel().toDomain().obs;
  final RxBool _loadingUserStories = false.obs;
  final RxBool _loadingUserStoriesPagination = false.obs;
  final RxList<StoryEntity> _userStories = <StoryEntity>[].obs;
  final Rx<PaginationEntity> _userStoriesPagination =
      PaginationModel().toDomain().obs;
  final RxList<UserEntity> _users = <UserEntity>[].obs;
  final Rx<PaginationEntity> _usersPagination =
      PaginationModel().toDomain().obs;
  final RxBool _loadingUsers = false.obs;
  final RxBool _loadingUsersPagination = false.obs;

  int get currentIndex => _currentIndex.value;
  bool get loadingGetProfile => _loadingGetProfile.value;
  int get notificationCount => _notificationCount.value;
  bool get loadingSavedReels => _loadingSavedReels.value;
  bool get loadingSavedReelsPagination => _loadingSavedReelsPagination.value;
  List<ReelsEntity> get savedReels => _savedReels;
  PaginationEntity get savedReelsPagination => _savedReelsPagination.value;
  bool get loadingUserReels => _loadingUserReels.value;
  bool get loadingUserReelsPagination => _loadingUserReelsPagination.value;
  List<ReelsEntity> get userReels => _userReels;
  PaginationEntity get userReelsPagination => _userReelsPagination.value;
  bool get loadingUserStories => _loadingUserStories.value;
  bool get loadingUserStoriesPagination => _loadingUserStoriesPagination.value;
  List<StoryEntity> get userStories => _userStories;
  PaginationEntity get userStoriesPagination => _userStoriesPagination.value;
  PaginationEntity get usersPagination => _usersPagination.value;
  List<UserEntity> get users => _users;
  bool get loadingUsers => _loadingUsers.value;
  bool get loadingUsersPagination => _loadingUsersPagination.value;

  set currentIndex(value) => _currentIndex.value = value;
  set loadingGetProfile(value) => _loadingGetProfile.value = value;
  set notificationCount(value) => _notificationCount.value = value;
  set loadingSavedReels(value) => _loadingSavedReels.value = value;
  set loadingSavedReelsPagination(value) =>
      _loadingSavedReelsPagination.value = value;
  set savedReels(List<ReelsEntity> value) => _savedReels.value = value;
  set savedReelsPagination(PaginationEntity value) =>
      _savedReelsPagination.value = value;
  set loadingUserReels(value) => _loadingUserReels.value = value;
  set loadingUserReelsPagination(value) =>
      _loadingUserReelsPagination.value = value;
  set userReels(List<ReelsEntity> value) => _userReels.value = value;
  set userReelsPagination(PaginationEntity value) =>
      _userReelsPagination.value = value;
  set loadingUserStories(value) => _loadingUserStories.value = value;
  set loadingUserStoriesPagination(value) =>
      _loadingUserStoriesPagination.value = value;
  set userStories(List<StoryEntity> value) => _userStories.value = value;
  set userStoriesPagination(PaginationEntity value) =>
      _userStoriesPagination.value = value;
  set usersPagination(PaginationEntity value) => _usersPagination.value = value;
  set users(List<UserEntity> value) => _users.value = value;
  set loadingUsers(value) => _loadingUsers.value = value;
  set loadingUsersPagination(value) => _loadingUsersPagination.value = value;

  getMyProfile({int index = 0}) async {
    loadingGetProfile = true;
    (await _getMyProfileUseCase.execute('')).fold(
      (l) {
        if (index <= 3) {
          getMyProfile(index: index + 1);
        } else {
          showSnackBarWidget(message: l.message);
          refreshController.loadFailed();
        }
      },
      (r) {
        appController.saveUser(r);
        refreshController.loadComplete();
      },
    );
    loadingGetProfile = false;
  }

  getNotifiactionCount() async {
    (await _countUseCase.execute('')).fold(
      (l) {},
      (r) {
        notificationCount = r.unreadCount;
      },
    );
  }

  getSavedReels({bool isPaginate = false}) async {
    if (isPaginate) {
      loadingSavedReelsPagination = true;
    } else {
      loadingSavedReels = true;
      savedReels.clear();
      savedReelsPage = 1;
    }
    (await _getSavedReelsUseCase.execute(savedReelsPage)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        savedReels.addAll(r.data);
        savedReelsPagination = r.pagination;
        savedReelsPage++;
      },
    );
    loadingSavedReels = false;
    loadingSavedReelsPagination = false;
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
      "id": appController.user.id,
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
      loadingUserStoriesPagination = true;
    } else {
      loadingUserStories = true;
      userStories.clear();
      userStoriesPage = 1;
    }
    (await _getUserStoriesUseCase.execute({
      "id": appController.user.id,
      "page": userStoriesPage,
    }))
        .fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        userStories.addAll(r.data);
        userStoriesPagination = r.pagination;
        userStoriesPage++;
      },
    );
    loadingUserStories = false;
    loadingUserStoriesPagination = false;
  }

  getAllInit() async {
    loadingSavedReels = true;
    loadingUserStories = true;
    loadingUserReels = true;
    await getMyProfile();
    await getUserStories();
    await getUserReels();
    await getSavedReels();
    await getNotifiactionCount();
  }

  getUserVisitor({bool isPaginate = false}) async {
    if (isPaginate) {
      loadingUsersPagination = true;
    } else {
      loadingUsers = true;
      userNumbersPage = 1;
      users.clear();
    }

    (await _getMyVisitorsUseCase.execute(userNumbersPage)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        userNumbersPage++;
        users.addAll(r.data);
        usersPagination = r.pagination;
      },
    );
    loadingUsersPagination = false;
    loadingUsers = false;
  }

  getUserFriend({
    bool isPaginate = false,
  }) async {
    if (isPaginate) {
      loadingUsersPagination = true;
    } else {
      loadingUsers = true;
      userNumbersPage = 1;
      users.clear();
    }

    final response = await _getUsersTypeUseCase.execute({
      'page': userNumbersPage,
      'type': "following",
    });

    response.fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        userNumbersPage++;
        users.addAll(r.list.data);
        usersPagination = r.list.pagination;
      },
    );
    loadingUsersPagination = false;
    loadingUsers = false;
  }

  getUserFollwers({
    bool isPaginate = false,
  }) async {
    if (isPaginate) {
      loadingUsersPagination = true;
    } else {
      loadingUsers = true;
      userNumbersPage = 1;
      users.clear();
    }

    final response = await _getUsersTypeUseCase.execute({
      'page': userNumbersPage,
      'type': "followers",
    });

    response.fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        userNumbersPage++;
        users.addAll(r.list.data);
        usersPagination = r.list.pagination;
      },
    );
    loadingUsersPagination = false;
    loadingUsers = false;
  }

  @override
  void onInit() async {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      currentIndex = tabController.index;
    });
    savedReelsController.addListener(() async {
      if (savedReelsController.offset ==
          savedReelsController.position.maxScrollExtent) {
        if (savedReelsPagination.nextPageUrl.isNotEmpty &&
            !loadingSavedReelsPagination) {
          await getSavedReels(isPaginate: true);
        }
      }
    });
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
        if (userStoriesPagination.nextPageUrl.isNotEmpty &&
            !loadingUserStoriesPagination) {
          await getUserStories(isPaginate: true);
        }
      }
    });
    userVisitorsController.addListener(() async {
      if (userVisitorsController.offset ==
          userVisitorsController.position.maxScrollExtent) {
        if (usersPagination.nextPageUrl.isNotEmpty && !loadingUsersPagination) {
          await getUserVisitor(isPaginate: true);
        }
      }
    });
    userFrindsController.addListener(() async {
      if (userFrindsController.offset ==
          userFrindsController.position.maxScrollExtent) {
        if (usersPagination.nextPageUrl.isNotEmpty && !loadingUsersPagination) {
          await getUserFriend(isPaginate: true);
        }
      }
    });
    userFollowController.addListener(() async {
      if (userFollowController.offset ==
          userFollowController.position.maxScrollExtent) {
        if (usersPagination.nextPageUrl.isNotEmpty && !loadingUsersPagination) {
          await getUserFollwers(isPaginate: true);
        }
      }
    });
    if (!isGuest()) {
      await getAllInit();
    }
    super.onInit();
  }
}
