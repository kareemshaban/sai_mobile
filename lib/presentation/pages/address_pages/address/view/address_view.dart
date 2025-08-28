import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/address_pages/address/getx/address_controller.dart';
import 'package:new_sai/presentation/pages/address_pages/address/widgets/add_new_address_widget.dart';
import 'package:new_sai/presentation/pages/address_pages/address/widgets/address_item.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_loading/address_loading_item.dart';
import 'package:new_sai/presentation/widgets/empty_data_widget.dart';

class AddressView extends GetView<AddressController> {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        leading: const AppBackButton(),
        title: Text(
          AppStrings.addresses,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Obx(
          () => RefreshIndicator(
            onRefresh: () => controller.getMyAddress(),
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: 16),
                  sliver: const AddNewAddressWidget().toSliver(),
                ),
                if (controller.loading)
                  SliverList.separated(
                    separatorBuilder: (context, index) => 10.verticalSpace(),
                    itemBuilder: (context, index) => const AddressLoadingItem(),
                    itemCount: 2,
                  )
                else
                  controller.addresses.isEmpty
                      ? const SliverFillRemaining(
                          hasScrollBody: false,
                          child: EmptyDataWidget(),
                        )
                      : SliverList.separated(
                          separatorBuilder: (context, index) =>
                              10.verticalSpace(),
                          itemBuilder: (context, index) => AddressItem(
                            address: controller.addresses[index],
                          ),
                          itemCount: controller.addresses.length,
                        ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
