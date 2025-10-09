import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_bottom_sheets/room_gift_users_bottom_sheet.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_bottom_sheets/room_user_bottom_sheet.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/privilege_data_view.dart';
import 'package:shimmer/shimmer.dart';

class RoomUserList extends GetView<RoomController> {
  const RoomUserList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () => InkWell(
            onTap: controller.loadingJoinRoom
                ? null
                : () {
                    Get.bottomSheet(
                      RoomGiftUsersBottomSheet(
                        roomID: controller.room.id.toInt(),
                      ),
                      isScrollControlled: true,
                    );
                  },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentDirectional.centerStart,
                  end: AlignmentDirectional.centerEnd,
                  stops: const [0, 0.6, 1],
                  colors: <Color>[
                    Colors.amber.withOpacity(0.4),
                    Colors.amber.withOpacity(0.3),
                    Colors.amber.withOpacity(0)
                  ],
                  tileMode: TileMode.mirror,
                ),
              ),
              child: Row(
                children: [
                  Image.asset(
                    ImageAssets.goldTrophy,
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Text(
                      controller.room.totalGold,
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: ColorManager.white,
                        fontSize: AppSize.s14(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        10.horizontalSpace(),
        Flexible(
          fit: FlexFit.tight,
          child: Container(
            width: .75.w(context),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorManager.black.withOpacity(.3),
            ),
            child: Obx(() {
              final apiUsers = controller.apiUsers;
              final users = controller.users;

              if (apiUsers.isEmpty) {
                return const Center(
                  child: SizedBox(
                    height: 40,
                  ),
                );
              }

              final notLoaded = users.where((u) => !apiUsers
                  .any((a) => a.id.toString().trim() == u.userID.trim()));
              if (notLoaded.isNotEmpty) {
                return Center(
                    child: Row(
                  children: [
                    Shimmer.fromColors(
                        baseColor: ColorManager.lightGreyColor.withOpacity(0.2),
                        highlightColor: Colors.black,
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(100.0),
                              color: Colors.black),
                          height: 30,
                          width: 30,
                        )),
                    10.horizontalSpace(),
                    Shimmer.fromColors(
                        baseColor: ColorManager.lightGreyColor.withOpacity(0.2),
                        highlightColor: Colors.black,
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(100.0),
                              color: Colors.black),
                          height: 30,
                          width: 30,
                        )),
                    10.horizontalSpace(),
                    Shimmer.fromColors(
                        baseColor: ColorManager.lightGreyColor.withOpacity(0.2),
                        highlightColor: Colors.black,
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(100.0),
                              color: Colors.black),
                          height: 30,
                          width: 30,
                        )),
                  ],
                ));
              }

              return Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 20,
                      child: Builder(builder: (context) {
                        final sortedUsers = [...users]..sort((a, b) {
                          final userA = apiUsers.firstWhereOrNull(
                                (e) => e.id.toString().trim() == a.userID.trim(),
                          );
                          final userB = apiUsers.firstWhereOrNull(
                                (e) => e.id.toString().trim() == b.userID.trim(),
                          );

                          int rank(user) {
                            if (user == null) return 5;
                            if (user.role == 'owner') return 1;
                            if (user.role == 'admin') return 2;
                            if (user.isVip == 1) return 3;
                            return 4;
                          }

                          return rank(userA).compareTo(rank(userB));
                        });

                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: sortedUsers.length,
                          itemBuilder: (context, index) {
                            final currentUserId = sortedUsers[index].userID.trim();
                            final user = apiUsers.firstWhereOrNull(
                                  (e) => e.id.toString().trim() == currentUserId,
                            );
                            print(user!.role);

                            if (user == null) return const SizedBox();

                            return InkWell(
                              key: ValueKey(currentUserId),
                              onTap: controller.loadingJoinRoom
                                  ? null
                                  : () => controller.openProfileBottomSheet(
                                sortedUsers[index].userID,
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(52),
                                    child: Image.network(
                                      controller.getUserImage(sortedUsers[index].userID),
                                      errorBuilder: (context, error, stackTrace) =>
                                      const AppImage(
                                        image: Constants.userErrorWidget,
                                        width: 25,
                                        height: 25,
                                        isCircle: true,
                                      ),
                                      width: 25,
                                      height: 25,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  if (user.isVip == 1)
                                    PrivilegeDataView(
                                      url: user.privileges.data.profileFrame.file,
                                      width: 35,
                                      height: 35,
                                      fit: BoxFit.cover,
                                    ),

                                  Obx((){
                                    if (controller.mutedListLocally
                                        .contains(sortedUsers[index].userID) ||
                                        controller.mutedList
                                            .contains(sortedUsers[index].userID)) {
                                      return const PositionedDirectional(
                                        top: -5,
                                        end: 0,
                                        child: Icon(
                                          Icons.block,
                                          color: ColorManager.red,
                                          size: 15,
                                        ),
                                      );
                                    }else{
                                      return const SizedBox() ;
                                    }
                                  }),
                                  Obx((){
                                    if(controller.apiUsers.isNotEmpty) {
                                      return PositionedDirectional(
                                      bottom: user.isVip == 1 ? -5 : -2,
                                      start:user.isVip == 1 ? 3 : -3,
                                      child: Icon(
                                        Icons.person,
                                        color: user.role == 'owner'
                                            ? Colors.red
                                            : user.role == 'admin'
                                            ? Colors.yellow
                                            : Colors.grey,
                                        size: 14,
                                      ),
                                    );
                                    }else{
                                      return const SizedBox() ;
                                    }
                            })
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => 8.5.horizontalSpace(),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                    child: VerticalDivider(color: ColorManager.white),
                  ),
                  8.verticalSpace(),
                  InkWell(
                    onTap: controller.loadingJoinRoom
                        ? null
                        : () => Get.bottomSheet(const RoomUserBottomSheet()),
                    child: Column(
                      children: [
                        const Icon(Icons.person, color: ColorManager.white, size: 18),
                        const SizedBox(height: 5.0),
                        Text(
                          "${controller.users.length}",
                          style: Get.textTheme.bodySmall!.copyWith(
                            fontSize: AppSize.s13(context),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}
