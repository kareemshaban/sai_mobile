import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/dynamic_link_handler.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_bottom_sheets/room_mempers_bottom_sheet.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_dilaog/leave_room_dialog.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_dilaog/room_report_dialog.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_widgets/room_role_widget.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/resources/theme_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/share_bottom_sheet.dart';

import '../../../../../../data/model/game_model/game_model.dart';
import '../../../../../widgets/app_loader.dart';
import '../../../../game/view/game_page.dart';

class RoomAppBar extends GetView<RoomController> {
  const RoomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    print("controller.isLoadingGams.value");
    print(controller.isLoadingGams.value);
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Obx(
        () => InkWell(
          onTap: controller.loadingJoinRoom
              ? null
              : () {
                  controller.getRoomMempers();
                  Get.bottomSheet(
                    const RoomMempersBottomSheet(),
                    isScrollControlled: true,
                    enableDrag: false,
                  );
                },
          child: Row(
            children: [
              AppImage(
                image: controller.room.roomImage,
                width: 45,
                height: 45,
                radius: 8,
                fit: BoxFit.cover,
              ),
              7.horizontalSpace(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.room.roomName,
                    style: Get.textTheme.bodySmall!.copyWith(
                      fontSize: AppSize.s18(context),
                      shadows: getBoxShadow(
                        y: 0,
                        blurRadius: 7,
                        color: ColorManager.textShadow,
                      ),
                    ),
                  ),
                  4.verticalSpace(),
                  Text(
                    "ID : ${controller.room.referenceId}",
                    style: Get.textTheme.bodyMedium!.copyWith(
                      fontSize: AppSize.s14(context),
                      shadows: getBoxShadow(
                        y: 0,
                        blurRadius: 7,
                        color: ColorManager.textShadow,
                      ),
                    ),
                  ),
                ],
              ),
              10.horizontalSpace(),
              const RoomRoleWidget(),
            ],
          ),
        ),
      ),
      actions: [
        if (controller.isOwner())
          InkWell(
            onTap: controller.loadingJoinRoom
                ? null
                : () => Get.toNamed(
                      AppRoutes.roomSettingsRoute,
                      arguments: controller.roomId,
                    ),
            child: const Icon(
              Icons.settings,
              color: ColorManager.white,
              size: 25,
            ),
          )
        else
          InkWell(
            onTap: controller.loadingJoinRoom
                ? null
                : () => Get.dialog(const RoomReportDialog()),
            child: const Icon(
              Icons.flag,
              color: ColorManager.red,
              size: 25,
            ),
          ),
        10.horizontalSpace(),
        //  Obx(() =>
        //controller.room.role != 'guest'
        //  ?
        // Obx(
        //   () =>
        InkWell(
          onTap: () {
            controller.fetchGameList(
                userId: controller.user.id.toString(),
                roomId: controller.roomId);
            controller.isPlayingGame.value = true;
            print("controller.isPlayingGame.value on click");
            print(controller.isPlayingGame.value);

            // Get.dialog(buildGameListDiloag(context));
            // Get.bottomSheet(
            //     isScrollControlled: true,
            //     backgroundColor: Colors.white,
            //     SizedBox(
            //       height: Get.height * 0.8,
            //       child: Padding(
            //         padding:
            //             const EdgeInsets.only(top: 12.0, right: 8, left: 8),
            //         child: Column(
            //           children: [
            //             Obx(() {
            //               if (controller.isLoadingGams.value) {
            //                 return SizedBox(
            //                     width: Get.width,
            //                     height: 200,
            //                     child: const Center(child: AppLoader()));
            //               }
            //               final games = controller.gameResponse.value!.gameList;
            //               return SizedBox(
            //                 width: Get.width,
            //                 height: 100,
            //                 child: controller.isInSettingsMode.value
            //                     ? ListView.builder(
            //                         physics: const BouncingScrollPhysics(),
            //                         itemCount: controller.gameItems.length,
            //                         itemBuilder: (_, index) {
            //                           final item = controller.gameItems[index];
            //                           print("item.game.name");
            //                           print(item.game.name);
            //                           print(item.game.id);
            //                           bool invisibleSwitch =
            //                               item.game.id == 1077;
            //                           return
            //                               //Obx(() =>
            //                               Container(
            //                             margin: const EdgeInsets.symmetric(
            //                                 vertical: 8),
            //                             padding: const EdgeInsets.all(12),
            //                             decoration: BoxDecoration(
            //                               color: Colors.grey.shade100,
            //                               borderRadius:
            //                                   BorderRadius.circular(12),
            //                               boxShadow: [
            //                                 BoxShadow(
            //                                   color: Colors.black
            //                                       .withOpacity(0.05),
            //                                   blurRadius: 5,
            //                                   offset: const Offset(0, 2),
            //                                 ),
            //                               ],
            //                             ),
            //                             child: Row(
            //                               children: [
            //                                 CircleAvatar(
            //                                   backgroundImage:
            //                                       NetworkImage(item.game.icon),
            //                                   radius: 25,
            //                                 ),
            //                                 const SizedBox(width: 12),
            //                                 Expanded(
            //                                   child: Text(
            //                                     item.game.name,
            //                                     style: const TextStyle(
            //                                       fontSize: 14,
            //                                       color: Colors.black,
            //                                       fontWeight: FontWeight.w600,
            //                                     ),
            //                                   ),
            //                                 ),
            //                                 invisibleSwitch
            //                                     ? Container()
            //                                     : Obx(
            //                                         () => Switch(
            //                                           value:
            //                                               item.isActive.value,
            //                                           onChanged: (val) {
            //                                             controller
            //                                                 .toggleGameStatus(
            //                                                     item,
            //                                                     index,
            //                                                     val);
            //                                           },
            //                                         ),
            //                                       )
            //                               ],
            //                             ),
            //                           );
            //                           //);
            //                         },
            //                       )
            //                     : Padding(
            //                         padding: const EdgeInsets.symmetric(
            //                             horizontal: 8.0),
            //                         child: Row(
            //                           crossAxisAlignment:
            //                               CrossAxisAlignment.start,
            //                           children: [
            //                             Expanded(
            //                               child: ListView(
            //                                 scrollDirection: Axis.horizontal,
            //                                 children: games.map((game) {
            //                                   print("game.name -----");
            //                                   print(game.name);
            //                                   return GestureDetector(
            //                                     onTap: () {
            //                                       if (showGame(game,
            //                                           controller.room.role)) {
            //                                         print(game.url);
            //                                         print(game.url);
            //                                         Get.back();
            //                                         controller.isPlayingGame
            //                                             .value = true;
            //                                         //
            //                                         // Get.to(GamePage(
            //                                         //   gameUrl: game.url,
            //                                         //   gameResponse:
            //                                         //       controller.gameResponse.value!,
            //                                         // ));
            //                                       } else {
            //                                         Get.showSnackbar(
            //                                           GetSnackBar(
            //                                             backgroundColor:
            //                                                 Colors.transparent,
            //                                             snackPosition:
            //                                                 SnackPosition.TOP,
            //                                             margin: const EdgeInsets
            //                                                 .all(12),
            //                                             borderRadius: 16,
            //                                             duration:
            //                                                 const Duration(
            //                                                     seconds: 3),
            //                                             isDismissible: true,
            //                                             forwardAnimationCurve:
            //                                                 Curves.easeOutBack,
            //                                             reverseAnimationCurve:
            //                                                 Curves.easeInBack,
            //                                             messageText: Container(
            //                                               padding:
            //                                                   const EdgeInsets
            //                                                       .all(16),
            //                                               decoration:
            //                                                   BoxDecoration(
            //                                                 gradient:
            //                                                     LinearGradient(
            //                                                   colors: [
            //                                                     Colors.purple
            //                                                         .withOpacity(
            //                                                             0.9),
            //                                                     Colors.blue
            //                                                         .withOpacity(
            //                                                             0.9)
            //                                                   ],
            //                                                   begin: Alignment
            //                                                       .topLeft,
            //                                                   end: Alignment
            //                                                       .bottomRight,
            //                                                 ),
            //                                                 borderRadius:
            //                                                     BorderRadius
            //                                                         .circular(
            //                                                             16),
            //                                                 boxShadow: [
            //                                                   BoxShadow(
            //                                                     color: Colors
            //                                                         .black
            //                                                         .withOpacity(
            //                                                             0.2),
            //                                                     blurRadius: 10,
            //                                                     offset:
            //                                                         const Offset(
            //                                                             0, 4),
            //                                                   ),
            //                                                 ],
            //                                               ),
            //                                               child: Row(
            //                                                 children: [
            //                                                   const Icon(
            //                                                       Icons
            //                                                           .info_outline,
            //                                                       color: Colors
            //                                                           .white),
            //                                                   const SizedBox(
            //                                                       width: 12),
            //                                                   Expanded(
            //                                                     child: Text(
            //                                                       AppStrings
            //                                                           .hintCantPaly,
            //                                                       style: const TextStyle(
            //                                                           color: Colors
            //                                                               .white,
            //                                                           fontSize:
            //                                                               16),
            //                                                     ),
            //                                                   ),
            //                                                 ],
            //                                               ),
            //                                             ),
            //                                           ),
            //                                         );
            //                                       }
            //                                     },
            //                                     child: Column(
            //                                       mainAxisSize:
            //                                           MainAxisSize.min,
            //                                       children: [
            //                                         CircleAvatar(
            //                                           backgroundImage:
            //                                               NetworkImage(
            //                                                   game.icon),
            //                                           radius: 30,
            //                                         ),
            //                                         const SizedBox(height: 6),
            //                                         Text(
            //                                           game.name,
            //                                           style: const TextStyle(
            //                                             fontSize: 13,
            //                                             fontWeight:
            //                                                 FontWeight.w500,
            //                                             color: Colors.black,
            //                                           ),
            //                                         ),
            //                                       ],
            //                                     ),
            //                                   );
            //                                 }).toList(),
            //                               ),
            //                             ),
            //                             if (controller.room.role == 'admin' ||
            //                                 controller.room.role == 'owner')
            //                               Container(
            //                                 width: 40,
            //                                 height: 40,
            //                                 child: GestureDetector(
            //                                   onTap: () {
            //                                     controller.isInSettingsMode
            //                                         .toggle(); // تغيير الوضع
            //                                   },
            //                                   child: Container(
            //                                     padding:
            //                                         const EdgeInsets.symmetric(
            //                                             vertical: 8),
            //                                     decoration: BoxDecoration(
            //                                       gradient:
            //                                           const LinearGradient(
            //                                         colors: [
            //                                           Colors.deepPurpleAccent,
            //                                           Colors.blueAccent
            //                                         ],
            //                                       ),
            //                                       borderRadius:
            //                                           BorderRadius.circular(12),
            //                                     ),
            //                                     child: Center(
            //                                       child: Icon(
            //                                           !controller
            //                                                   .isInSettingsMode
            //                                                   .value
            //                                               ? Icons.settings
            //                                               : Icons.arrow_forward,
            //                                           color: Colors.white),
            //                                     ),
            //                                   ),
            //                                 ),
            //                               ),
            //                           ],
            //                         ),
            //                       ),
            //               );
            //             }),
            //             // if (controller.isPlayingGame.value)
            //             //   GamePage(
            //             //     gameUrl: controller.gameItems[0].game.url,
            //             //     gameResponse: controller.gameResponse.value!,
            //             //   )
            //           ],
            //         ),
            //       ),
            //     )).then((value) {
            //   controller.isInSettingsMode.value = false;
            // });
            //   AlertDialog(
            //     backgroundColor: Colors.white,
            //     elevation: 0,
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(20)),
            //     titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            //     contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            //     title: Obx(
            //       () => Row(
            //         children: [
            //           Expanded(
            //             flex: 5,
            //             child: Container(
            //               padding: const EdgeInsets.symmetric(vertical: 8),
            //               decoration: BoxDecoration(
            //                 gradient: const LinearGradient(
            //                   colors: [
            //                     Colors.deepPurpleAccent,
            //                     Colors.blueAccent
            //                   ],
            //                 ),
            //                 borderRadius: BorderRadius.circular(12),
            //               ),
            //               child: Center(
            //                 child: Text(
            //                   controller.isInSettingsMode.value
            //                       ? AppStrings.settings
            //                       : AppStrings.gameList,
            //                   style: TextStyle(
            //                     fontSize: AppSize.s18(context),
            //                     fontWeight: FontWeight.bold,
            //                     color: Colors.white,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //           if (controller.room.role == 'admin' ||
            //               controller.room.role == 'owner') ...[
            //             const SizedBox(width: 10),
            //             Expanded(
            //               flex: 1,
            //               child: GestureDetector(
            //                 onTap: () {
            //                   controller.isInSettingsMode
            //                       .toggle(); // تغيير الوضع
            //                 },
            //                 child: Container(
            //                   padding: const EdgeInsets.symmetric(vertical: 8),
            //                   decoration: BoxDecoration(
            //                     gradient: const LinearGradient(
            //                       colors: [
            //                         Colors.deepPurpleAccent,
            //                         Colors.blueAccent
            //                       ],
            //                     ),
            //                     borderRadius: BorderRadius.circular(12),
            //                   ),
            //                   child: Center(
            //                     child: Icon(
            //                         !controller.isInSettingsMode.value
            //                             ? Icons.settings
            //                             : Icons.arrow_forward,
            //                         color: Colors.white),
            //                   ),
            //                 ),
            //               ),
            //             )
            //           ]
            //         ],
            //       ),
            //     ),
            //     content: Obx(() {
            //       if (controller.isLoadingGams.value) {
            //         return SizedBox(
            //             width: Get.width * 0.8,
            //             height: 200,
            //             child: const Center(child: AppLoader()));
            //       }
            //       final games = controller.gameResponse.value!.gameList;
            //       return SizedBox(
            //         width: Get.width * 0.8,
            //         height: 200,
            //         child: controller.isInSettingsMode.value
            //             ? ListView.builder(
            //                 physics: const BouncingScrollPhysics(),
            //                 itemCount: controller.gameItems.length,
            //                 itemBuilder: (_, index) {
            //                   final item = controller.gameItems[index];
            //                   print("item.game.name");
            //                   print(item.game.name);
            //                   print(item.game.id);
            //                   bool invisibleSwitch = item.game.id == 1077;
            //                   return
            //                       //Obx(() =>
            //                       Container(
            //                     margin: const EdgeInsets.symmetric(vertical: 8),
            //                     padding: const EdgeInsets.all(12),
            //                     decoration: BoxDecoration(
            //                       color: Colors.grey.shade100,
            //                       borderRadius: BorderRadius.circular(12),
            //                       boxShadow: [
            //                         BoxShadow(
            //                           color: Colors.black.withOpacity(0.05),
            //                           blurRadius: 5,
            //                           offset: const Offset(0, 2),
            //                         ),
            //                       ],
            //                     ),
            //                     child: Row(
            //                       children: [
            //                         CircleAvatar(
            //                           backgroundImage:
            //                               NetworkImage(item.game.icon),
            //                           radius: 25,
            //                         ),
            //                         const SizedBox(width: 12),
            //                         Expanded(
            //                           child: Text(
            //                             item.game.name,
            //                             style: const TextStyle(
            //                               fontSize: 14,
            //                               color: Colors.black,
            //                               fontWeight: FontWeight.w600,
            //                             ),
            //                           ),
            //                         ),
            //                         invisibleSwitch
            //                             ? Container()
            //                             : Obx(
            //                                 () => Switch(
            //                                   value: item.isActive.value,
            //                                   onChanged: (val) {
            //                                     controller.toggleGameStatus(
            //                                         item, index, val);
            //                                   },
            //                                 ),
            //                               )
            //                       ],
            //                     ),
            //                   );
            //                   //);
            //                 },
            //               )
            //             : SingleChildScrollView(
            //                 physics: const BouncingScrollPhysics(),
            //                 child: Wrap(
            //                   spacing: 16,
            //                   runSpacing: 16,
            //                   alignment: WrapAlignment.center,
            //                   children: games.map((game) {
            //                     print("game.name -----");
            //                     print(game.name);
            //                     return GestureDetector(
            //                       onTap: () {
            //                         if (showGame(game, controller.room.role)) {
            //                           print(game.url);
            //                           print(game.url);
            //                           Get.back();
            //                           controller.isPlayingGame.value = true;
            //                           //
            //                           // Get.to(GamePage(
            //                           //   gameUrl: game.url,
            //                           //   gameResponse:
            //                           //       controller.gameResponse.value!,
            //                           // ));
            //                         } else {
            //                           Get.showSnackbar(
            //                             GetSnackBar(
            //                               backgroundColor: Colors.transparent,
            //                               snackPosition: SnackPosition.TOP,
            //                               margin: const EdgeInsets.all(12),
            //                               borderRadius: 16,
            //                               duration: const Duration(seconds: 3),
            //                               isDismissible: true,
            //                               forwardAnimationCurve:
            //                                   Curves.easeOutBack,
            //                               reverseAnimationCurve:
            //                                   Curves.easeInBack,
            //                               messageText: Container(
            //                                 padding: const EdgeInsets.all(16),
            //                                 decoration: BoxDecoration(
            //                                   gradient: LinearGradient(
            //                                     colors: [
            //                                       Colors.purple
            //                                           .withOpacity(0.9),
            //                                       Colors.blue.withOpacity(0.9)
            //                                     ],
            //                                     begin: Alignment.topLeft,
            //                                     end: Alignment.bottomRight,
            //                                   ),
            //                                   borderRadius:
            //                                       BorderRadius.circular(16),
            //                                   boxShadow: [
            //                                     BoxShadow(
            //                                       color: Colors.black
            //                                           .withOpacity(0.2),
            //                                       blurRadius: 10,
            //                                       offset: const Offset(0, 4),
            //                                     ),
            //                                   ],
            //                                 ),
            //                                 child: Row(
            //                                   children: [
            //                                     const Icon(Icons.info_outline,
            //                                         color: Colors.white),
            //                                     const SizedBox(width: 12),
            //                                     Expanded(
            //                                       child: Text(
            //                                         AppStrings.hintCantPaly,
            //                                         style: const TextStyle(
            //                                             color: Colors.white,
            //                                             fontSize: 16),
            //                                       ),
            //                                     ),
            //                                   ],
            //                                 ),
            //                               ),
            //                             ),
            //                           );
            //                         }
            //                       },
            //                       child: Column(
            //                         mainAxisSize: MainAxisSize.min,
            //                         children: [
            //                           CircleAvatar(
            //                             backgroundImage:
            //                                 NetworkImage(game.icon),
            //                             radius: 30,
            //                           ),
            //                           const SizedBox(height: 6),
            //                           Text(
            //                             game.name,
            //                             style: const TextStyle(
            //                               fontSize: 13,
            //                               fontWeight: FontWeight.w500,
            //                               color: Colors.black,
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     );
            //                   }).toList(),
            //                 ),
            //               ),
            //       );
            //     }),
            //   ),
            // ).then((e) {
            //   controller.isInSettingsMode.value = false;
            // });
            // Get.dialog(
            //   AlertDialog(
            //     backgroundColor: Colors.white,
            //     elevation: 12,
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(20)),
            //     titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            //     contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            //     title: Obx(
            //       () => Row(
            //         children: [
            //           Expanded(
            //             flex: 5,
            //             child: Container(
            //               padding: const EdgeInsets.symmetric(vertical: 8),
            //               decoration: BoxDecoration(
            //                 gradient: const LinearGradient(
            //                   colors: [
            //                     Colors.deepPurpleAccent,
            //                     Colors.blueAccent
            //                   ],
            //                 ),
            //                 borderRadius: BorderRadius.circular(12),
            //               ),
            //               child: Center(
            //                 child: Text(
            //                   controller.isInSettingsMode.value
            //                       ? AppStrings.settings
            //                       : AppStrings.gameList,
            //                   style: TextStyle(
            //                     fontSize: AppSize.s18(context),
            //                     fontWeight: FontWeight.bold,
            //                     color: Colors.white,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //           if (controller.room.role == 'admin' ||
            //               controller.room.role == 'owner') ...[
            //             const SizedBox(width: 10),
            //             Expanded(
            //               flex: 1,
            //               child: GestureDetector(
            //                 onTap: () {
            //                   controller.isInSettingsMode
            //                       .toggle(); // تغيير الوضع
            //                 },
            //                 child: Container(
            //                   padding: const EdgeInsets.symmetric(vertical: 8),
            //                   decoration: BoxDecoration(
            //                     gradient: const LinearGradient(
            //                       colors: [
            //                         Colors.deepPurpleAccent,
            //                         Colors.blueAccent
            //                       ],
            //                     ),
            //                     borderRadius: BorderRadius.circular(12),
            //                   ),
            //                   child: Center(
            //                     child: Icon(
            //                         !controller.isInSettingsMode.value
            //                             ? Icons.settings
            //                             : Icons.arrow_forward,
            //                         color: Colors.white),
            //                   ),
            //                 ),
            //               ),
            //             )
            //           ]
            //         ],
            //       ),
            //     ),
            //     content: Obx(() {
            //       if (controller.isLoadingGams.value) {
            //         return SizedBox(
            //             width: Get.width * 0.8,
            //             height: 200,
            //             child: const Center(child: AppLoader()));
            //       }
            //       final games = controller.gameResponse.value!.gameList;
            //       return SizedBox(
            //         width: Get.width * 0.8,
            //         height: 200,
            //         child: controller.isInSettingsMode.value
            //             ? ListView.builder(
            //                 physics: const BouncingScrollPhysics(),
            //                 itemCount: controller.gameItems.length,
            //                 itemBuilder: (_, index) {
            //                   final item = controller.gameItems[index];
            //                   print("item.game.name");
            //                   print(item.game.name);
            //                   print(item.game.id);
            //                   bool invisibleSwitch = item.game.id == 1077;
            //                   return
            //                       //Obx(() =>
            //                       Container(
            //                     margin: const EdgeInsets.symmetric(vertical: 8),
            //                     padding: const EdgeInsets.all(12),
            //                     decoration: BoxDecoration(
            //                       color: Colors.grey.shade100,
            //                       borderRadius: BorderRadius.circular(12),
            //                       boxShadow: [
            //                         BoxShadow(
            //                           color: Colors.black.withOpacity(0.05),
            //                           blurRadius: 5,
            //                           offset: const Offset(0, 2),
            //                         ),
            //                       ],
            //                     ),
            //                     child: Row(
            //                       children: [
            //                         CircleAvatar(
            //                           backgroundImage:
            //                               NetworkImage(item.game.icon),
            //                           radius: 25,
            //                         ),
            //                         const SizedBox(width: 12),
            //                         Expanded(
            //                           child: Text(
            //                             item.game.name,
            //                             style: const TextStyle(
            //                               fontSize: 14,
            //                               color: Colors.black,
            //                               fontWeight: FontWeight.w600,
            //                             ),
            //                           ),
            //                         ),
            //                         invisibleSwitch
            //                             ? Container()
            //                             : Obx(
            //                                 () => Switch(
            //                                   value: item.isActive.value,
            //                                   onChanged: (val) {
            //                                     controller.toggleGameStatus(
            //                                         item, index, val);
            //                                   },
            //                                 ),
            //                               )
            //                       ],
            //                     ),
            //                   );
            //                   //);
            //                 },
            //               )
            //             : SingleChildScrollView(
            //                 physics: const BouncingScrollPhysics(),
            //                 child: Wrap(
            //                   spacing: 16,
            //                   runSpacing: 16,
            //                   alignment: WrapAlignment.center,
            //                   children: games.map((game) {
            //                     print("game.name -----");
            //                     print(game.name);
            //                     return GestureDetector(
            //                       onTap: () {
            //                         if (showGame(game, controller.room.role)) {
            //                           print(game.url);
            //                           print(game.url);
            //                           Get.back();
            //                           controller.isPlayingGame.value = true;
            //                           //
            //                           // Get.to(GamePage(
            //                           //   gameUrl: game.url,
            //                           //   gameResponse:
            //                           //       controller.gameResponse.value!,
            //                           // ));
            //                         } else {
            //                           Get.showSnackbar(
            //                             GetSnackBar(
            //                               backgroundColor: Colors.transparent,
            //                               snackPosition: SnackPosition.TOP,
            //                               margin: const EdgeInsets.all(12),
            //                               borderRadius: 16,
            //                               duration: const Duration(seconds: 3),
            //                               isDismissible: true,
            //                               forwardAnimationCurve:
            //                                   Curves.easeOutBack,
            //                               reverseAnimationCurve:
            //                                   Curves.easeInBack,
            //                               messageText: Container(
            //                                 padding: const EdgeInsets.all(16),
            //                                 decoration: BoxDecoration(
            //                                   gradient: LinearGradient(
            //                                     colors: [
            //                                       Colors.purple
            //                                           .withOpacity(0.9),
            //                                       Colors.blue.withOpacity(0.9)
            //                                     ],
            //                                     begin: Alignment.topLeft,
            //                                     end: Alignment.bottomRight,
            //                                   ),
            //                                   borderRadius:
            //                                       BorderRadius.circular(16),
            //                                   boxShadow: [
            //                                     BoxShadow(
            //                                       color: Colors.black
            //                                           .withOpacity(0.2),
            //                                       blurRadius: 10,
            //                                       offset: const Offset(0, 4),
            //                                     ),
            //                                   ],
            //                                 ),
            //                                 child: Row(
            //                                   children: [
            //                                     const Icon(Icons.info_outline,
            //                                         color: Colors.white),
            //                                     const SizedBox(width: 12),
            //                                     Expanded(
            //                                       child: Text(
            //                                         AppStrings.hintCantPaly,
            //                                         style: const TextStyle(
            //                                             color: Colors.white,
            //                                             fontSize: 16),
            //                                       ),
            //                                     ),
            //                                   ],
            //                                 ),
            //                               ),
            //                             ),
            //                           );
            //                         }
            //                       },
            //                       child: Column(
            //                         mainAxisSize: MainAxisSize.min,
            //                         children: [
            //                           CircleAvatar(
            //                             backgroundImage:
            //                                 NetworkImage(game.icon),
            //                             radius: 30,
            //                           ),
            //                           const SizedBox(height: 6),
            //                           Text(
            //                             game.name,
            //                             style: const TextStyle(
            //                               fontSize: 13,
            //                               fontWeight: FontWeight.w500,
            //                               color: Colors.black,
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     );
            //                   }).toList(),
            //                 ),
            //               ),
            //       );
            //     }),
            //   ),
            // ).then((e) {
            //   controller.isInSettingsMode.value = false;
            // });
          },
          child: const Icon(
            Icons.games_rounded,
            color: ColorManager.white,
            size: 25,
          ),
        ),
        //   ),
        //    : Container()
        //     ),
        10.horizontalSpace(),
        InkWell(
          onTap: controller.loadingJoinRoom
              ? null
              : () {
                  final shareText =
                      "Checkout this room in SAI app ${DynamicLinkHandler.createRoomLink(id: controller.room.id.toInt(), roomName: controller.room.roomName)}";
                  Get.bottomSheet(ShareBottomSheet(
                    shareLink: shareText,
                  ));
                },
          child: const Icon(
            Icons.reply,
            color: ColorManager.white,
            size: 25,
          ),
        ),
        10.horizontalSpace(),
        InkWell(
          onTap: () => Get.dialog(const LeaveRoomDialog()),
          child: const Icon(
            Icons.power_settings_new,
            color: ColorManager.white,
            size: 25,
          ),
        ),
      ],
    );
  }

  buildGameListDiloag(BuildContext context) {
// تحكم بين العرضين

    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        elevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        title: Obx(
          () => Row(
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.deepPurpleAccent, Colors.blueAccent],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      controller.isInSettingsMode.value
                          ? AppStrings.settings
                          : AppStrings.gameList,
                      style: TextStyle(
                        fontSize: AppSize.s18(context),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              if (controller.room.role == 'admin' ||
                  controller.room.role == 'owner') ...[
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      controller.isInSettingsMode.toggle(); // تغيير الوضع
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.deepPurpleAccent, Colors.blueAccent],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Icon(
                            !controller.isInSettingsMode.value
                                ? Icons.settings
                                : Icons.arrow_forward,
                            color: Colors.white),
                      ),
                    ),
                  ),
                )
              ]
            ],
          ),
        ),
        content: Obx(() {
          if (controller.isLoadingGams.value) {
            return SizedBox(
                width: Get.width * 0.8,
                height: 200,
                child: const Center(child: AppLoader()));
          }
          final games = controller.gameResponse.value!.gameList;
          return SizedBox(
            width: Get.width * 0.8,
            height: 200,
            child: controller.isInSettingsMode.value
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.gameItems.length,
                    itemBuilder: (_, index) {
                      final item = controller.gameItems[index];
                      print("item.game.name");
                      print(item.game.name);
                      print(item.game.id);
                      return Obx(() => Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(item.game.icon),
                                  radius: 25,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    item.game.name,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Switch(
                                  value: item.isActive.value,
                                  onChanged: (val) {
                                    controller.toggleGameStatus(
                                        item, index, val);
                                  },
                                )
                              ],
                            ),
                          ));
                    },
                  )
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      alignment: WrapAlignment.center,
                      children: games.map((game) {
                        print(game.name);
                        return GestureDetector(
                          onTap: () {
                            if (showGame(game, controller.room.role)) {
                              Get.back();
                              Get.to(GamePage(
                                gameUrl: game.url,
                                gameResponse: controller.gameResponse.value!,
                              ));
                            } else {
                              Get.showSnackbar(
                                GetSnackBar(
                                  backgroundColor: Colors.transparent,
                                  snackPosition: SnackPosition.TOP,
                                  margin: const EdgeInsets.all(12),
                                  borderRadius: 16,
                                  duration: const Duration(seconds: 3),
                                  isDismissible: true,
                                  forwardAnimationCurve: Curves.easeOutBack,
                                  reverseAnimationCurve: Curves.easeInBack,
                                  messageText: Container(
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.purple.withOpacity(0.9),
                                          Colors.blue.withOpacity(0.9)
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.info_outline,
                                            color: Colors.white),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Text(
                                            AppStrings.hintCantPaly,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(game.icon),
                                radius: 30,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                game.name,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
          );
        }),
      ),
    ).then((e) {
      controller.isInSettingsMode.value = false;
    });
  }

  bool showGame(Game g, String userType) {
    if (g.id == 1077) {
      print("userType in fruty");
      print(userType);
      return true;
    } else {
      print("userType");
      print(userType);
      if (userType != 'guest' && userType != 'member') {
        return true;
      } else if (userType == 'member' && g.active == 1) {
        return true;
      }
    }
    return false;
  }
}
