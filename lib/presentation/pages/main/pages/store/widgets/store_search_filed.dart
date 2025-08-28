import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_form_filed.dart';

class StoreSearchFiled extends StatelessWidget {
  const StoreSearchFiled({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          ImageAssets.logo,
          width: 42,
          height: 42,
        ),
        7.horizontalSpace(),
        Flexible(
          child: AppFormFiled(
            prefixIcon: const Icon(
              Icons.search,
              color: ColorManager.iconGreyColor2,
            ),
            readOnly: true,
            onTap: () => Get.toNamed(AppRoutes.productSearchRoute),
            hint: AppStrings.findYourProduct,
            suffixIcon: const Icon(
              Icons.filter_list_sharp,
              color: ColorManager.iconGreyColor2,
            ),
          ),
        ),
      ],
    );
  }
}
