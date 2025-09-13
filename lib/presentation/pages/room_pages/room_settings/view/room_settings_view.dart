import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room_settings/getx/room_settings_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/room_settings/widget/custom_room_settings_filed.dart';
import 'package:new_sai/presentation/pages/room_pages/room_settings/widget/fired_users_bottom_sheet.dart';
import 'package:new_sai/presentation/pages/room_pages/room_settings/widget/room_image_bottom_sheet.dart';
import 'package:new_sai/presentation/pages/room_pages/room_settings/widget/room_setting_item.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

class RoomSettingsView extends GetView<RoomSettingsController> {
  const RoomSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        leadingWidth: 60,
        title: Text(AppStrings.roomSettings),
      ),
      body: Obx(
        () => controller.loadingGetSettings
            ? const Center(child: AppLoader())
            : Column(
                children: [
                  34.verticalSpace(),
                  Obx(
                    () => RoomSettingItem(
                      title: AppStrings.roomImage,
                      roomImage: controller.imagePath.isNotEmpty
                          ? controller.imagePath
                          : controller.settings.profileImage,
                      isFileImage: controller.imagePath.isNotEmpty,
                      onTap: () =>
                          Get.bottomSheet(const RoomImageBottomSheet()),
                    ),
                  ),
                  RoomSettingItem(
                    title: AppStrings.roomName,
                    value: controller.roomName,
                    onTap: () async {
                      controller.roomName = await Get.bottomSheet(
                            CustomRoomSettingsFiled(
                              title: AppStrings.changeRoomName,
                              value: controller.roomName,
                            ),
                          ) ??
                          controller.roomName;
                    },
                  ),
                  RoomSettingItem(
                    title: AppStrings.roomNotification,
                    value: controller.roomNotification,
                    onTap: () async {
                      controller.roomNotification = await Get.bottomSheet(
                            CustomRoomSettingsFiled(
                              title: AppStrings.changeRoomNotification,
                              value: controller.roomNotification,
                            ),
                          ) ??
                          controller.roomNotification;
                    },
                  ),
                  RoomSettingItem(
                    title: AppStrings.membershipFees,
                    value: controller.membershipFee,
                    onTap: () async {
                      controller.membershipFee = await Get.bottomSheet(
                            CustomRoomSettingsFiled(
                              title: AppStrings.changeMembershipFee,
                              value: controller.membershipFee,
                              membershipFee: true,
                            ),
                          ) ??
                          controller.membershipFee;
                    },
                  ),
                  Container(
                    color: ColorManager.white,
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        DropdownButton2<int>(
                          items: [7, 8, 14]
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e.toString(),
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            controller.micCount = value;
                          },
                          value: controller.micCount,
                          underline: const SizedBox(),
                          customButton: RoomSettingItem(
                            title: AppStrings.micCount,
                            value: controller.micCount.toString(),
                            color: ColorManager.white,
                          ),
                        ),
                        RoomSettingItem(
                          title: AppStrings.noEntry,
                          value: controller.firedUsersList.length.toString(),
                          color: ColorManager.white,
                          onTap: () {
                            controller.getFireList();
                            Get.bottomSheet(const FiredUsersBottomSheet());
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Obx(
        () => controller.loadingGetSettings
            ? const SizedBox()
            : AppButton(
                title: AppStrings.save,
                onTap: controller.upadteSettings,
                width: .8.w(context),
              ),
      ),
    );
  }
}
