import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/wallet_pages/wallet/getx/wallet_controller.dart';
import 'package:new_sai/presentation/pages/wallet_pages/wallet/widget/wallet_coins.dart';
import 'package:new_sai/presentation/pages/wallet_pages/wallet/widget/wallet_rewards.dart';
import 'package:new_sai/presentation/pages/wallet_pages/wallet/widget/wallet_tab_bar.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';

class WalletView extends GetView<WalletController> {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        leading: const AppBackButton(),
        title: Text(AppStrings.wallet),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: WalletTabBar(),
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: const [
       //   WalletRewards(),
          WalletCoins(),
        ],
      ),
    );
  }
}
