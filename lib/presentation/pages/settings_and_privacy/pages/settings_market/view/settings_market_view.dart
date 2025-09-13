import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/settings_market/getx/settings_market_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
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
                  fontSize: AppSize.s18(context),
                ),
              ),
            ),
            5.horizontalSpace(),
           const Padding(
              padding: EdgeInsets.only(bottom: 5.0),
              child:  AppIcon(
                icon: IconsAssets.coins,
                width: 20,
                height: 20,
              ),
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
                      crossAxisCount: 2,
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
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white54 , borderRadius: BorderRadius.circular(15.0) ,
                              border: Border.all(color: Colors.grey.withAlpha(70) , width: 3.0) ),
                          margin: EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                maxLines: 1, // Limits to one line
                                overflow: TextOverflow.ellipsis, // Adds "..." on overflow
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: controller.cat.length,
                  ),
      ),
    );
  }
}
