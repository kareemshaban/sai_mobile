import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/room/view/room_view.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:x_overlay/x_overlay.dart';

import 'app_image.dart';

class RoomOverlayWidget extends StatelessWidget {
  const RoomOverlayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appController = Get.find<AppController>();
    return XOverlayPage(
      controller: AppRoutes.overlayController,
      restoreWidgetQuery: (XOverlayData data) {
        return const RoomView();
      },
      contextQuery: () {
        return AppRoutes.navigatorKey.currentState!.context;
      },
      builder: (XOverlayData data) {
        return GestureDetector(
          onTap: () => AppRoutes.overlayController.restore(
            AppRoutes.navigatorKey.currentContext!,
            rootNavigator: true,
            withSafeArea: false,
          ),
          child: SizedBox(
            width: 150,
            height: 150,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Positioned.fill(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: ColorManager.gradientScaffoldColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: Image.network(
                              appController.user.profileImg,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const AppImage(
                                  image: Constants.userErrorWidget,
                                  width: 40,
                                  height: 40,
                                );
                              },
                            ),
                          ),
                        ),
                        5.verticalSpace(),
                        Text(
                          appController.user.name,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: Get.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
                PositionedDirectional(
                  top: 10,
                  start: 10,
                  child: GestureDetector(
                    onTap: () {
                      final roomController = Get.find<RoomController>();
                      roomController.closeAndDisposeRoom();
                      AppRoutes.overlayController.hide();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        CupertinoIcons.power,
                        size: 18,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
                ),
                PositionedDirectional(
                  bottom: 12,
                  child: Lottie.asset(
                    LottieAssets.pulse,
                    width: 25,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
