import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_validation.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/settings_entity/record_entity.dart';
import 'package:new_sai/presentation/pages/wallet_pages/cash_withdrawal/getx/cash_withdrawal_controller.dart';
import 'package:new_sai/presentation/pages/wallet_pages/cash_withdrawal/widget/cash_withdrawal_tab_bar.dart';
import 'package:new_sai/presentation/pages/wallet_pages/wallet/widget/record_item.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_form_filed.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

class CashWithdrawalView extends GetView<CashWithdrawalController> {
  const CashWithdrawalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        leadingWidth: 60,
        title: Text(AppStrings.cashWithDrawal),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: CashWithdrawalTabBar(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: controller.formKey,
          child: TabBarView(
            controller: controller.tabController,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.paymentMethod,
                    style: Get.textTheme.titleMedium!.copyWith(
                      fontSize: AppSize.s15(context),
                    ),
                  ),
                  15.verticalSpace(),
                  GestureDetector(
                    onTap: controller.onGoToNextPage,
                    child: Container(
                      width: 1.w(context),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorManager.white,
                      ),
                      child: Row(
                        children: [
                          12.horizontalSpace(),
                          Text(
                            AppStrings.addPaymentMethod,
                            style: Get.textTheme.titleSmall!.copyWith(
                              fontSize: AppSize.s15(context),
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: ColorManager.iconGreyColor,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  15.verticalSpace(),
                  Text(
                    AppStrings.withdrawalAmount,
                    style: Get.textTheme.titleMedium!.copyWith(
                      fontSize: AppSize.s15(context),
                    ),
                  ),
                  15.verticalSpace(),
                  Obx(
                        () {
                      if (controller.isLoading) return Container();
                      return AppFormFiled(
                        borderColor: ColorManager.transparent,
                        borderRadius: 10,
                        type: TextInputType.number,
                        controller: controller.goldValueController,
                        validator: (value) => AppValidation.validateRedeemes(
                          value,
                          // controller.appController.user.goldValue,
                          controller.unitEntity?.userGold ?? 0,
                        ),
                        prefixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            10.horizontalSpace(),
                            const AppIcon(
                              icon: IconsAssets.coins,
                              width: 26,
                              height: 26,
                            ),
                          ],
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            10.horizontalSpace(),
                            InkWell(
                              onTap: controller.onTapAll,
                              child: Text(
                                AppStrings.all,
                                style: Get.textTheme.displaySmall!.copyWith(
                                  fontSize: AppSize.s15(context),
                                ),
                              ),
                            ),
                            14.horizontalSpace(),
                          ],
                        ),
                        hint:
                        //   "${AppStrings.available} ${controller.appController.user.goldValue.formatCurrencyWithoutSymbol}",
                        "${AppStrings.available} ${controller.unitEntity?.userGold.formatCurrency(context)}",
                      );
                    },
                  ),
                  10.verticalSpace(),
                  Obx(() {
                    if (controller.total != 0) {
                      return Row(
                        children: [
                          Flexible(
                            child: Text(
                              "${AppStrings.total} = ${controller.total.formatCurrencyWithoutSymbol} ${AppStrings.sar}",
                              style: Get.textTheme.labelLarge!.copyWith(
                                fontSize: AppSize.s16(context),
                              ),
                            ),
                          ),
                          5.horizontalSpace(),
                          const AppIcon(
                            icon: IconsAssets.sar,
                            width: 20,
                            height: 20,
                          )
                        ],
                      );
                    }
                    return const SizedBox();
                  }),


                ],
              ),
              Obx(
                    () => Expanded(
                  child: controller.getMyRecord
                      ? const Center(child: AppLoader())
                      : controller.records.isEmpty
                      ? Center(
                    child: Text(
                      AppStrings.noDataFound,
                      style: Get.textTheme.titleMedium!.copyWith(
                        fontSize: AppSize.s16(context),
                      ),
                    ),
                  )
                      : ListView.separated(
                    itemBuilder: (context, index) => RecordItem(
                      model: RecordEntity(
                        id: controller.records[index].id,
                        toId: 0,
                        user: AppStrings.withdraw,
                        goldValue:
                        controller.records[index].redeemTotal,
                        date: controller.records[index].date,
                      ),
                      withCoins: false,
                    ),
                    separatorBuilder: (context, index) =>
                        17.verticalSpace(),
                    itemCount: controller.records.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
