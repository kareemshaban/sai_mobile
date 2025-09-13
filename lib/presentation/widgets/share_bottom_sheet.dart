import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/data/params/chat_params/send_message_params.dart';
import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/domain/entity/auth_entity/user_entity.dart';
import 'package:new_sai/domain/use_case/auth_use_case/get_my_friends_use_case.dart';
import 'package:new_sai/domain/use_case/chat_use_case/send_message_use_case.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:appinio_social_share/appinio_social_share.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';
import 'package:share_plus/share_plus.dart';

class ShareBottomSheet extends StatefulWidget {
  final String shareLink;
  const ShareBottomSheet({
    super.key,
    this.shareLink = '',
  });

  @override
  State<ShareBottomSheet> createState() => _ShareBottomSheetState();
}

class _ShareBottomSheetState extends State<ShareBottomSheet> {
  static AppinioSocialShare appinioSocialShare = AppinioSocialShare();
  final ScrollController scrollController = ScrollController();
  final GetMyFriendsUseCase _friendsUseCase = instance<GetMyFriendsUseCase>();
  final SendMessageUseCase _sendMessageUseCase = instance<SendMessageUseCase>();
  int page = 1;

  final RxBool _loadingMyFriend = false.obs;
  final RxBool _loadingMyFriendPagination = false.obs;
  final RxList<UserEntity> _friends = <UserEntity>[].obs;
  final Rx<PaginationEntity> _pagination = PaginationModel().toDomain().obs;

  bool get loadingMyFriend => _loadingMyFriend.value;
  bool get loadingMyFriendPagination => _loadingMyFriendPagination.value;
  List<UserEntity> get friends => _friends;
  PaginationEntity get pagination => _pagination.value;

  set loadingMyFriend(value) => _loadingMyFriend.value = value;
  set loadingMyFriendPagination(value) =>
      _loadingMyFriendPagination.value = value;
  set friends(List<UserEntity> value) => _friends.value = value;
  set pagination(PaginationEntity value) => _pagination.value = value;

