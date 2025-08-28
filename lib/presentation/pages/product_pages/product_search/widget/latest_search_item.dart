import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/product_pages/product_search/model/last_search_local_model.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';

class LatestSearchItem extends StatelessWidget {
  final LastSearchLocalModel model;
  final void Function()? onTap;
  final void Function()? onTapDelete;
  const LatestSearchItem({
    super.key,
    required this.model,
    this.onTap,
    this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 100,
            width: 70,
            child: Column(
              children: [
                AppImage(
                  image: model.image,
                  width: 50,
                  height: 66,
                  radius: 5,
                  fit: BoxFit.cover,
                ),
                8.5.verticalSpace(),
                Text(
                  model.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Get.textTheme.titleMedium!.copyWith(
                    fontSize: AppSize.s15(context),
                  ),
                ),
              ],
            ),
          ),
        ),
        PositionedDirectional(
          end: 0,
          top: 0,
          child: InkWell(
            onTap: onTapDelete,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: ColorManager.appRedColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                color: ColorManager.white,
                size: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
