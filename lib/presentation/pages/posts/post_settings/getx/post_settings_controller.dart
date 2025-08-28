import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:get_thumbnail_video/index.dart';
import 'package:get_thumbnail_video/video_thumbnail.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/mapper/story_mapper.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/data/model/post_model/post_data_model.dart';
import 'package:new_sai/data/params/story_params/add_story_params.dart';
import 'package:new_sai/data/services/location_service/location_service.dart';
import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/domain/entity/auth_entity/user_entity.dart';
import 'package:new_sai/domain/entity/stories_entity/post_data_entity.dart';
import 'package:new_sai/domain/use_case/auth_use_case/get_my_friends_use_case.dart';
import 'package:new_sai/domain/use_case/reels_use_case/add_reels_use_case.dart';
import 'package:new_sai/domain/use_case/stories_use_case/add_stories_use_case.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/getx/profile_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';

class PostSettingsController extends GetxController {
  final _getMyFriendsUseCase = instance<GetMyFriendsUseCase>();
  final profileController = Get.find<ProfileController>();
  final descController = TextEditingController();
  late PostDataEntity postDataEntity;
  late AddStoryParams storyParameter;
  late bool isStory;
  List<FriendsModel> myFirendsList = [];
  List<FriendsModel> chosedFriends = [];
  final _placemark = const Placemark().obs;
  Placemark get placemark => _placemark.value;
  set placemark(Placemark value) => _placemark.value = value;
  final _locationString = "".obs;
  String get locationString => _locationString.value;
  set locationString(String value) => _locationString.value = value;
  bool canComment = true;
  String music = '';
  final linkTextControlle = TextEditingController();
  final hashTagTextController = TextEditingController();
  String linkStirng = "";
  final AddStoriesUseCase _addStoryUseCase = AddStoriesUseCase(instance());
  final AddReelsUseCase _addReelsUseCase = instance<AddReelsUseCase>();
  PaginationEntity paginationEntity = PaginationModel().toDomain();
  final Rx<bool> _isLoading = false.obs;
  final RxString _viewPostValue = 'all'.obs;
  List<String> hashTagsList = [];
  bool get isLoading => _isLoading.value;
  String get viewPostValue => _viewPostValue.value;
  ScrollController friendsListScrollController = ScrollController();
  set isLoading(value) => _isLoading.value = value;
  set viewPostValue(value) => _viewPostValue.value = value;
  bool isFirendsListLoading = false;
  bool paginationLoading = false;
  bool isLastFriendPage = false;
  int friendsPage = 1;
  final formKey = GlobalKey<FormState>();

  getMyFriends({required bool isPaginate}) async {
    if (isLastFriendPage) {
      return;
    }
    if (isPaginate) {
      paginationLoading = true;
    } else {
      isFirendsListLoading = true;
    }

    update(["firends_Botttom_sheet"]);
    var result = await _getMyFriendsUseCase.execute(friendsPage);
    result.fold((failure) {
      showSnackBarWidget(message: failure.message);
    }, (friends) {
      var data = friends.list.data
          .map((firend) => FriendsModel(isSelected: false, friend: firend))
          .toList();
      myFirendsList.addAll(data);
      paginationEntity = friends.list.pagination;
      if (paginationEntity.nextPageUrl.isEmpty) {
        isLastFriendPage = true;
      } else {
        friendsPage++;
      }

      //? check if user select a previous firends
      myFirendsList = myFirendsList.map<FriendsModel>((friend) {
        for (var element in chosedFriends) {
          if (friend.friend.id == element.friend.id) {
            friend = friend.copywith(isSelected: element.isSelected);
          }
        }
        return friend;
      }).toList();
    });
    paginationLoading = false;
    isFirendsListLoading = false;
    update(["firends_Botttom_sheet"]);
  }

  changeCommentState() {
    canComment = !canComment;
    update();
  }

