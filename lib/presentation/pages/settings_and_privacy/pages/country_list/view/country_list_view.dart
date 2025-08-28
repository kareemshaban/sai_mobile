import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/country_list/getx/country_list_controller.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/country_list/widgets/country_item.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

class CountryListView extends GetView<CountryListController> {
  const CountryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        leadingWidth: 60,
        centerTitle: false,
        title: Text(AppStrings.countries),
      ),
      body: Obx(
        () => controller.loading
            ? const Center(child: AppLoader())
            : CustomScrollView(
                slivers: [
                  if (controller.commonCountry.isNotEmpty) ...[
                    Container(
                      width: 1.w(context),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      decoration:
                          const BoxDecoration(color: ColorManager.white),
                      child: Text(
                        AppStrings.common,
                        style: Get.textTheme.titleLarge!.copyWith(
                          fontSize: AppSize.s20(context),
                        ),
                      ),
                    ).toSliver(),
                    SliverList.builder(
                      itemBuilder: (context, index) {
                        return CountryItem(
                          country: controller.commonCountry[index],
                          onTap: (country) {
                            Get.back(result: country);
                          },
                        );
                      },
                      itemCount: controller.commonCountry.length,
                    ),
                  ],
                  if (controller.allCountry.isNotEmpty) ...[
                    Container(
                      width: 1.w(context),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      decoration:
                          const BoxDecoration(color: ColorManager.white),
                      child: Text(
                        AppStrings.all,
                        style: Get.textTheme.titleLarge!.copyWith(
                          fontSize: AppSize.s20(context),
                        ),
                      ),
                    ).toSliver(),
                    SliverList.builder(
                      itemBuilder: (context, index) {
                        return CountryItem(
                          country: controller.allCountry[index],
                          onTap: (country) {
                            Get.back(result: country);
                          },
                        );
                      },
                      itemCount: controller.allCountry.length,
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}
