import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:new_sai/app/app_validation.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/posts/post_settings/getx/post_settings_controller.dart';
import 'package:new_sai/presentation/pages/posts/post_settings/widgets/my_friends_widget.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/privacy/widgets/privacy_bottom_sheet.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/widget/setting_item.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_form_filed.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

class PostSettingsView extends GetView<PostSettingsController> {
  const PostSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        leading: const AppBackButton(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: MediaQuery.viewInsetsOf(context).bottom != 0
          ? null
          : Obx(
              () => controller.isLoading
                  ? SizedBox(
                      height: 44,
                      width: 0.7.w(context),
                      child: const Center(
                        child: AppLoader(),
                      ),
                    )
                  : AppButton(
                      title: AppStrings.publish,
                      width: .7.w(context),
                      onTap: controller.onTapPost,
                    ),
            ),
      body: GetBuilder<PostSettingsController>(
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(
                //   width: 173,
                //   height: 105,
                //   color: ColorManager.primary,
                //   alignment: Alignment.bottomCenter,
                //   child: Container(
                //     width: 173,
                //     height: 29,
                //     alignment: Alignment.center,
                //     color: ColorManager.black.withOpacity(.6),
                //     child: Text(
                //       AppStrings.editCover,
                //       style: Get.textTheme.bodySmall!.copyWith(
                //         fontSize: AppSize.s13(context),
                //       ),
                //     ),
                //   ),
                // ),
                // 20.verticalSpace(),
                AppFormFiled(
                  filledColor: ColorManager.transparent,
                  borderColor: ColorManager.transparent,
                  hint: AppStrings.addDescription,
                  controller: controller.descController,
                ),
                20.verticalSpace(),
                Row(
                  children: [
                    if (!controller.isStory)
                      InkWell(
                        onTap: () {
                          openHashTagBottomSheet(context);
                        },
                        child: Container(
                          margin: const EdgeInsetsDirectional.only(end: 9),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: ColorManager.lightGreyColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            "# ${AppStrings.addHashTag}",
                            style: Get.textTheme.titleSmall!.copyWith(
                              fontSize: AppSize.s15(context),
                            ),
                          ),
                        ),
                      ),
                    InkWell(
                      onTap: () {
                        openMyFriendsBottomSheet(context);
                      },
                      child: Container(
                        margin: const EdgeInsetsDirectional.only(end: 9),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: ColorManager.lightGreyColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "@ ${AppStrings.mention}",
                          style: Get.textTheme.titleSmall!.copyWith(
                            fontSize: AppSize.s15(context),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                20.verticalSpace(),
                SizedBox(
                  height: controller.chosedFriends.isNotEmpty ? 30 : 0,
                  child: ListView.separated(
                      separatorBuilder: (_, __) => 2.horizontalSpace(),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.chosedFriends.length,
                      itemBuilder: (_, index) {
                        return InkWell(
                          onTap: () => Get.toNamed(
                            AppRoutes.userProfileRoute,
                            arguments: {
                              'id': controller
                                  .chosedFriends[index].friend.friendId,
                              'isFromChat': false,
                            },
                          ),
                          child: Text(
                            "${controller.chosedFriends[index].friend.name}@",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(fontSize: AppSize.s20(context)),
                          ),
                        );
                      }),
                ),
                20.verticalSpace(),
                SizedBox(
                  height: controller.hashTagsList.isNotEmpty ? 60 : 0,
                  child: ListView.separated(
                      separatorBuilder: (_, __) => 10.horizontalSpace(),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.hashTagsList.length,
                      itemBuilder: (_, index) {
                        return SizedBox(
                          child: Chip(
                            labelPadding: const EdgeInsets.all(4),
                            onDeleted: () {
                              controller.removeHashTag(index);
                            },
                            deleteIcon: const Icon(
                              Icons.close,
                              size: 25,
                            ),
                            label: Text(controller.hashTagsList[index]),
                          ),
                        );
                      }),
                ),
                38.verticalSpace(),
                SettingItem(
                  onTap: () {
                    openLocationBottomSheet(context);
                  },
                  value: controller.locationString,
                  title: AppStrings.addLocation,
                  icon: IconsAssets.location,
                ),
                29.verticalSpace(),
                SettingItem(
                  title: AppStrings.addLink,
                  iconData: Icons.add,
                  value: controller.linkStirng,
                  onTap: () {
                    openLinkBottomSheet(context);
                  },
                ),
                29.verticalSpace(),
                SettingItem(
                  title: AppStrings.viewPost,
                  iconData: Icons.language,
                  value: controller.viewPostValue == "friend"
                      ? AppStrings.friends
                      : controller.viewPostValue.tr(),
                  onTap: () {
                    Get.bottomSheet(
                      Obx(
                        () => PrivacyBottomSheet(
                          title: AppStrings.viewPost,
                          allValue: controller.viewPostValue == 'all',
                          friendsValue: controller.viewPostValue == 'friend',
                          noneValue: controller.viewPostValue == 'none',
                          onChangedAll: (value) async {
                            if (value == true) {
                              controller.viewPostValue = 'all';
                              controller.storyParameter.copyWith(
                                  viewState: controller.viewPostValue);
                              controller.update();
                              Get.back();
                            }
                          },
                          onChangedFriends: (value) async {
                            if (value == true) {
                              controller.viewPostValue = 'friend';
                              controller.storyParameter.copyWith(
                                  viewState: controller.viewPostValue);
                              controller.update();
                              Get.back();
                            }
                          },
                          onChangedNone: (value) async {
                            if (value == true) {
                              controller.viewPostValue = 'none';
                              controller.storyParameter.copyWith(
                                  viewState: controller.viewPostValue);
                              controller.update();
                              Get.back();
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
                29.verticalSpace(),
                SettingItem(
                  title: AppStrings.allowComments,
                  icon: IconsAssets.commentFill,
                  isSwitch: true,
                  switchValue: controller.canComment,
                  onTap: controller.changeCommentState,
                ),
                // 29.verticalSpace(),
                // Row(
                //   children: [
                //     const Icon(
                //       Icons.reply,
                //       color: ColorManager.iconGreyColor,
                //     ),
                //     7.horizontalSpace(),
                //     Text(
                //       AppStrings.shareTo,
                //       style: Get.textTheme.titleSmall!.copyWith(
                //         fontSize: AppSize.s18(context),
                //       ),
                //     ),
                //     const Spacer(),
                //     const AppIcon(
                //       icon: IconsAssets.whatsApp,
                //       width: 18,
                //       height: 18,
                //     ),
                //     3.horizontalSpace(),
                //     const AppIcon(
                //       icon: IconsAssets.instagram,
                //       width: 18,
                //       height: 18,
                //     ),
                //     3.horizontalSpace(),
                //     const AppIcon(
                //       icon: IconsAssets.facebook,
                //       width: 18,
                //       height: 18,
                //     ),
                //   ],
                // ),
              ],
            ),
          );
        },
      ),
    );
  }

  openLinkBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        height: 0.3.h(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorManager.white,
        ),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppFormFiled(
                suffixIcon: const Icon(Icons.link_outlined),
                controller: controller.linkTextControlle,
                label: AppStrings.addLink,
                validator: AppValidation.validateLink,
                textAlign: TextAlign.start,
                textDirection: TextDirection.ltr,
              ),
              20.verticalSpace(),
              Row(
                children: [
                  AppButton(
                    title: AppStrings.ok,
                    onTap: () {
                      controller.changeLink(false);
                    },
                  ),
                  10.horizontalSpace(),
                  AppButton(
                      title: AppStrings.cancel,
                      onTap: () {
                        controller.changeLink(true);
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  openLocationBottomSheet(BuildContext context) async {
    controller.getUserLocation(context);
    Get.bottomSheet(
      Container(
        height: 0.3.h(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorManager.white,
        ),
        child: Obx(() => Center(
              child: controller.placemark.country == null
                  ? const AppLoader()
                  : Column(
                      children: [
                        20.verticalSpace(),
                        Text(
                          "${controller.placemark.country} - ${controller.placemark.locality}",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        40.verticalSpace(),
                        AppButton(
                          title: AppStrings.addLocation,
                          onTap: controller.acceptLocation,
                        ),
                        10.verticalSpace(),
                        AppButton(
                          title: AppStrings.cancel,
                          onTap: controller.deleteLocation,
                        )
                      ],
                    ),
            )),
      ),
    );
  }

  openHashTagBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        height: 0.3.h(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: ColorManager.white,
        ),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppFormFiled(
                prefixIcon: Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "#",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 20),
                  ),
                ),
                validator: AppValidation.validateEmpty,
                controller: controller.hashTagTextController,
                label: AppStrings.hashtags,
              ),
              20.verticalSpace(),
              Row(
                children: [
                  AppButton(
                    title: AppStrings.addHashTag,
                    onTap: () {
                      controller.addHashTag();
                    },
                  ),
                  10.horizontalSpace(),
                  AppButton(
                      title: AppStrings.cancel,
                      onTap: () {
                        Get.back();
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  openMyFriendsBottomSheet(BuildContext context) {
    controller.myFirendsList.clear();
    controller.isLastFriendPage = false;
    controller.friendsPage = 1;
    controller.getMyFriends(isPaginate: false);
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => Container(
              height: 0.8.h(context),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ColorManager.white,
              ),
              child: const MyFriendsWidget(),
            ));
  }
}
