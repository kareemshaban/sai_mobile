import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/language/getx/language_controller.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';

class LanguageView extends GetView<LanguageController> {
  const LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.language),
        leading: const AppBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(
          () => Column(
            children: [
              RadioListTile(
                value: "arabic",
                groupValue: controller.language,
                onChanged: controller.onChangeLanguageValue,
                title: Text(
                  AppStrings.arabic,
                  style: Get.textTheme.titleMedium!.copyWith(
                    fontSize: AppSize.s20(context),
                  ),
                ),
              ),
              Container(
                height: 1, // Thickness of the line
                width: double.infinity, // Full width of parent
                color: Colors.grey, // Color of the line
              ),
              RadioListTile(
                value: "english",
                groupValue: controller.language,
                onChanged: controller.onChangeLanguageValue,
                title: Text(
                  AppStrings.english,
                  style: Get.textTheme.titleMedium!.copyWith(
                    fontSize: AppSize.s20(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AppButton(
        title: AppStrings.save,
        width: .7.w(context),
        onTap: () => controller.onTapSaveLanguage(context),
      ),
    );
  }
}
