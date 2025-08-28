import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/chat_entity/friend_request_entity.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';

class FriendRequestItem extends StatelessWidget {
  final FriendRequestEntity model;
  final void Function()? onTapAccept;
  final void Function()? onTapRemove;
  const FriendRequestItem({
    super.key,
    required this.model,
    this.onTapAccept,
    this.onTapRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppImage(
          image: model.profileImg,
          width: 55,
          height: 55,
          fit: BoxFit.cover,
          isCircle: true,
        ),
        15.horizontalSpace(),
        Flexible(
          fit: FlexFit.tight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                style: Get.textTheme.titleSmall!.copyWith(
                  fontSize: AppSize.s20(context),
                ),
              ),
              // 1.verticalSpace(),
              // Text(
              //   AppStrings.fromYourContacts,
              //   style: Get.textTheme.titleSmall!.copyWith(
              //     fontSize: AppSize.s14(context),
              //     color: ColorManager.black.withOpacity(.6),
              //   ),
              // ),
            ],
          ),
        ),
        15.horizontalSpace(),
        AppButton(
          title: AppStrings.accept2,
          radius: 5,
          height: 30,
          onTap: onTapAccept,
          textStyle: Get.textTheme.bodyMedium!.copyWith(
            fontSize: AppSize.s15(context),
          ),
        ),
        10.horizontalSpace(),
        InkWell(
          onTap: onTapRemove,
          child: Icon(
            Icons.close,
            color: ColorManager.black.withOpacity(.5),
          ),
        ),
      ],
    );
  }
}
