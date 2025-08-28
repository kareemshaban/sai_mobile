import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/auth_entity/user_entity.dart';
import 'package:new_sai/domain/entity/chat_entity/chat_user_info_entity.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';

class ReelMentionBottomSheet extends StatelessWidget {
  final ChatUserInfoEntity user;
  final List<UserEntity> mentions;
  const ReelMentionBottomSheet({
    super.key,
    required this.mentions,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: 1.w(context),
        maxHeight: .7.h(context),
      ),
      decoration: const BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20),
        itemBuilder: (context, index) {
          if (index == 0) {
            return InkWell(
              onTap: () {
                Get.back();
                Get.toNamed(
                  AppRoutes.userProfileRoute,
                  arguments: {
                    'id': user.id,
                    'isFromChat': false,
                  },
                );
              },
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      user.logo,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const AppImage(
                        image: Constants.userErrorWidget,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        isCircle: true,
                      ),
                    ),
                  ),
                  10.horizontalSpace(),
                  Flexible(
                    child: Text(
                      user.name,
                      style: Get.textTheme.titleLarge!.copyWith(
                        fontSize: AppSize.s16(context),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return InkWell(
            onTap: () {
              Get.back();
              Get.toNamed(
                AppRoutes.userProfileRoute,
                arguments: {
                  'id': mentions[index - 1].id,
                  'isFromChat': false,
                },
              );
            },
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    mentions[index - 1].profileImg,
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const AppImage(
                      image: Constants.userErrorWidget,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      isCircle: true,
                    ),
                  ),
                ),
                10.horizontalSpace(),
                Flexible(
                  child: Text(
                    mentions[index - 1].name,
                    style: Get.textTheme.titleLarge!.copyWith(
                      fontSize: AppSize.s16(context),
                    ),
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => 15.verticalSpace(),
        itemCount: mentions.length + 1,
      ),
    );
  }
}
