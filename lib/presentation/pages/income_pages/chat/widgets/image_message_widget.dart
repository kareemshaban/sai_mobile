import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/chat_entity/messages_entity.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_widgets/room_image_view.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';

class ImageMessageWidget extends StatelessWidget {
  final bool isSender;
  final MessagesEntity model;
  const ImageMessageWidget(
      {super.key, required this.isSender, required this.model});

  @override
  Widget build(BuildContext context) {
    final user = Get.find<AppController>().user;
    return Row(
      mainAxisAlignment:
          isSender ? MainAxisAlignment.start : MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (isSender) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              user.profileImg,
              width: 25,
              height: 25,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const AppImage(
                image: Constants.userErrorWidget,
                width: 25,
                height: 25,
                fit: BoxFit.cover,
                isCircle: true,
              ),
            ),
          ),
          9.horizontalSpace(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => Get.to(RoomImageView(image: model.file)),
                child: AppImage(
                  image: model.file,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                  radius: 8,
                ),
              ),
              if (model.message.isNotEmpty) ...[
                5.verticalSpace(),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: .7.w(context),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorManager.messageColor,
                  ),
                  child: Text(
                    model.message,
                    style: Get.textTheme.titleSmall!.copyWith(
                      fontSize: AppSize.s18(context),
                    ),
                  ),
                ),
                2.verticalSpace(),
                Text(
                  model.createdAt,
                  style: Get.textTheme.labelSmall!.copyWith(
                    fontSize: AppSize.s10(context),
                  ),
                ),
              ] else ...[
                2.verticalSpace(),
                Text(
                  model.createdAt,
                  style: Get.textTheme.labelSmall!.copyWith(
                    fontSize: AppSize.s10(context),
                  ),
                ),
              ],
            ],
          ),
        ] else ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: () => Get.to(RoomImageView(image: model.file)),
                child: AppImage(
                  image: model.file,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                  radius: 8,
                ),
              ),
              if (model.message.isNotEmpty) ...[
                5.verticalSpace(),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: .7.w(context),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorManager.primary,
                  ),
                  child: Text(
                    model.message,
                    style: Get.textTheme.bodySmall!.copyWith(
                      fontSize: AppSize.s18(context),
                    ),
                  ),
                ),
                2.verticalSpace(),
                Text(
                  model.createdAt,
                  style: Get.textTheme.labelSmall!.copyWith(
                    fontSize: AppSize.s10(context),
                  ),
                ),
              ] else ...[
                2.verticalSpace(),
                Text(
                  model.createdAt,
                  style: Get.textTheme.labelSmall!.copyWith(
                    fontSize: AppSize.s10(context),
                  ),
                ),
              ],
            ],
          ),
          9.horizontalSpace(),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              model.userInfo.logo,
              width: 25,
              height: 25,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const AppImage(
                image: Constants.userErrorWidget,
                width: 25,
                height: 25,
                fit: BoxFit.cover,
                isCircle: true,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
