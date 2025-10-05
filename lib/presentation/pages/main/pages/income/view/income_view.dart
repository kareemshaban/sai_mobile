import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_pref.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/presentation/pages/main/pages/income/getx/income_controller.dart';
import 'package:new_sai/presentation/pages/main/pages/income/widgets/custom_income_button.dart';
import 'package:new_sai/presentation/pages/main/pages/income/widgets/income_list.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/getx/profile_controller.dart';
import 'package:new_sai/presentation/pages/main/pages/rooms/widget/check_lock_dialog.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/guest_dilaog.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:x_overlay/x_overlay.dart';

class IncomeView extends GetView<IncomeController> {
  const IncomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final AppPreferences _appPreferences = instance<AppPreferences>();
    final screenWidth = MediaQuery.of(context).size.width;
    final avatarRadius = screenWidth < 400 ? 30.0 : 40.0;
    final fontSize = screenWidth < 400 ? 11.0 : 13.0;

    return isGuest()
        ? const GuestDilaog()
        : RefreshIndicator(
            onRefresh: () async {
              await controller.getUserFriend();
              await controller.getMyConversation();
            },
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(child: 10.verticalSpace()),
                SliverToBoxAdapter(
                  child: Obx(
                    () => controller.loadingUsers
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            child: SizedBox(
                              height: avatarRadius * 2 + 35,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                shrinkWrap: true,
                                physics: const ClampingScrollPhysics(),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(width: 12),
                                itemBuilder: (context, index) {
                                  return Skeletonizer(
                                    enabled: true,
                                    effect: const ShimmerEffect(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: avatarRadius * 2,
                                          height: avatarRadius * 2,
                                          decoration: const BoxDecoration(
                                            color: Colors.grey,
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Container(
                                          width: avatarRadius * 2,
                                          height: 14,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.only(
                              left: _appPreferences.getAppLanguage() == 'ar'
                                  ? 0
                                  : 10,
                              right: _appPreferences.getAppLanguage() == 'ar'
                                  ? 10
                                  : 0,
                              top: 5,
                              bottom: 5,
                            ),
                            child: controller.users.length == 0
                                ? SizedBox.shrink()
                                : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(AppStrings.activeUsers,   style: Get.textTheme.titleLarge!.copyWith(
                                  // fontSize: AppSize.s14(context),
                                ),),
                                const SizedBox(height: 10),
                                    SizedBox(
                                        height: avatarRadius * 2 + 55,
                                        child: ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: controller.users.length,
                                          shrinkWrap: true,
                                          physics: const ClampingScrollPhysics(),
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(width: 12),
                                          itemBuilder: (context, index) {
                                            final user = controller.users[index];
                                            return GestureDetector(
                                              onTap: () async {
                                                // Get.toNamed(
                                                //   AppRoutes.userProfileRoute,
                                                //   arguments: {
                                                //     'id': user.friendId,
                                                //     'isFromChat': false,
                                                //   },
                                                // );
                                                if (user.room!.lockCode!.isNotEmpty) {
                                                  Get.dialog(CheckLockDialog(
                                                    room: user.room!,
                                                    lockCode: user.room!.lockCode! ,
                                                  ));
                                                  return;
                                                }
                                                if (Get.isRegistered<RoomController>()) {
                                                  final roomController = Get.find<RoomController>();
                                                  if (AppRoutes.overlayController.pageStateNotifier.value ==
                                                      XOverlayPageState.overlaying) {
                                                    AppRoutes.overlayController.hide();
                                                    await roomController.closeAndDisposeRoom();
                                                  }
                                                  roomController.initController(
                                                    user.room!.id.toString(),
                                                    data: {
                                                      "roomName": user.room!.roomName,
                                                      "referenceId": user.room!.roomReferenceId,
                                                      "backgroundTheme": user.room!.backgroundTheme,
                                                      "roomImage": user.room!.roomImage,
                                                    },
                                                  );
                                                }
                                                Get.toNamed(AppRoutes.roomRoute, arguments: {
                                                  "id": user.room!.id.toString(),
                                                  "data": {
                                                    "roomName": user.room!.roomName,
                                                    "referenceId": user.room!.roomReferenceId,
                                                    "backgroundTheme": user.room!.backgroundTheme,
                                                    "roomImage": user.room!.roomImage,
                                                  },
                                                });
                                              },
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Stack(
                                                    children: [
                                                      // Outer pink border
                                                      Container(
                                                        width: avatarRadius * 2.2,
                                                        height: avatarRadius * 2.2,
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          border: Border.all(
                                                            color: Color(0xFFFF00D9),
                                                            width: 5.0,
                                                          ),
                                                        ),
                                                        // Middle white border
                                                        child: Container(
                                                          padding: EdgeInsets.all(2), // Adjust thickness of white border
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: Colors.white, // This creates the white border
                                                          ),
                                                          child: ClipOval(
                                                            child: AppImage(
                                                              image: user.profileImg.toString(),
                                                              width: avatarRadius * 2,
                                                              height: avatarRadius * 2,
                                                              isCircle: true,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),

                                                      // Online status circle
                                                      Positioned(
                                                        bottom: 4,
                                                        right: 4,
                                                        child: Container(
                                                          width: 19,
                                                          height: 19,
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: Color(0xFFFF00D9), // Online status color
                                                            border: Border.all(
                                                              color: Colors.white, // White border around status dot
                                                              width: 2,
                                                            ),
                                                          ),
                                                          child: Image.asset(ImageAssets.activeIcon, ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 6),
                                                  SizedBox(
                                                    width: avatarRadius * 2,
                                                    child: Text(
                                                      user.name.toString(),
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: fontSize,
                                                        color: ColorManager.primary,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                          ),
                  ),
                ),

                SliverToBoxAdapter(child: 10.verticalSpace()),

                SliverToBoxAdapter(
                  child: CustomIncomeButton(
                    title: AppStrings.newFollowers,
                    icon: IconsAssets.userGroup,
                    color: ColorManager.primary,
                    onTap: () => Get.toNamed(AppRoutes.friendRequestsRoute),
                  ),
                ),

                SliverToBoxAdapter(child: 15.verticalSpace()),
// SliverToBoxAdapter(
//   child: GestureDetector(

//     onTap: (){
//       Navigator.push(context, MaterialPageRoute(builder: (context){
//         return GameRoom();
//       }));
//     },
//     child: Container(width: 40,height: 40,color: Colors.black26,)),
// ),
                /// Notifications
                SliverToBoxAdapter(
                  child: Obx(
                    () => CustomIncomeButton(
                      title: AppStrings.systemNotification,
                      icon: IconsAssets.notification,
                      color: ColorManager.appRedColor,
                      value:
                          Get.find<ProfileController>().notificationCount != 0
                              ? Get.find<ProfileController>()
                                  .notificationCount
                                  .toString()
                              : null,
                      onTap: () => Get.toNamed(AppRoutes.notificationsRoute),
                    ),
                  ),
                ),

                SliverToBoxAdapter(child: 25.verticalSpace()),

                /// Divider
                const SliverToBoxAdapter(
                  child: Divider(
                    height: 0,
                    color: ColorManager.lightGreyColor,
                  ),
                ),

                const SliverToBoxAdapter(child: IncomeList()),
              ],
            ),
          );
  }
}
