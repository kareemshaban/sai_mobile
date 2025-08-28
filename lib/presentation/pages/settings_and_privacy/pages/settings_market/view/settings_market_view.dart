import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/settings_market/getx/settings_market_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:new_sai/presentation/widgets/empty_data_widget.dart';

class SettingsMarketView extends GetView<SettingsMarketController> {
  const SettingsMarketView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.store),
          actions: [
            Obx(
              () => Text(
                controller
                    .appController.user.goldValue.formatCurrencyWithoutSymbol,
                style: Get.textTheme.displayLarge!.copyWith(
                  fontSize: AppSize.s16(context),
                ),
              ),
            ),
            5.horizontalSpace(),
            const AppIcon(
              icon: IconsAssets.coins,
              width: 17,
              height: 17,
            ),
            16.horizontalSpace(),
          ],
        ),
        body: controller.loadingGetMarket
            ? const Center(child: AppLoader())
            : controller.cat.isEmpty
                ? const EmptyDataWidget()
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.1,
                      mainAxisSpacing: 10,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => Get.toNamed(
                          AppRoutes.uniquePersonalIDRoute,
                          arguments: controller.cat[index],
                        ),
                        child: Column(
                          children: [
                            AppImage(
                              image: controller.cat[index].categoryIcon,
                              width: 60,
                              height: 60,
                              radius: 10,
                            ),
                            4.verticalSpace(),
                            Text(
                              controller.cat[index].name,
                              textAlign: TextAlign.center,
                              style: Get.textTheme.titleLarge!.copyWith(
                                fontSize: AppSize.s16(context),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: controller.cat.length,
                  ),
      ),
    );
  }
}
