import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/network/end_point.dart';
import 'package:new_sai/domain/entity/reels_entity/reels_entity.dart';
import 'package:new_sai/domain/use_case/reels_use_case/show_reels_use_case.dart';
import 'package:new_sai/domain/use_case/stories_use_case/get_story_by_id_use_case.dart';
import 'package:new_sai/presentation/pages/main/getx/main_controller.dart';
import 'package:new_sai/presentation/pages/main/pages/reels/getx/reels_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:x_overlay/x_overlay.dart';

final class DynamicLinkHandler {
  DynamicLinkHandler._();

  static final getInstance = DynamicLinkHandler._();

  final _appLinks = AppLinks();

  final GetStoryByIdUseCase _getStoryByIdUseCase =
      instance<GetStoryByIdUseCase>();
  final ShowReelsUseCase _showReelsUseCase = instance<ShowReelsUseCase>();

  Future<void> initialize() async {
    _appLinks.uriLinkStream.listen(_handleLinkData).onError((error) {
      log('$error', name: 'Dynamic Link Handler');
    });
    _checkInitialLink();
  }

  Future<void> _checkInitialLink() async {
    final initialLink = await _appLinks.getInitialLink();
    if (initialLink != null) {
      _handleLinkData(initialLink);
    }
  }

  void _handleLinkData(Uri data) async {
    final queryParams = data.queryParameters;
    log(data.toString(), name: 'Dynamic Link Handler');
    if (queryParams.isNotEmpty) {
      if (queryParams['type'] == "profile") {
        if (Get.find<AppController>().user.id ==
            int.parse(queryParams['id'] ?? "0")) {
          Get.find<MainController>().onChangeCurrentIndex(4);
          return;
        }
        Get.toNamed(
          AppRoutes.userProfileRoute,
          arguments: {
            'id': int.parse(queryParams['id'] ?? "0"),
            'isFromChat': false,
          },
        );
      }
      if (queryParams['type'] == "room") {
        if (Get.isRegistered<RoomController>()) {
          final roomController = Get.find<RoomController>();
          if (AppRoutes.overlayController.pageStateNotifier.value ==
              XOverlayPageState.overlaying) {
            AppRoutes.overlayController.hide();
            await roomController.closeAndDisposeRoom();
          }
          roomController.initController(queryParams['id'] ?? "0");
        }
        Get.toNamed(AppRoutes.roomRoute, arguments: {
          "id": queryParams['id'] ?? "0",
          "data": null,
        });
      }
      if (queryParams['type'] == "story") {
        (await _getStoryByIdUseCase
                .execute(int.parse(queryParams['id'] ?? "0")))
            .fold(
          (l) {},
          (r) {
            if (r.user.id == Get.find<AppController>().user.id) {
              Get.toNamed(AppRoutes.myStoryRoute, arguments: r);
            } else {
              Get.toNamed(AppRoutes.storyViewRoute, arguments: r);
            }
          },
        );
      }
      if (queryParams['type'] == "product") {
        Get.toNamed(
          AppRoutes.productDetailsRoute,
          arguments: int.parse(queryParams['id'] ?? "0"),
        );
      }
      if (queryParams['type'] == "reels") {
        ReelsEntity? reel;
        (await _showReelsUseCase.execute(int.parse(queryParams['id'] ?? "0")))
            .fold(
          (l) {},
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
      }
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

  static String createRoomLink({required int id, required String roomName}) {
    return "${EndPoint.baseShareUrl}?type=room&id=$id&title=$roomName";
  }

  static String createStoryLink({required int id}) {
    return "${EndPoint.baseShareUrl}?type=story&id=$id";
  }

  static String createProductLink(
      {required int id, required String productName}) {
    return "${EndPoint.baseShareUrl}?type=product&id=$id&title=$productName";
  }

  static String createReelsLink({required int id}) {
    return "${EndPoint.baseShareUrl}?type=reels&id=$id";
  }

  static String createProfileLink({required int id}) {
    return "${EndPoint.baseShareUrl}?type=profile&id=$id";
  }
}