  postStory() async {
    if (isLoading) return;
    isLoading = true;
    var result = await _addStoryUseCase.execute(storyParameter.copyWith(
        description: descController.text,
        link: linkStirng,
        location: locationString,
        canComment: canComment,
        viewState: viewPostValue,
        hashTags: hashTagsList,
        mentionsIds: chosedFriends.map((firend) => firend.friend.id).toList()));
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

  acceptLocation() {
    locationString = "${placemark.country} - ${placemark.locality}";
    update();
    Get.back();
  }

  deleteLocation() {
    locationString = "";
    placemark = const Placemark();
    update();
    Get.back();
  }

  changeLink(bool remove) {
    if (remove) {
      linkStirng = "";
      linkTextControlle.text = "";
      update();
      Get.back();
    } else {
      if (formKey.currentState!.validate()) {
        linkStirng = linkTextControlle.text;
        update();
        Get.back();
      }
    }
  }

  Future<String?> getVideoThumbanail() async {
    try {
      XFile thumbnailFile = await VideoThumbnail.thumbnailFile(
        video: postDataEntity.mediaPathList.first.path,
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

  addReels() async {
    if (isLoading) {
      return;
    }
    isLoading = true;
    final params = storyParameter.copyWith(
        description: descController.text,
        link: linkStirng,
        location: locationString,
        canComment: canComment,
        viewState: viewPostValue,
        hashTags: hashTagsList,
        mentionsIds:
            chosedFriends.map((firend) => firend.friend.friendId).toList());

    (await _addReelsUseCase.execute(params)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        showSnackBarWidget(
          message: r.message ?? "",
          textColor: ColorManager.white,
          color: ColorManager.green.withOpacity(0.7),
         // color: ColorManager.green.withOpacity(0.3),
        );
        Get.until(
          (route) {
            if (Get.currentRoute == AppRoutes.mainRoute) {
              return true;
            }
            return false;
          },
        );
        profileController.getUserReels();
      },
    );
    isLoading = false;
  }

  onTapPost() async {
    if (isStory) {
      await postStory();
    } else {
      await addReels();
    }
  }

  getUserLocation(BuildContext context) async {
    var location = await LocationService.getCurrentPosition(context);
    if (location != null) {
      var currentPlaceMark =
          await LocationService.getAddressFromLatLng(location);
      placemark = currentPlaceMark;
    }
  }

  checkFriend(int index, bool isChecked) {
    for (var i = 0; i < myFirendsList.length; i++) {
      if (i == index) {
        myFirendsList[index] =
            myFirendsList[index].copywith(isSelected: isChecked);
      }
    }
    update(['firends_Botttom_sheet']);
  }

  confirmFriendsList() {
    chosedFriends = myFirendsList.where((firend) => firend.isSelected).toList();
    update();
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
  void onInit() async {
    postDataEntity = Get.arguments['data'] ?? PostDataModel().toDomain();
    isStory = Get.arguments['isStory'] ?? false;
    music = Get.arguments['music'] ?? '';
    final videos = postDataEntity.mediaPathList
        .where((element) => element.type == AssetType.video);
    final photos = postDataEntity.mediaPathList
        .where((element) => element.type == AssetType.image);
    for (var element in videos) {
      final thumb = await getVideosThumbanail(element.path) ?? '';
      element.thumb = thumb;
    }
    storyParameter = AddStoryParams(
      videos: videos.map((e) {
        return MediaParams(
          type: "video",
          file: e.path,
          thump: e.thumb,
        );
      }).toList(),
      images:
          photos.map((e) => MediaParams(type: "video", file: e.path)).toList(),
      viewState: viewPostValue,
      canComment: canComment,
      location: locationString,
      description: descController.text,
      music: music.isEmpty ? null : music,
    );
    friendsListScrollController.addListener(() async {
      if (friendsListScrollController.offset ==
          friendsListScrollController.position.maxScrollExtent) {
        await getMyFriends(isPaginate: true);
      }
    });
    super.onInit();
  }

  addHashTag() {
    if (formKey.currentState!.validate()) {
      hashTagsList.add("#${hashTagTextController.text}");
      hashTagTextController.text = "";
      update();
      Get.back();
    }
  }

  removeHashTag(index) {
    hashTagsList.removeAt(index);
    update();
  }
}

class FriendsModel {
  final bool isSelected;
  final UserEntity friend;

  FriendsModel({required this.isSelected, required this.friend});
  FriendsModel copywith({bool? isSelected, UserEntity? friend}) => FriendsModel(
      isSelected: isSelected ?? this.isSelected, friend: friend ?? this.friend);
}
