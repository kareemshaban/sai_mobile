import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:new_sai/app/app_validation.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/auth/login_register/controller/login_register_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/resources/theme_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_form_filed.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:new_sai/presentation/widgets/eye_for_password.dart';
import 'package:new_sai/presentation/widgets/flag_for_form_filed.dart';
import 'package:new_sai/presentation/widgets/tab_widget.dart';

class LoginRegisterView extends GetView<LoginRegisterController> {
  const LoginRegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 20.0,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomScrollView(
            slivers: [
              Obx(
                () => Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      50.verticalSpace(),
                      Center(
                        child: Image.asset(
                          ImageAssets.logo,
                          width: 160,
                          height: 160,
                        ),
                      ),
                      18.verticalSpace(),
                      Center(
                        child: Text(
                          AppStrings.signWithUsToEnjoyAllTheFeatures,
                          style: Get.textTheme.titleSmall!.copyWith(
                            fontSize: AppSize.s17(context),
                          ),
                        ),
                      ),
                      18.verticalSpace(),
                      DefaultTabController(
                        length: 2,
                        child: Container(
                          height: 38,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 56.0),
                          decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: getBoxShadow(),
                          ),
                          child: TabBar(
                            onTap: (value) {
                              controller.clearData();
                            },
                            controller: controller.tabController,
                            indicatorColor: ColorManager.transparent,
                            indicatorSize: TabBarIndicatorSize.tab,
                            dividerColor: ColorManager.transparent,
                            tabs: [
                              Tab(
                                height: 38,
                                child: TabWidget(
                                  isActive: controller.tabIndex == 0,
                                  title: AppStrings.createAccount,
                                ),
                              ),
                              Tab(
                                height: 38,
                                child: TabWidget(
                                  isActive: controller.tabIndex == 1,
                                  title: AppStrings.login,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      24.verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: AppFormFiled(
                            validator: AppValidation.validatePhone,
                            controller: controller.phoneController,
                            type: TextInputType.phone,
                            prefixIcon: FlagForFormFiled(
                              flag: controller.flag,
                              code: controller.countryCode,
                              onTap: () =>
                                  controller.showCountryPicker(context),
                            ),
                          ),
                        ),
                      ),
                      if (controller.tabIndex == 1) ...[
                        24.verticalSpace(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: AppFormFiled(
                            validator: AppValidation.validatePassword,
                            isPassword: controller.isPassword,
                            controller: controller.passwordController,
                            prefixIcon: EyeForPassword(
                              isPassword: controller.isPassword,
                              onTap: controller.toggleIsPassword,
                            ),
                            onSubmit: (value) {
                              controller.login();
                            },
                          ),
                        ),
                        2.verticalSpace(),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: InkWell(
                            onTap: () =>
                                Get.toNamed(AppRoutes.forgetPasswordRoute),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
                              child: Text(
                                AppStrings.forgotYourPassword,
                                style: Get.textTheme.displaySmall!.copyWith(
                                  fontSize: AppSize.s14(context),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                      28.verticalSpace(),
                      if (controller.loading)
                        const Center(child: AppLoader())
                      else
                        AppButton(
                          title: controller.tabIndex == 1
                              ? AppStrings.login
                              : AppStrings.next,
                          onTap: () {
                            if (controller.tabIndex == 1) {
                              controller.login();
                            } else {
                              controller.register();
                            }
                          },
                          width: 1.w(context),
                          margin: const EdgeInsets.symmetric(horizontal: 35),
                        ),
                      21.verticalSpace(),
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(),
                          ),
                          10.horizontalSpace(),
                          Text(
                            AppStrings.or,
                            style: Get.textTheme.headlineLarge,
                          ),
                          10.horizontalSpace(),
                          const Expanded(
                            child: Divider(),
                          ),
                        ],
                      ),
                      21.verticalSpace(),
                      AppButton(
                        title: AppStrings.skipRegistration,
                        width: 1.w(context),
                        onTap: () {
                          Get.offAllNamed(AppRoutes.mainRoute);
                        },
                        margin: const EdgeInsets.symmetric(horizontal: 35),
                      ),
                    ],
                  ),
                ),
              ).toSliver(),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    const Expanded(child: SizedBox()),
                    InkWell(
                      onTap: () => Get.toNamed(
                        AppRoutes.termsPrivacyRoute,
                        arguments: 2,
                      ),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${AppStrings.byContinuingYouAgreeTo}\n",
                              style: Get.textTheme.titleSmall!.copyWith(
                                fontSize: AppSize.s18(context),
                              ),
                            ),
                            TextSpan(
                              text: AppStrings.termsOfServiceAndPrivacyPolicy,
                              style: Get.textTheme.displaySmall!.copyWith(
                                fontSize: AppSize.s20(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    45.verticalSpace(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
