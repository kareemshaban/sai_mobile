import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/app_pref.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/data/mapper/notification_mapper.dart';
import 'package:new_sai/data/model/notification_model/notification_model.dart';
import 'package:new_sai/data/params/auth_params/auth_params.dart';
import 'package:new_sai/domain/entity/chat_entity/chat_user_info_entity.dart';
import 'package:new_sai/domain/entity/reels_entity/reels_entity.dart';
import 'package:new_sai/domain/use_case/auth_use_case/update_fcm_token_use_case.dart';
import 'package:new_sai/domain/use_case/reels_use_case/show_reels_use_case.dart';
import 'package:new_sai/domain/use_case/stories_use_case/get_story_by_id_use_case.dart';
import 'package:new_sai/presentation/pages/main/getx/main_controller.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/getx/profile_controller.dart';
import 'package:new_sai/presentation/pages/main/pages/reels/getx/reels_controller.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';
import 'package:x_overlay/x_overlay.dart';

class NotificationsService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final UpdateFcmTokenUseCase _fcmTokenUseCase =
      instance<UpdateFcmTokenUseCase>();

  static Future<void> initNotificatios() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      defaultPresentSound: true,
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        handleNotificationTap(details.payload);
      },
    );

    final details =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    if (details?.didNotificationLaunchApp ?? false) {
      // App was launched by tapping a local notification
      handleNotificationTap(details!.notificationResponse?.payload);
    }

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(sound: true, badge: true, alert: true);

    try {
      FirebaseMessaging.onMessage.listen((message) {
        final AppPreferences appPreferences = instance<AppPreferences>();

        if (appPreferences.getNotificationID() != message.messageId) {
          showNotification(message);
        }

        appPreferences.setNotificationID(message.messageId ?? "");
      });

      FirebaseMessaging.onMessageOpenedApp.listen(
        (message) {
          handleNotificationTap(jsonEncode(message.data));
        },
      );

      FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);

      FirebaseMessaging.instance.subscribeToTopic("general");
      await updateFcmToken();

      RemoteMessage? initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();

      if (initialMessage != null) {
        handleNotificationTap(jsonEncode(initialMessage.data));
      }
    } catch (e) {
      log(e.toString(), name: "FIREBASE TOKEN ERROR");
    }
  }

  static Future<void> cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  static showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      "general",
      "General Notification",
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      icon: '@mipmap/ic_launcher',
    );

    const DarwinNotificationDetails iosPlatformChannelSpecifics =
        DarwinNotificationDetails(
      presentSound: true,
      presentAlert: true,
      threadIdentifier: "general",
      subtitle: "General Notification",
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      DateTime.now().second,
      message.notification?.title ?? "",
      message.notification?.body ?? "",
      payload: jsonEncode(message.data),
      platformChannelSpecifics,
    );

    if (Get.isRegistered<ProfileController>()) {
      Get.find<ProfileController>().getNotifiactionCount();
    }
  }

  static updateFcmToken() async {
    if (isGuest()) {
      return;
    }
    final token = await FirebaseMessaging.instance.getToken();
    await _fcmTokenUseCase.execute(
      AuthParams(
        fcmToken: token,
      ),
    );
  }
}

@pragma('vm:entry-point')
Future<void> firebaseBackgroundHandler(RemoteMessage message) async {}

@pragma('vm:entry-point')
void handleNotificationTap(String? payload) async {
  final data = jsonDecode(payload ?? "{}");

  if (data['type'] != null) {
    switch (data['type']) {
      case "chat":
        final params =
            NotificationIDModel.fromJson(json.decode(data['id'])).toDomain();
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
        final params = int.parse(data['id']);
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
        final params = int.parse(data['id']);
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
        final params = int.parse(data['id']);
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
        final params = int.parse(data['id']);
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
        final params = int.parse(data['id']);
        Get.toNamed(AppRoutes.orderDetailsRoute, arguments: params);
      case "profile":
        final params = int.parse(data['id']);
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
