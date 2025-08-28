import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/chat_entity/chat_user_info_entity.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/language_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';

class StoryHeaderWidget extends StatelessWidget {
  final bool isMyStory;
  final ChatUserInfoEntity user;
  final void Function()? onTapDelete;
  const StoryHeaderWidget({
    super.key,
    this.isMyStory = false,
    required this.user,
    this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.locale.languageCode == arabic
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Image.network(
                user.logo,
                width: 30,
                height: 30,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const AppImage(
                    image: Constants.userErrorWidget,
                    width: 30,
                    height: 30,
                    fit: BoxFit.cover,
                    isCircle: true,
                  );
                },
              ),
            ),
            8.horizontalSpace(),
            Text(
              user.name,
              style: Get.textTheme.bodySmall!.copyWith(
                fontSize: AppSize.s13(context),
              ),
            ),
            const Spacer(),
            if (isMyStory)
              PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      onTap: onTapDelete,
                      child: Text(
                        AppStrings.delete,
                        style: Get.textTheme.titleLarge!.copyWith(
                          fontSize: AppSize.s16(context),
                        ),
                      ),
                    ),
                  ];
                },
                position: PopupMenuPosition.under,
                iconColor: ColorManager.white,
              ),
          ],
        ),
      ),
    );
  }
}
