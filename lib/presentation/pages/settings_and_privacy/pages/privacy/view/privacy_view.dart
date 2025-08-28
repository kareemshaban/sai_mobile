import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/privacy/getx/privacy_controller.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/privacy/widgets/privacy_bottom_sheet.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/widget/setting_item.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';

class PrivacyView extends GetView<PrivacyController> {
  const PrivacyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        leading: const AppBackButton(),
        title: Text(AppStrings.privacy),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          children: [
            Container(
              width: 1.w(context),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              color: ColorManager.white,
              child: Obx(
                () => Column(
                  children: [
                    SettingItem(
                      title: AppStrings.viewProfile,
                      value: controller.appController.user.profile.tr(),
                      onTap: () {
                        Get.bottomSheet(
                          Obx(
                            () => PrivacyBottomSheet(
                              title: AppStrings.viewProfile,
                              allValue: controller.profileValue == 'all',
                              friendsValue:
                                  controller.profileValue == 'private',
                              noneValue: controller.profileValue == 'none',
                              onChangedAll: (value) async {
                                if (value == true) {
                                  controller.profileValue = 'all';
                                  final data = await controller.changePrivacy(
                                    "profile",
                                    controller.profileValue,
                                  );
                                  if (data) {
                                    controller.appController.user.profile =
                                        controller.profileValue;
                                    controller.appController.saveUser(
                                      controller.appController.user,
                                    );
                                  } else {
                                    controller.profileValue =
                                        controller.appController.user.profile;
                                  }
                                }
                              },
                              onChangedFriends: (value) async {
                                if (value == true) {
                                  controller.profileValue = 'private';
                                  final data = await controller.changePrivacy(
                                    "profile",
                                    controller.profileValue,
                                  );
                                  if (data) {
                                    controller.appController.user.profile =
                                        controller.profileValue;
                                    controller.appController.saveUser(
                                      controller.appController.user,
                                    );
                                  } else {
                                    controller.profileValue =
                                        controller.appController.user.profile;
                                  }
                                }
                              },
                              onChangedNone: (value) async {
                                if (value == true) {
                                  controller.profileValue = 'none';
                                  final data = await controller.changePrivacy(
                                    "profile",
                                    controller.profileValue,
                                  );
                                  if (data) {
                                    controller.appController.user.profile =
                                        controller.profileValue;
                                    controller.appController.saveUser(
                                      controller.appController.user,
                                    );
                                  } else {
                                    controller.profileValue =
                                        controller.appController.user.profile;
                                  }
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    19.verticalSpace(),
                    SettingItem(
                      title: AppStrings.tracking,
                      value: controller.appController.user.track.tr(),
                      onTap: () {
                        Get.bottomSheet(
                          Obx(
                            () => PrivacyBottomSheet(
                              title: AppStrings.tracking,
                              allValue: controller.trackValue == 'all',
                              friendsValue: controller.trackValue == 'private',
                              noneValue: controller.trackValue == 'none',
                              onChangedAll: (value) async {
                                if (value == true) {
                                  controller.trackValue = 'all';
                                  final data = await controller.changePrivacy(
                                    "track",
                                    controller.trackValue,
                                  );
                                  if (data) {
                                    controller.appController.user.track =
                                        controller.trackValue;
                                    controller.appController.saveUser(
                                      controller.appController.user,
                                    );
                                  } else {
                                    controller.trackValue =
                                        controller.appController.user.track;
                                  }
                                }
                              },
                              onChangedFriends: (value) async {
                                if (value == true) {
                                  controller.trackValue = 'private';
                                  final data = await controller.changePrivacy(
                                    "track",
                                    controller.trackValue,
                                  );
                                  if (data) {
                                    controller.appController.user.track =
                                        controller.trackValue;
                                    controller.appController.saveUser(
                                      controller.appController.user,
                                    );
                                  } else {
                                    controller.trackValue =
                                        controller.appController.user.track;
                                  }
                                }
                              },
                              onChangedNone: (value) async {
                                if (value == true) {
                                  controller.trackValue = 'none';
                                  final data = await controller.changePrivacy(
                                    "track",
                                    controller.trackValue,
                                  );
                                  if (data) {
                                    controller.appController.user.track =
                                        controller.trackValue;
                                    controller.appController.saveUser(
                                      controller.appController.user,
                                    );
                                  } else {
                                    controller.trackValue =
                                        controller.appController.user.track;
                                  }
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    19.verticalSpace(),
                    SettingItem(
                      title: AppStrings.messages,
                      value: controller.appController.user.comment.tr(),
                      onTap: () {
                        Get.bottomSheet(
                          Obx(
                            () => PrivacyBottomSheet(
                              title: AppStrings.sendMessage,
                              allValue: controller.messagesValue == 'all',
                              friendsValue:
                                  controller.messagesValue == 'private',
                              noneValue: controller.messagesValue == 'none',
                              onChangedAll: (value) async {
                                if (value == true) {
                                  controller.messagesValue = 'all';
                                  final data = await controller.changePrivacy(
                                    "comment",
                                    controller.messagesValue,
                                  );
                                  if (data) {
                                    controller.appController.user.comment =
                                        controller.messagesValue;
                                    controller.appController.saveUser(
                                      controller.appController.user,
                                    );
                                  } else {
                                    controller.messagesValue =
                                        controller.appController.user.comment;
                                  }
                                }
                              },
                              onChangedFriends: (value) async {
                                if (value == true) {
                                  controller.messagesValue = 'private';
                                  final data = await controller.changePrivacy(
                                    "comment",
                                    controller.messagesValue,
                                  );
                                  if (data) {
                                    controller.appController.user.comment =
                                        controller.messagesValue;
                                    controller.appController.saveUser(
                                      controller.appController.user,
                                    );
                                  } else {
                                    controller.messagesValue =
                                        controller.appController.user.comment;
                                  }
                                }
                              },
                              onChangedNone: (value) async {
                                if (value == true) {
                                  controller.messagesValue = 'none';
                                  final data = await controller.changePrivacy(
                                    "comment",
                                    controller.messagesValue,
                                  );
                                  if (data) {
                                    controller.appController.user.comment =
                                        controller.messagesValue;
                                    controller.appController.saveUser(
                                      controller.appController.user,
                                    );
                                  } else {
                                    controller.messagesValue =
                                        controller.appController.user.comment;
                                  }
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    19.verticalSpace(),
                    SettingItem(
                      title: AppStrings.yourStory,
                      value: controller.appController.user.story.tr(),
                      onTap: () {
                        Get.bottomSheet(
                          Obx(
                            () => PrivacyBottomSheet(
                              title: AppStrings.viewProfile,
                              allValue: controller.storyValue == 'all',
                              friendsValue: controller.storyValue == 'private',
                              noneValue: controller.storyValue == 'none',
                              onChangedAll: (value) async {
                                if (value == true) {
                                  controller.storyValue = 'all';
                                  final data = await controller.changePrivacy(
                                    "story",
                                    controller.storyValue,
                                  );
                                  if (data) {
                                    controller.appController.user.story =
                                        controller.storyValue;
                                    controller.appController.saveUser(
                                      controller.appController.user,
                                    );
                                  } else {
                                    controller.storyValue =
                                        controller.appController.user.story;
                                  }
                                }
                              },
                              onChangedFriends: (value) async {
                                if (value == true) {
                                  controller.storyValue = 'private';
                                  final data = await controller.changePrivacy(
                                    "story",
                                    controller.storyValue,
                                  );
                                  if (data) {
                                    controller.appController.user.story =
                                        controller.storyValue;
                                    controller.appController.saveUser(
                                      controller.appController.user,
                                    );
                                  } else {
                                    controller.storyValue =
                                        controller.appController.user.story;
                                  }
                                }
                              },
                              onChangedNone: (value) async {
                                if (value == true) {
                                  controller.storyValue = 'none';
                                  final data = await controller.changePrivacy(
                                    "story",
                                    controller.storyValue,
                                  );
                                  if (data) {
                                    controller.appController.user.story =
                                        controller.storyValue;
                                    controller.appController.saveUser(
                                      controller.appController.user,
                                    );
                                  } else {
                                    controller.storyValue =
                                        controller.appController.user.story;
                                  }
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
