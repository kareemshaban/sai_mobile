import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/store_entity/category_entity.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';

class CategoryItem extends StatelessWidget {
  final CategoryEntity category;
  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(
        AppRoutes.categorySearchRoute,
        arguments: category,
      ),
      child: Container(
        width: .279.w(context),
        height: 77,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            AppImage(
              image: category.image,
              radius: 8,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                color: ColorManager.black.withOpacity(.25),
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(
                category.name,
                style: Get.textTheme.bodySmall!.copyWith(
                  fontSize: AppSize.s14(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
