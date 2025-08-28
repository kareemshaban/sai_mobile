import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

class AddNewAddressWidget extends StatelessWidget {
  const AddNewAddressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(
        AppRoutes.addNewAddressRoute,
        arguments: {
          'isEdit': false,
          'address': null,
        },
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
        width: 1.w(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorManager.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.addNewAddress,
              style: Get.textTheme.titleSmall!.copyWith(
                fontSize: AppSize.s18(context),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: ColorManager.iconGreyColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
