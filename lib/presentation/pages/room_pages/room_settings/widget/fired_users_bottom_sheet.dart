import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room_settings/getx/room_settings_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

class FiredUsersBottomSheet extends GetView<RoomSettingsController> {
  const FiredUsersBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.w(context),
      height: .6.h(context),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        color: ColorManager.white,
      ),
      child: Obx(
        () => controller.loadingGetFireList
            ? const Center(child: AppLoader())
            : RefreshIndicator(
                onRefresh: () => controller.getFireList(),
                child: controller.firedUsersList.isEmpty
                    ? Center(
                        child: Text(
                          AppStrings.noDataFound,
                          style: Get.textTheme.titleLarge!,
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.all(20),
                        itemBuilder: (context, index) => Row(
                          children: [
                            Container(
                              width: 55,
                              height: 55,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(110),
                                child: Image.network(
                                  controller.firedUsersList[index].profileImg,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const AppImage(
                                    image: Constants.userErrorWidget,
                                    width: 55,
                                    height: 55,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            8.horizontalSpace(),
                            Flexible(
                              fit: FlexFit.tight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.firedUsersList[index].name,
                                    style: Get.textTheme.titleLarge!.copyWith(
                                      fontSize: AppSize.s16(context),
                                    ),
                                  ),
                                  Text(
                                    "ID : ${controller.firedUsersList[index].referenceId}",
                                    style:
                                        Get.textTheme.headlineMedium!.copyWith(
                                      fontSize: AppSize.s13(context),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            8.horizontalSpace(),
                            AppButton(
                              height: 34,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              title: AppStrings.removeFromBan,
                              textStyle: Get.textTheme.bodyLarge!.copyWith(
                                fontSize: AppSize.s15(context),
                              ),
                              onTap: () {
                                Get.back();
                                controller.cancelFire(
                                  controller.firedUsersList[index].id
                                      .toString(),
                                );
                              },
                            ),
                          ],
                        ),
                        separatorBuilder: (context, index) =>
                            10.verticalSpace(),
                        itemCount: controller.firedUsersList.length,
                      ),
              ),
      ),
    );
  }
}