  getMyFriends({bool isPaginate = false}) async {
    if (isPaginate) {
      loadingMyFriendPagination = true;
    } else {
      loadingMyFriend = true;
      friends.clear();
      page = 1;
    }
    (await _friendsUseCase.execute(page)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) async {
        friends.addAll(r.list.data);
        pagination = r.list.pagination;
        page++;
      },
    );
    loadingMyFriend = false;
    loadingMyFriendPagination = false;
  }

  sendMessageToFriend(int id) async {
    Get.back();
    final params = SendMessageParams(
      message: widget.shareLink,
      recID: id,
      type: 'text',
    );
    (await _sendMessageUseCase.execute(params)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        showSnackBarWidget(
          message: AppStrings.theMessageHasBeenSentSuccessfully,
          color: ColorManager.green,
          snackPosition: SnackPosition.TOP,
        );
      },
    );
  }

  @override
  void initState() {
    socialList = [
      SocialButtonModel(
        name: AppStrings.whatsApp,
        image: ImageAssets.whatsApp,
        onTap: () async {
          try {
            if (Platform.isAndroid) {
              await appinioSocialShare.android
                  .shareToWhatsapp(widget.shareLink, null);
            } else {
              await appinioSocialShare.iOS.shareToWhatsapp(widget.shareLink);
            }
          } catch (e) {
            showSnackBarWidget(message: AppStrings.unknown);
          }
        },
      ),
      SocialButtonModel(
        name: AppStrings.facebook,
        image: ImageAssets.facebook,
        onTap: () async {
          try {
            await Share.share(
              widget.shareLink,
              sharePositionOrigin: const Rect.fromLTRB(0, 0, 0, 0),
            );
            // if (Platform.isAndroid) {
            //   await appinioSocialShare.android
            //       .shareToFacebook(widget.shareLink, []);
            // } else {
            //   await appinioSocialShare.iOS
            //       .shareToFacebook(widget.shareLink, []);
            // }
          } catch (e) {
            showSnackBarWidget(message: AppStrings.unknown);
          }
        },
      ),
      SocialButtonModel(
        name: AppStrings.status,
        image: ImageAssets.whatsApp,
        onTap: () async {
          try {
            if (Platform.isAndroid) {
              await appinioSocialShare.android
                  .shareToWhatsapp(widget.shareLink, null);
            } else {
              appinioSocialShare.iOS.shareToWhatsapp(widget.shareLink);
            }
          } catch (e) {
            showSnackBarWidget(message: AppStrings.unknown);
          }
        },
      ),
      SocialButtonModel(
        name: AppStrings.instagram,
        image: ImageAssets.instagram,
        onTap: () async {
          try {
            if (Platform.isAndroid) {
              await appinioSocialShare.android
                  .shareToInstagramDirect(widget.shareLink);
            } else {
              appinioSocialShare.iOS.shareToInstagramDirect(widget.shareLink);
            }
          } catch (e) {
            showSnackBarWidget(message: AppStrings.unknown);
          }
        },
      ),
      SocialButtonModel(
        name: AppStrings.telegram,
        image: ImageAssets.telegram,
        onTap: () async {
          try {
            if (Platform.isAndroid) {
              await appinioSocialShare.android
                  .shareToTelegram(widget.shareLink, null);

              try {
                await appinioSocialShare.android.shareTextToPackages(
                    widget.shareLink, "org.telegram.messenger.web");
              } catch (e) {
                showSnackBarWidget(message: AppStrings.unknown);
              }
            } else {
              await appinioSocialShare.iOS.shareToTelegram(widget.shareLink);
            }
          } catch (e) {
            showSnackBarWidget(message: AppStrings.unknown);
          }
        },
      ),
      SocialButtonModel(
        name: AppStrings.copyLink,
        image: ImageAssets.link,
        color: ColorManager.primary,
        onTap: () async {
          try {
            await appinioSocialShare.android.copyToClipBoard(widget.shareLink);
            showSnackBarWidget(
              message: AppStrings.copied,
              color: ColorManager.green,
            );
          } catch (e) {
            showSnackBarWidget(message: AppStrings.unknown);
          }
        },
      ),
    ];
    scrollController.addListener(() async {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        if (pagination.nextPageUrl.isNotEmpty && !loadingMyFriendPagination) {
          await getMyFriends(isPaginate: true);
        }
      }
    });
    getMyFriends();
    super.initState();
  }

  List<SocialButtonModel> socialList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.w(context),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.sendTo,
            style: Get.textTheme.titleMedium!.copyWith(
              fontSize: AppSize.s22(context),
            ),
          ),
          20.verticalSpace(),
          Obx(
            () => loadingMyFriend
                ? const Center(child: AppLoader())
                : friends.isEmpty
                    ? const SizedBox()
                    : SizedBox(
                        height: 100,
                        child: ListView.separated(
                          controller: scrollController,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            if (index == friends.length) {
                              return const Center(
                                child: AppLoader(),
                              );
                            }
                            return InkWell(
                              onTap: () =>
                                  sendMessageToFriend(friends[index].friendId),
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(110),
                                      child: Image.network(
                                        friends[index].profileImg,
                                        width: 45,
                                        height: 45,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const AppImage(
                                          image: Constants.userErrorWidget,
                                          width: 40,
                                          height: 40,
                                          isCircle: true,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    4.verticalSpace(),
                                    Text(
                                      friends[index].name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Get.textTheme.titleSmall!.copyWith(
                                        fontSize: AppSize.s10(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) =>
                              10.horizontalSpace(),
                          itemCount: loadingMyFriendPagination
                              ? friends.length + 1
                              : friends.length,
                        ),
                      ),
          ),
          20.verticalSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              socialList.length,
              (index) {
                return InkWell(
                  onTap: socialList[index].onTap,
                  child: SizedBox(
                    width: 55,
                    height: 65,
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(110),
                          child: Image.asset(
                            socialList[index].image,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            color: socialList[index].color,
                          ),
                        ),
                        5.verticalSpace(),
                        Text(
                          socialList[index].name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Get.textTheme.titleSmall!.copyWith(
                            fontSize: AppSize.s10(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SocialButtonModel {
  String image;
  String name;
  final void Function()? onTap;
  Color? color;

  SocialButtonModel({
    required this.name,
    required this.image,
    this.color,
    this.onTap,
  });
}
