import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/posts/post_settings/getx/post_settings_controller.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:new_sai/presentation/widgets/empty_data_widget.dart';

class MyFriendsWidget extends GetView<PostSettingsController> {
  const MyFriendsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostSettingsController>(
        id: 'firends_Botttom_sheet',
        builder: (controller) {
          if (controller.isFirendsListLoading) {
            return const Center(
              child: AppLoader(),
            );
          } else {
            if (controller.myFirendsList.isEmpty) {
              return const EmptyDataWidget();
            } else {
              return Column(
                children: [
                  Flexible(
                    flex: 10,
                    fit: FlexFit.tight,
                    child: ListView.separated(
                        controller: controller.friendsListScrollController,
                        itemCount: controller.myFirendsList.length,
                        separatorBuilder: (_, __) => 20.verticalSpace(),
                        itemBuilder: (_, index) {
                          return Row(
                            children: [
                              AppImage(
                                image: controller
                                    .myFirendsList[index].friend.profileImg,
                                width: 55,
                                height: 55,
                                fit: BoxFit.cover,
                                isCircle: true,
                              ),
                              15.horizontalSpace(),
                              Flexible(
                                fit: FlexFit.tight,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller
                                          .myFirendsList[index].friend.name,
                                      style: Get.textTheme.titleSmall!.copyWith(
                                        fontSize: AppSize.s20(context),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Checkbox(
                                  value: controller
                                      .myFirendsList[index].isSelected,
                                  onChanged: (isChecked) {
                                    controller.checkFriend(index, isChecked!);
                                  })
                            ],
                          );
                        }),
                  ),
                  Flexible(
                    flex: 0,
                    child: Row(
                      children: [
                        AppButton(
                          title: AppStrings.ok,
                          onTap: () {
                            controller.confirmFriendsList();
                            Get.back();
                          },
                        ),
                        10.horizontalSpace(),
                        AppButton(
                            title: AppStrings.cancel,
                            onTap: () {
                              Get.back();
                            }),
                      ],
                    ),
                  )
                ],
              );
            }
          }
        });
  }

  // bool _isLastData(index) {
  //   if (controller.isLastFriendPage) {
  //     return true;
  //   } else {
  //     controller.getMyFriends();
  //     return false;
  //   }
  // }
}
