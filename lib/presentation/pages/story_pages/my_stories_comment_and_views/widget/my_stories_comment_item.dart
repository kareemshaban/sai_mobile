import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/reels_entity/reels_comment_entity.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';

class MyStoriesCommentItem extends StatelessWidget {
  final ReelsCommentEntity model;
  const MyStoriesCommentItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(
        AppRoutes.userProfileRoute,
        arguments: {
          'id': model.user.id,
          'isFromChat': false,
        },
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(80),
            child: Image.network(
              model.user.logo,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const AppImage(
                  image: Constants.userErrorWidget,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  isCircle: true,
                );
              },
            ),
          ),
          10.horizontalSpace(),
          Flexible(
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.user.name,
                  style: Get.textTheme.titleSmall!.copyWith(
                    fontSize: AppSize.s15(context),
                  ),
                ),
                Text(
                  model.comment,
                  style: Get.textTheme.titleSmall!.copyWith(
                    fontSize: AppSize.s15(context),
                  ),
                ),
                Text(
                  model.createdAt,
                  style: Get.textTheme.titleSmall!.copyWith(
                    fontSize: AppSize.s12(context),
                    color: ColorManager.black.withOpacity(.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
