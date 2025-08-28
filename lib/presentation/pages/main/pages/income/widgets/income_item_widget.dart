import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/chat_entity/my_conversations_entity.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';

class IncomeItemWidget extends StatelessWidget {
  final MyConversationsEntity model;
  const IncomeItemWidget({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          AppRoutes.chatRoute,
          arguments: {
            "id": model.id,
            "recID": model.toId,
            "user": model.userInfo,
          },
        );
      },
      child: Row(
        children: [
          AppImage(
            image: model.userInfo.logo,
            width: 55,
            height: 55,
            isCircle: true,
            fit: BoxFit.cover,
          ),
          // Stack(
          //   children: [
          //     if (false)
          //       Container(
          //         decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           border: Border.all(
          //             color: ColorManager.white,
          //             width: 2,
          //             strokeAlign: BorderSide.strokeAlignCenter,
          //           ),
          //         ),
          //       ),
          //     if (false)
          //       PositionedDirectional(
          //         bottom: 0,
          //         end: 0,
          //         child: Container(
          //           width: 14,
          //           height: 14,
          //           decoration: const BoxDecoration(
          //             color: ColorManager.onlineColor,
          //             shape: BoxShape.circle,
          //           ),
          //         ),
          //       ),
          //   ],
          // ),
          18.horizontalSpace(),
          Flexible(
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        model.userInfo.name,
                        style: Get.textTheme.titleSmall!.copyWith(
                          fontSize: AppSize.s20(context),
                        ),
                      ),
                    ),
                    if (model.messagesCount != 0) ...[
                      18.horizontalSpace(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: const BoxDecoration(
                          color: ColorManager.appRedColor,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          "${model.messagesCount}",
                          style: Get.textTheme.bodySmall!.copyWith(
                            fontSize: AppSize.s14(context),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                1.verticalSpace(),
                Text(
                  getLastMessageType(model.type, model.message),
                  style: Get.textTheme.titleSmall!.copyWith(
                    fontSize: AppSize.s14(context),
                    color: ColorManager.black.withOpacity(.6),
                  ),
                ),
              ],
            ),
          ),
          18.horizontalSpace(),
          Text(
            model.lastMessageTime,
            style: Get.textTheme.titleSmall!.copyWith(
              fontSize: AppSize.s12(context),
              color: ColorManager.black.withOpacity(.5),
            ),
          ),
        ],
      ),
    );
  }

  String getLastMessageType(String type, String lastMessage) {
    switch (type) {
      case "voice":
        return AppStrings.voiceMessage;
      case "image":
        return AppStrings.image;
      case "file":
        return AppStrings.file;
      default:
        return lastMessage.startsWith("Checkout") ||
                lastMessage.startsWith("www") ||
                lastMessage.startsWith("https") ||
                lastMessage.startsWith("http")
            ? AppStrings.link1
            : lastMessage;
    }
  }
}
