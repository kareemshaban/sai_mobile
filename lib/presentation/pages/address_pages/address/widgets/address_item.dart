import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/store_entity/address_entity.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

class AddressItem extends StatelessWidget {
  final AddressEntity address;
  const AddressItem({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(
        AppRoutes.addNewAddressRoute,
        arguments: {
          'isEdit': true,
          'address': address,
        },
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 10),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              children: [
                if (address.isDefault)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: ColorManager.primary,
                    ),
                    child: Text(AppStrings.defaultText),
                  ),
                const Spacer(),
                Text(
                  AppStrings.edit,
                  style: Get.textTheme.displaySmall!.copyWith(
                    fontSize: AppSize.s16(context),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(22),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        AppStrings.name,
                        style: Get.textTheme.headlineMedium!.copyWith(
                          fontSize: AppSize.s16(context),
                        ),
                      ),
                      25.verticalSpace(),
                      Text(
                        AppStrings.address,
                        style: Get.textTheme.headlineMedium!.copyWith(
                          fontSize: AppSize.s16(context),
                        ),
                      ),
                      25.verticalSpace(),
                      Text(
                        AppStrings.mobileNumber,
                        style: Get.textTheme.headlineMedium!.copyWith(
                          fontSize: AppSize.s16(context),
                        ),
                      ),
                    ],
                  ),
                  40.horizontalSpace(),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          address.fullName,
                          style: Get.textTheme.titleMedium!.copyWith(
                            fontSize: AppSize.s16(context),
                          ),
                        ),
                        25.verticalSpace(),
                        Text(
                          "${address.country.name}, ${address.streetMark}, ${address.streetMark}",
                          style: Get.textTheme.titleMedium!.copyWith(
                            fontSize: AppSize.s16(context),
                          ),
                        ),
                        25.verticalSpace(),
                        Text(
                          address.phone,
                          style: Get.textTheme.titleMedium!.copyWith(
                            fontSize: AppSize.s16(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
