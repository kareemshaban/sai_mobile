import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/data/mapper/notification_mapper.dart';
import 'package:new_sai/data/model/notification_model/notification_model.dart';
import 'package:new_sai/domain/entity/chat_entity/chat_user_info_entity.dart';
import 'package:new_sai/domain/entity/notification_entity/notification_entity.dart';
import 'package:new_sai/domain/entity/reels_entity/reels_entity.dart';
import 'package:new_sai/domain/use_case/reels_use_case/show_reels_use_case.dart';
import 'package:new_sai/domain/use_case/stories_use_case/get_story_by_id_use_case.dart';
import 'package:new_sai/presentation/pages/main/getx/main_controller.dart';
import 'package:new_sai/presentation/pages/main/pages/reels/getx/reels_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';
import 'package:x_overlay/x_overlay.dart';

class NotificationItem extends StatelessWidget {
  final NotificationEntity model;
  const NotificationItem({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        onTapOnNotification(model.content.type, model.content.id);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        color: model.readAt.isEmpty
            ? ColorManager.newNotificationColor.withOpacity(.15)
            : null,
        child: Row(
          children: [
            AppImage(
              image: model.content.image,
              width: 55,
              height: 55,
              isCircle: true,
              fit: BoxFit.cover,
              // border: hasStory
              //     ? Border.all(
              //         color: ColorManager.storyBorderColor,
              //         width: 3,
              //         strokeAlign: BorderSide.strokeAlignCenter,
              //       )
              //     : null,
            ),
            // child: const Stack(
            //   children: [
            //     // if (hasStory)
            //     //   Container(
            //     //     decoration: BoxDecoration(
            //     //       shape: BoxShape.circle,
            //     //       border: Border.all(
            //     //         color: ColorManager.white,
            //     //         width: 2,
            //     //         strokeAlign: BorderSide.strokeAlignCenter,
            //     //       ),
            //     //     ),
            //     //   ),
            //     // if (isLike)
            //     //   PositionedDirectional(
            //     //     bottom: 0,
            //     //     end: 0,
            //     //     child: Container(
            //     //       width: 16,
            //     //       height: 16,
            //     //       decoration: const BoxDecoration(
            //     //         shape: BoxShape.circle,
            //     //         color: ColorManager.likeColor,
            //     //       ),
            //     //       child: const Icon(
            //     //         Icons.favorite,
            //     //         color: ColorManager.white,
            //     //         size: 10,
            //     //       ),
            //     //     ),
            //     //   )
            //     // else
            //     //   PositionedDirectional(
            //     //     bottom: 0,
            //     //     end: 0,
            //     //     child: Container(
            //     //       width: 16,
            //     //       height: 16,
            //     //       decoration: const BoxDecoration(
            //     //         shape: BoxShape.circle,
            //     //         color: ColorManager.primary,
            //     //       ),
            //     //       child: const Center(
            //     //         child: AppIcon(
            //     //           icon: IconsAssets.commentFill,
            //     //           color: ColorManager.white,
            //     //           width: 10,
            //     //           height: 10,
            //     //         ),
            //     //       ),
            //     //     ),
            //     //   ),
            //   ],
            // ),
            // ),
            15.horizontalSpace(),
            Flexible(
              fit: FlexFit.tight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.content.title.name,
                    style: Get.textTheme.titleSmall!.copyWith(
                      fontSize: AppSize.s20(context),
                    ),
                  ),
                  1.verticalSpace(),
                  Text(
                    model.content.type == "chat"
                        ? model.content.message.name.isEmpty
                            ? AppStrings.message
                            : model.content.message.name
                        : model.content.message.name,
                    style: Get.textTheme.titleSmall!.copyWith(
                      fontSize: AppSize.s14(context),
                      color: ColorManager.black.withOpacity(.6),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  onTapOnNotification(String type, dynamic params) async {
    switch (type) {
      case "chat":
        final params =
            NotificationIDModel.fromJson(model.content.id).toDomain();
        Get.toNamed(
          AppRoutes.chatRoute,
          arguments: {
            "id": params.chatId,
            "recID": params.reciverId,
            "user": ChatUserInfoEntity(
              referenceId: 0,
              id: params.reciverId,
              name: params.userName,
              logo: params.logo,
            ),
          },
        );
      case "story":
        final params = model.content.id as int;
        final GetStoryByIdUseCase getStoryByIdUseCase =
            instance<GetStoryByIdUseCase>();
        (await getStoryByIdUseCase.execute(params)).fold(
          (l) {
            showSnackBarWidget(message: l.message);
          },
          (r) {
            if (r.user.id == Get.find<AppController>().user.id) {
              Get.toNamed(AppRoutes.myStoryRoute, arguments: r);
            } else {
              Get.toNamed(AppRoutes.storyViewRoute, arguments: r);
            }
          },
        );
      case "reel":
        final params = model.content.id as int;
        final ShowReelsUseCase showReelsUseCase = instance<ShowReelsUseCase>();
        ReelsEntity? reel;
        (await showReelsUseCase.execute(params)).fold(
          (l) {
            showSnackBarWidget(message: l.message);
          },
          (r) {
            reel = r;
          },
        );
        final reelsController = Get.find<ReelsController>();
        if (reelsController.reels.isNotEmpty) {
          if (reel != null) {
            playReel(reel!);
          }
        } else {
          await reelsController.getReels();
          if (reel != null) {
            playReel(reel!);
          }
        }
      case "admin_room":
        final params = model.content.id as int;
        if (Get.isRegistered<RoomController>()) {
          final roomController = Get.find<RoomController>();
          if (AppRoutes.overlayController.pageStateNotifier.value ==
              XOverlayPageState.overlaying) {
            AppRoutes.overlayController.hide();
            await roomController.closeAndDisposeRoom();
          }
          roomController.initController(params.toString());
        }
        Get.toNamed(AppRoutes.roomRoute,
            arguments: {"id": params.toString(), "data": null});
        return;
      case "room":
        final params = model.content.id as int;
        if (Get.isRegistered<RoomController>()) {
          final roomController = Get.find<RoomController>();
          if (AppRoutes.overlayController.pageStateNotifier.value ==
              XOverlayPageState.overlaying) {
            AppRoutes.overlayController.hide();
            await roomController.closeAndDisposeRoom();
          }
          roomController.initController(params.toString());
        }
        Get.toNamed(AppRoutes.roomRoute, arguments: {
          "id": params.toString(),
          "data": null,
        });
      case "redeem_request":
        Get.toNamed(AppRoutes.cashWithdrawalRoute);
      case "order":
        final params = model.content.id as int;
        Get.toNamed(AppRoutes.orderDetailsRoute, arguments: params);
      case "profile":
        final params = model.content.id as int;
        Get.toNamed(
          AppRoutes.userProfileRoute,
          arguments: {
            'id': params,
            'isFromChat': false,
          },
        );
      default:
        return;
    }
  }

  playReel(ReelsEntity reel) {
    if (Get.currentRoute != AppRoutes.mainRoute) {
      if (Get.currentRoute == AppRoutes.roomRoute) {
        AppRoutes.overlayController.overlay(
          AppRoutes.navigatorKey.currentContext!,
          data: XOverlayData(),
        );
      }
      Get.until((route) {
        if (Get.currentRoute == AppRoutes.mainRoute) {
          return true;
        }
        return false;
      });
    }
    final reelsController = Get.find<ReelsController>();
    reelsController.reels.removeWhere((element) => element.id == reel.id);
    Get.find<MainController>().onChangeCurrentIndex(2);
    reelsController.reels.insert(0, reel);
    reelsController.reelsController.jumpToPage(0);
  }
}
