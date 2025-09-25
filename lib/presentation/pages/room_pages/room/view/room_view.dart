import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/game/view/game_page.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_dilaog/leave_room_dialog.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_widgets/gift_svg_player.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/music/room_music_player.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_widgets/room_app_bar.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_widgets/room_bottom_bar_widget.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_widgets/room_floating_buttons.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_widgets/room_message_list.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_widgets/room_seat_list.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_widgets/room_user_list.dart';
import 'package:new_sai/presentation/pages/room_pages/room/widget/room_widgets/seat_widget.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

import '../../../../widgets/privilege_data_view.dart';
import '../widget/room_widgets/gift_json.dart';

class RoomView extends GetView<RoomController> {
  const RoomView({super.key});

  @override
  Widget build(BuildContext context) {
    print(controller.user.privileges.data.entryWithInfluences.file);
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    print("controller.loadingJoinRoom");
    print(controller.loadingJoinRoom);
    print(controller);
    print("controller.isPlayingGame.value");
    print(controller.isPlayingGame.value);
    controller.enableScroll = MediaQuery.viewInsetsOf(context).bottom != 0 &&
        controller.focusNode.hasFocus;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          Get.dialog(const LeaveRoomDialog());
        }
      },
      child: Obx(
        () => Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: controller.room.backgroundTheme.isNotEmpty
              ? ColorManager.transparent
              : ColorManager.primary,
          body: Obx(
            () {
              if (controller.loadingJoinRoom) {
                // controller.isPlayingGame.value = false;
                return Stack(
                  children: [
                    if (controller.room.backgroundTheme.isNotEmpty) ...[
                      AppImage(
                        image: controller.room.backgroundTheme,
                        fit: BoxFit.cover,
                        width: 1.w(context),
                        height: 1.h(context),
                      ),
                      Container(
                        width: 1.w(context),
                        height: 1.h(context),
                        color: ColorManager.black.withOpacity(.2),
                      ),
                    ],
                    if (controller.room.backgroundTheme.isEmpty)
                      SizedBox(
                          // fit: BoxFit.cover,
                          width: 1.w(context),
                          height: 1.h(context),
                          child: Image.asset(
                            "assets/images/default_wallpaper.jpg",
                            fit: BoxFit.cover,
                          )),
                    SingleChildScrollView(
                      controller: controller.scrollController,
                      physics: controller.enableScroll
                          ? null
                          : const NeverScrollableScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 1.h(context)),
                        child: Column(
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                        ),
                                        child: RoomAppBar(),
                                      ),
                                      8.verticalSpace(),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                        ),
                                        child: RoomUserList(),
                                      ),
                                      10.verticalSpace(),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                        ),
                                        child: Column(
                                          children: [
                                            const Center(
                                              child: SeatWidget(
                                                index: 0,
                                                isLoading: true,
                                              ),
                                            ),
                                            10.verticalSpace(),
                                            Center(
                                              child: Wrap(
                                                spacing: 10,
                                                runSpacing: 10,
                                                children: List.generate(
                                                  6,
                                                  (index) => SeatWidget(
                                                    index: index + 1,
                                                    isLoading: true,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (!isKeyboardOpen)...[
                                        10.verticalSpace(),
                                        const RoomMessageList(true),
                                        10.verticalSpace(),
                                      ]
                                    ],
                                  ),
                                  if (controller.enableScroll)
                                    GestureDetector(
                                      onTap: controller.unFocusNode,
                                      onHorizontalDragUpdate: (_) {
                                        controller.unFocusNode();
                                      },
                                      onVerticalDragUpdate: (_) {
                                        controller.unFocusNode();
                                      },
                                      child: Container(
                                        color:
                                            ColorManager.black.withOpacity(.0),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            SafeArea(
                              bottom: Platform.isIOS,
                              top: false,
                              left: false,
                              right: false,
                              minimum: Platform.isIOS
                                  ? const EdgeInsets.symmetric(vertical: 20)
                                  : EdgeInsets.zero,
                              child: const RoomBottomBarWidget(
                                isLoading: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 1.w(context),
                      height: 1.h(context),
                      color: ColorManager.black.withOpacity(.5),
                      child: const Center(
                        child: AppLoader(
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                    if (controller.isPlayingGame.value) const GamePageInRoom(),
                    if (isKeyboardOpen)
                      Padding(
                        padding: EdgeInsets.only(bottom: keyboardHeight + 45),
                        child: Container(
                          color: ColorManager.darkGreyColor,
                          padding: const EdgeInsets.only(top: 50),
                          child:  const RoomMessageList(true),
                        ),
                      ),
                  ],
                );
              } else {
                return Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    if (controller.room.backgroundTheme.isNotEmpty) ...[
                      AppImage(
                        image: controller.room.backgroundTheme,
                        fit: BoxFit.cover,
                        width: 1.w(context),
                        height: 1.h(context),
                      ),
                      Container(
                        width: 1.w(context),
                        height: 1.h(context),
                        color: ColorManager.black.withOpacity(.2),
                      ),
                    ],
                    if (controller.room.backgroundTheme.isEmpty)
                      Container(
                          // fit: BoxFit.cover,
                          width: 1.w(context),
                          height: 1.h(context),
                          child: Image.asset(
                            "assets/images/default_wallpaper.jpg",
                            fit: BoxFit.cover,
                          )),
                    SingleChildScrollView(
                      controller: controller.scrollController,
                      physics: controller.enableScroll
                          ? null
                          : const NeverScrollableScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: 1.w(context), maxHeight: 1.h(context)),
                        child: Column(
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                        ),
                                        child: RoomAppBar(),
                                      ),
                                      8.verticalSpace(),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                        ),
                                        child: RoomUserList(),
                                      ),
                                      10.verticalSpace(),
                                      const Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                        ),
                                        child: RoomSeatList(),
                                      ),
                                      if (!isKeyboardOpen) ...[
                                        10.verticalSpace(),
                                        const RoomMessageList(true),
                                        10.verticalSpace(),
                                      ]
                                    ],
                                  ),
                                  if (controller.enableScroll)
                                    GestureDetector(
                                      onTap: controller.unFocusNode,
                                      onHorizontalDragUpdate: (_) {
                                        controller.unFocusNode();
                                      },
                                      onVerticalDragUpdate: (_) {
                                        controller.unFocusNode();
                                      },
                                      child: Container(
                                        color:
                                            ColorManager.black.withOpacity(.0),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            SafeArea(
                              bottom: Platform.isIOS,
                              top: false,
                              left: false,
                              right: false,
                              minimum: Platform.isIOS
                                  ? const EdgeInsets.symmetric(vertical: 20)
                                  : EdgeInsets.zero,
                              child: const RoomBottomBarWidget(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(() => Get.find<RoomController>().showLottie.value
                        ? const LottieScreen()
                        : const SizedBox.shrink()),
                    if (isKeyboardOpen)
                      Padding(
                        padding: EdgeInsets.only(bottom: keyboardHeight + 45),
                        child: Container(
                          color: ColorManager.darkGreyColor.withValues(alpha: 0.5),
                          padding: const EdgeInsets.only(top: 55),
                          child:  const RoomMessageList(true),
                        ),
                      ),
                    //  Lottie.asset(LottieAssets.data1),

                    const GiftSvgPlayer(),
                    if (controller.showMusicPlayer)
                      const PositionedDirectional(
                        bottom: 70,
                        start: 20,
                        child: RoomMusicPlayer(),
                      ),
                    if (controller.isPlayingGame.value) GamePageInRoom(),
                    // GamePage(
                    //   gameUrl: controller.gameItems[0].game.url,
                    //   gameResponse: controller.gameResponse.value!,
                    // )
                  ],
                );
              }
            },
          ),
          floatingActionButton: controller.isPlayingGame.value
              ? const SizedBox()
              : const RoomFloatingButtons(),
        ),
      ),
    );
  }
}
