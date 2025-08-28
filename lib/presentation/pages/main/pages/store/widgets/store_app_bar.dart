import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/presentation/pages/product_pages/cart/getx/cart_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';

class StoreAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StoreAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: isGuest()
          ? null
          : Center(
              child: PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        onTap: () => Get.toNamed(AppRoutes.ordersRoute),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppStrings.orders,
                              style: Get.textTheme.titleSmall!.copyWith(
                                fontSize: AppSize.s16(context),
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: ColorManager.iconGreyColor,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () => Get.toNamed(AppRoutes.addressRoute),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppStrings.addresses,
                              style: Get.textTheme.titleSmall!.copyWith(
                                fontSize: AppSize.s16(context),
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: ColorManager.iconGreyColor,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () => Get.toNamed(AppRoutes.favoriteRoute),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppStrings.favorite,
                              style: Get.textTheme.titleSmall!.copyWith(
                                fontSize: AppSize.s16(context),
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: ColorManager.iconGreyColor,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                      if (Get.find<AppController>().isVipActive())
                        PopupMenuItem(
                          onTap: () => Get.toNamed(AppRoutes.vipRoute),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                AppStrings.saiVip,
                                style: Get.textTheme.titleSmall!.copyWith(
                                  fontSize: AppSize.s16(context),
                                ),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: ColorManager.iconGreyColor,
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                    ];
                  },
                  position: PopupMenuPosition.under,
                  child: AppIcon(
                    icon: IconsAssets.menu,
                    width: 25,
                    height: 25,
                    color: ColorManager.black.withOpacity(.85),
                  )),
            ),
      actions: [
        InkWell(
          onTap: () => Get.toNamed(AppRoutes.cartRoute),
          child: Obx(
            () => Badge.count(
              count: Get.find<CartController>().products.length,
              isLabelVisible: Get.find<CartController>().products.isNotEmpty,
              textColor: ColorManager.white,
              textStyle: Get.textTheme.bodySmall!.copyWith(
                fontSize: AppSize.s12(context),
              ),
              child: AppIcon(
                icon: IconsAssets.cart,
                width: 25,
                height: 25,
                color: ColorManager.black.withOpacity(.85),
              ),
            ),
          ),
        ),
        24.horizontalSpace(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
