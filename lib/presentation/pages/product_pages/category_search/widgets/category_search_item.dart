import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/domain/entity/store_entity/category_entity.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';

class CategorySearchItem extends StatelessWidget {
  final CategoryEntity model;
  final bool isSelected;
  final void Function()? onTap;
  const CategorySearchItem({
    super.key,
    required this.model,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected ? ColorManager.primary : ColorManager.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          model.name,
          style: Get.textTheme.bodyLarge!.copyWith(
            fontSize: AppSize.s12(context),
            color: isSelected ? null : ColorManager.black,
          ),
        ),
      ),
    );
  }
}
