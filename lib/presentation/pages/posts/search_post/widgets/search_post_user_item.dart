import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/auth_entity/user_entity.dart';
import 'package:new_sai/domain/use_case/auth_use_case/cancel_friend_request_use_case.dart';
import 'package:new_sai/domain/use_case/auth_use_case/send_friend_request_use_case.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/getx/profile_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class SearchPostUserItem extends StatefulWidget {
  final UserEntity user;
  final bool isVisitor;
  const SearchPostUserItem(
      {super.key, required this.user, this.isVisitor = false});

  @override
  State<SearchPostUserItem> createState() => _SearchPostUserItemState();
}

class _SearchPostUserItemState extends State<SearchPostUserItem> {
  bool loading = false;
  final SendFriendRequestUseCase _friendRequestUseCase =
      instance<SendFriendRequestUseCase>();
  final CancelFriendRequestUseCase _cancelFriendRequestUseCase =
      instance<CancelFriendRequestUseCase>();

  sendFriendRequest() async {
    if (loading) {
      return;
    }
    loading = true;
    setState(() {});
    (await _friendRequestUseCase
            .execute(widget.isVisitor ? widget.user.id : widget.user.friendId))
        .fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        widget.user.isFollowing = true;
        if (widget.user.isFollow) {
          widget.user.isFriend = true;
        }
        Get.find<ProfileController>().getMyProfile();
      },
    );
    loading = false;
    setState(() {});
  }

  cancelFriendRequest() async {
    if (loading) {
      return;
    }
    loading = true;
    setState(() {});
    (await _cancelFriendRequestUseCase
            .execute(widget.isVisitor ? widget.user.id : widget.user.friendId))
        .fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        widget.user.isFollowing = false;
        Get.find<ProfileController>().getMyProfile();
      },
    );
    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          AppRoutes.userProfileRoute,
          arguments: {
            'id': widget.isVisitor ? widget.user.id : widget.user.friendId,
            'isFromChat': false,
          },
        );
      },
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(80),
            child: Image.network(
              widget.user.profileImg,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const AppImage(
                image: Constants.userErrorWidget,
              ),
            ),
          ),
          6.horizontalSpace(),
          Flexible(
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.name,
                  style: Get.textTheme.titleSmall!.copyWith(
                    fontSize: AppSize.s15(context),
                  ),
                ),
                3.verticalSpace(),
                Text(
                  "ID : ${widget.user.referenceId}",
                  style: Get.textTheme.titleSmall!.copyWith(
                    fontSize: AppSize.s13(context),
                    color: ColorManager.black.withOpacity(.5),
                  ),
                ),
              ],
            ),
          ),
          if (widget.user.isFriend)
            Text(
              AppStrings.friend,
              style: Get.textTheme.titleLarge!.copyWith(
                fontSize: AppSize.s16(context),
              ),
            )
          else
            AppButton(
              title: widget.user.isFollowing
                  ? AppStrings.unFollow
                  : widget.user.isFollow
                      ? AppStrings.followBack
                      : AppStrings.follow,
              onTap: widget.user.isFollowing
                  ? cancelFriendRequest
                  : sendFriendRequest,
              height: 31,
              textSize: AppSize.s14(context),
              radius: 10,
            ),
        ],
      ),
    );
  }
}
