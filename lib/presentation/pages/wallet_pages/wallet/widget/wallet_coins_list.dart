import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/wallet_pages/wallet/getx/wallet_controller.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

import 'record_item.dart';

class WalletCoinsList extends GetView<WalletController> {
  const WalletCoinsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loadingGift
          ? const Center(child: AppLoader())
          : controller.gifts.isEmpty
              ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.noDataFound,
                    style: Get.textTheme.titleMedium!.copyWith(
                      fontSize: AppSize.s16(context),
                    ),
                  ),
                ],
              )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => RecordItem(
                          model: controller.gifts[index],
                        ),
                        separatorBuilder: (context, index) =>
                            17.verticalSpace(),
                        itemCount: controller.gifts.length,
                      ),
                    ),
                    if (controller.loadingGiftPagination)
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(child: AppLoader()),
                      )
                  ],
                ),
    );
  }
}
