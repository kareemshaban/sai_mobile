import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

import 'balance_card.dart';
import 'wallet_rewards_list.dart';

class WalletRewards extends StatelessWidget {
  const WalletRewards({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BalanceCard(),
          50.verticalSpace(),
          Text(
            AppStrings.record,
            style: Get.textTheme.titleMedium!.copyWith(
              fontSize: AppSize.s15(context),
            ),
          ),
          20.verticalSpace(),
          const WalletRewardsList(),
        ],
      ),
    );
  }
}
