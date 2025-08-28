import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/settings_entity/premium_entity.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';

class VipExclusivePrivilegeItem extends StatelessWidget {
  final PrivilegesPremiumEntity model;
  final bool isActive;
  const VipExclusivePrivilegeItem({
    super.key,
    required this.model,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 63,
          height: 63,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive
                  ? ColorManager.primary
                  : ColorManager.black.withOpacity(.4),
            ),
          ),
          child: Center(
            child: AppImage(
              image: model.icon,
              imageColor: isActive ? ColorManager.primary : null,
              width: 30,
              height: 30,
            ),
          ),
        ),
        9.verticalSpace(),
        Text(
          model.name,
          style: Get.textTheme.titleMedium!.copyWith(
            fontSize: AppSize.s15(context),
            color: isActive ? ColorManager.primary : null,
          ),
        ),
        5.verticalSpace(),
        Text(
          model.description,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Get.textTheme.titleMedium!.copyWith(
            fontSize: AppSize.s15(context),
            color: isActive
                ? ColorManager.primary
                : ColorManager.black.withOpacity(.5),
          ),
        ),
      ],
    );
  }
}
