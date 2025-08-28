import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/reels_entity/reels_entity.dart';
import 'package:new_sai/presentation/pages/main/pages/reels/widgets/reel_mention_bottom_sheet.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

class ReelsTextWidget extends StatelessWidget {
  final ReelsEntity model;
  final void Function()? onTapOnUserProfile;
  final void Function(int id) onTapOnMentionUser;
  const ReelsTextWidget({
    super.key,
    required this.model,
    this.onTapOnUserProfile,
    required this.onTapOnMentionUser,
  });

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      bottom: 0,
      child: Container(
        width: 1.w(context) - 60,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: const BorderRadiusDirectional.only(
            topEnd: Radius.circular(10),
            bottomEnd: Radius.circular(10),
          ),
          gradient: LinearGradient(
            colors: [
              ColorManager.black.withOpacity(.4),
              ColorManager.black.withOpacity(.02),
            ],
            begin: AlignmentDirectional.centerStart,
            end: AlignmentDirectional.centerEnd,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 3,
              children: [
                InkWell(
                  onTap: onTapOnUserProfile,
                  child: Text(
                    model.user.name,
                    style: Get.textTheme.bodyLarge!.copyWith(
                      fontSize: AppSize.s15(context),
                    ),
                  ),
                ),
                if (model.mentions.isNotEmpty) ...[
                  Text(
                    AppStrings.with1,
                    style: Get.textTheme.bodySmall!.copyWith(
                      fontSize: AppSize.s15(context),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      onTapOnMentionUser(model.mentions.first.id);
                    },
                    child: Text(
                      model.mentions.first.name,
                      style: Get.textTheme.bodyLarge!.copyWith(
                        fontSize: AppSize.s15(context),
                      ),
                    ),
                  ),
                ],
                if (model.mentions.length > 1)
                  InkWell(
                    onTap: () => Get.bottomSheet(
                      ReelMentionBottomSheet(
                        mentions: model.mentions,
                        user: model.user,
                      ),
                      isScrollControlled: true,
                    ),
                    child: Text(
                      AppStrings.andOthers(model.mentions.length - 1),
                      style: Get.textTheme.bodyLarge!.copyWith(
                        fontSize: AppSize.s15(context),
                      ),
                    ),
                  ),
              ],
            ),
            if (model.description.isNotEmpty) ...[
              3.verticalSpace(),
              Text(
                model.description,
                style: Get.textTheme.bodySmall!.copyWith(
                  fontSize: AppSize.s12(context),
                ),
              ),
            ],
            if (model.location.isNotEmpty) ...[
              3.verticalSpace(),
              Text(
                model.location,
                style: Get.textTheme.bodySmall!.copyWith(
                  fontSize: AppSize.s12(context),
                ),
              ),
            ],
            if (model.tag.isNotEmpty) ...[
              Wrap(
                children: model.tag
                    .map((tags) => Text(
                          "$tags ,",
                          style: Get.textTheme.bodySmall!.copyWith(
                            fontSize: AppSize.s12(context),
                          ),
                        ))
                    .toList(),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
