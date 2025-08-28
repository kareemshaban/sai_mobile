import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/terms_privacy/getx/terms_privacy_controller.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

class TermsPrivacyView extends GetView<TermsPrivacyController> {
  const TermsPrivacyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: const AppBackButton(),
          title: controller.loading ? null : Text(controller.data.pageName),
        ),
        body: controller.loading
            ? const Center(child: AppLoader())
            : SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: HtmlWidget(
                  controller.data.description,
                  textStyle: Get.textTheme.titleMedium!.copyWith(
                    fontSize: AppSize.s17(context),
                    height: 2,
                  ),
                ),
              ),
      ),
    );
  }
}
