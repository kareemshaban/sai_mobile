import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_widgets/gift_item.dart';
import 'package:new_sai/presentation/pages/room_pages/room/zego_handler/internal/internal.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class GiftsBottomSheet extends GetView<RoomController> {
  const GiftsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return controller.loadingGetGift
        ? const Center(child: AppLoader())
        : Container(
            width: 1.w(context),
            height: 300,
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: ColorManager.black,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                topLeft: Radius.circular(8),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => Text(
                        controller.appController.user.goldValue
                            .formatCurrencyWithoutSymbol,
                        style: Get.textTheme.titleSmall!.copyWith(
                            fontSize: AppSize.s15(context),
                            color: Colors.white),
                      ),
                    ),
                    3.horizontalSpace(),
                    const AppIcon(
                      icon: IconsAssets.coins,
                      width: 20,
                      height: 20,
                    ),
                  ],
                ),
                15.verticalSpace(),
                SizedBox(
                  height: 20,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Text(
                      controller.giftsCategories[index].name,
                      style: Get.textTheme.titleSmall!.copyWith(
                          fontSize: AppSize.s15(context), color: Colors.white),
                    ),
                    separatorBuilder: (context, index) => 10.horizontalSpace(),
                    itemCount: controller.giftsCategories.length,
                  ),
                ),
                15.verticalSpace(),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1.02,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) => Obx(
                      () => GiftItem(
                        gift: controller.gifts[index],
                        selectedGift: controller.selectedGift,
                        onTap: () {
                          if (controller.gifts[index].giftFile
                              .contains('svga')) {
                            controller.isSvg = true;
                          } else {
                            controller.isSvg = false;
                          }
                          controller.selectedGift = controller.gifts[index];
                        },
                      ),
                    ),
                    itemCount: controller.gifts.length,
                  ),
                ),
                15.verticalSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: ColorManager.primary),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          PopupMenuButton<ZegoUser>(
                            color: Colors.grey.shade800, //

                            itemBuilder: (BuildContext context) {
                              return [
                                ...controller.users
                                    .where((element) =>
                                        element.userID !=
                                        controller.user.id.toString())
                                    .toList()
                                    .map(
                                      (e) => PopupMenuItem(
                                        value: e,
                                        child: Text(e.userName,
                                            style: const TextStyle(
                                                color: Colors.white)),
                                      ),
                                    ),
                                PopupMenuItem(
                                  value: ZegoUser(
                                    AppStrings.micsUser,
                                    AppStrings.micsUser,
                                  ),
                                  child: Text(AppStrings.micsUser,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ),
                                PopupMenuItem(
                                  value: ZegoUser(
                                    AppStrings.all,
                                    AppStrings.all,
                                  ),
                                  child: Text(AppStrings.all,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ),
                              ];
                            },
                            onSelected: controller.onChangeGiftUser,
                            child: Obx(
                              () => Row(
                                children: [
                                  12.horizontalSpace(),
                                  Text(
                                    controller.selectedUserGift.userName,
                                    style: Get.textTheme.labelMedium!.copyWith(
                                      fontSize: AppSize.s12(context),
                                      color: ColorManager.white,
                                    ),
                                  ),
                                  4.horizontalSpace(),
                                  const Icon(
                                    Icons.keyboard_arrow_down,
                                    size: 20,
                                    color: ColorManager.white,
                                  ),
                                  12.horizontalSpace(),
                                ],
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              controller.selectedUserGift =
                                  ZegoUser(AppStrings.all, AppStrings.all);
                            },
                            child: Container(
                              height: 27,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: ColorManager.primary,
                                borderRadius: BorderRadiusDirectional.only(
                                  topEnd: Radius.circular(20),
                                  bottomEnd: Radius.circular(20),
                                ),
                              ),
                              child: const Icon(
                                Icons.home_work,
                                color: ColorManager.white,
                                size: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: ColorManager.primary),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Obx(
                            () => Flexible(
                              child: PopupMenuButton<int>(
                                color: Colors.grey.shade800, //
                                itemBuilder: (BuildContext context) {
                                  return controller.giftCounterItems
                                      .map(
                                        (e) => PopupMenuItem(
                                          value: e,
                                          child: Text(
                                            e.toString(),
                                            style: Get.textTheme.labelMedium!
                                                .copyWith(
                                                    fontSize:
                                                        AppSize.s12(context),
                                                    color: Colors.white),
                                          ),
                                        ),
                                      )
                                      .toList();
                                },
                                onSelected: controller.onChangeGiftCount,
                                child: Row(
                                  children: [
                                    const Spacer(),
                                    Text(
                                      controller.giftCount.toString(),
                                      style: Get.textTheme.labelMedium!
                                          .copyWith(
                                              fontSize: AppSize.s12(context),
                                              color: Colors.white),
                                    ),
                                    4.horizontalSpace(),
                                    const Icon(
                                      Icons.keyboard_arrow_down,
                                      size: 20,
                                      color: ColorManager.white,
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              print(controller.selectedGift.goldValue);

                              if (controller.selectedGift.goldValue >
                                  double.tryParse(controller
                                      .appController.user.goldValue
                                      .toString())!) {
                                Get.back();

                                showSnackBarWidget(
                                    message:
                                        AppStrings.thereIsNotEnoughBalance);
                                return;
                              } else {
                                controller.onSendGift();
                              }
                              //   print( controller.appController.user.goldValue
                              // .formatCurrencyWithoutSymbol);
                              //   print(controller.selectedGift.goldValue);
                            },
                            // onTap: controller.onSendGift,
                            child: Container(
                              height: 27,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: ColorManager.primary,
                                borderRadius: BorderRadiusDirectional.only(
                                  topEnd: Radius.circular(20),
                                  bottomEnd: Radius.circular(20),
                                ),
                              ),
                              child: Text(
                                AppStrings.send,
                                style: Get.textTheme.bodyMedium!.copyWith(
                                  fontSize: AppSize.s14(context),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
