import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:new_sai/data/mapper/store_mapper.dart';
import 'package:new_sai/data/model/store_model/address_model.dart';
import 'package:new_sai/domain/entity/store_entity/address_entity.dart';
import 'package:new_sai/presentation/pages/address_pages/address/getx/address_controller.dart';
import 'package:new_sai/presentation/pages/product_pages/confirm_order/getx/confirm_order_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';

class StoreLocationWidget extends GetView<AddressController> {
  const StoreLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButtonHideUnderline(
        child: DropdownButton2<AddressEntity>(
          customButton: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcon(
                icon: IconsAssets.location,
                color: ColorManager.black.withOpacity(.85),
              ),
              Text(
                "${AppStrings.deliveryTo} - ${controller.selectedAddress.fullName}",
                style: Get.textTheme.labelSmall!.copyWith(
                  fontSize: AppSize.s14(context),
                ),
              ),
              const Icon(Icons.keyboard_arrow_down),
            ],
          ),
          underline: const SizedBox(),
          isExpanded: false,
          isDense: true,
          onChanged: (value) {
            controller.selectedAddress = value ?? AddressModel().toDomain();
            if (Get.currentRoute == AppRoutes.confirmOrderRoute) {
              Get.find<ConfirmOrderController>().getDeliveryPrice();
            }
          },
          value: controller.selectedAddress.id != 0
              ? controller.selectedAddress
              : null,
          items: [
            ...controller.addresses.map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(e.fullName),
              ),
            ),
            DropdownMenuItem(
              value: AddressEntity.fakeData,
              enabled: false,
              child: InkWell(
                onTap: () {
                  Get.back();
                  Get.toNamed(
                    AppRoutes.addNewAddressRoute,
                    arguments: {
                      'isEdit': false,
                      'address': null,
                    },
                  );
                },
                child: Text(AppStrings.addAddress),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
