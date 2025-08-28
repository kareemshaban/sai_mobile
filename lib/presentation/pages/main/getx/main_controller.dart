import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/app_pref.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/app/dynamic_link_handler.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/app/notification_services/notifications_service.dart';
import 'package:new_sai/data/network/dio_factory.dart';
import 'package:new_sai/presentation/pages/address_pages/address/getx/address_controller.dart';
import 'package:new_sai/presentation/pages/main/pages/income/view/income_view.dart';
import 'package:new_sai/presentation/pages/main/pages/income/widgets/income_app_bar.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/getx/profile_controller.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/view/profile_view.dart';
import 'package:new_sai/presentation/pages/main/pages/reels/getx/reels_controller.dart';
import 'package:new_sai/presentation/pages/main/pages/reels/view/reels_view.dart';
import 'package:new_sai/presentation/pages/main/pages/rooms/view/rooms_view.dart';
import 'package:new_sai/presentation/pages/main/pages/rooms/widget/rooms_app_bar.dart';
import 'package:new_sai/presentation/pages/main/pages/store/view/store_view.dart';
import 'package:new_sai/presentation/pages/main/pages/store/widgets/store_app_bar.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class MainController extends GetxController {
  final addressController = Get.find<AddressController>();
  final appController = Get.find<AppController>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final pages = const [
    StoreView(),
    RoomsView(),
    ReelsView(),
    IncomeView(),
    SafeArea(child: ProfileView()),
  ];
  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  final List<PreferredSizeWidget?> appBars = const [
    StoreAppBar(),
    RoomsAppBar(),
    null,
    IncomeAppBar(),
    null,
  ];

  final RxInt _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;

  set currentIndex(value) => _currentIndex.value = value;

  onChangeCurrentIndex(int value) {
    Get.find<ReelsController>().audioPlayer?.stop();
    currentIndex = value;
    if (value == 2) {
      Get.find<ReelsController>().reelsCurrentIndex = 0;
      Get.find<ReelsController>().onPageChanged(0);
      Get.find<ReelsController>().getReels();
    }
  }

  Future<void> initPusher() async {
    final pusherChannelName = 'presence-user.${appController.user.id}';
    try {
      await pusher.init(
        apiKey: "e940514bc5df15a423c0",
        cluster: "ap1",
        onError: onError,
        onSubscriptionSucceeded: onSubscriptionSucceeded,
        onEvent: onEvent,
        onSubscriptionError: onSubscriptionError,
        onAuthorizer: onAuthorizer,
      );
      await pusher.subscribe(
        channelName: pusherChannelName,
      );
      await pusher.connect();
    } catch (e) {
      debugPrint("Error while init pusherUser: $e");
    }
  }

  dynamic onAuthorizer(
      String pChannelName, String socketId, dynamic options) async {
    try {
      var authUrl = "/broadcasting/auth";
      var result = await (await instance<DioFactory>().getDio()).post(
        authUrl,
        data: {'socket_id': socketId, 'channel_name': pChannelName},
        options: Options(
          headers: {
            'Authorization': "Bearer ${_appPreferences.getUserToken()}"
          },
        ),
      );
      return result.data;
    } catch (e) {
      log("Error $e");
      return e;
    }
  }

  void onEvent(PusherEvent event) {
    debugPrint("pusherUser ${event.channelName} on Event: $event ");
    try {
      var eventData = jsonDecode(event.data.toString());
      if (eventData.isNotEmpty) {
        if (event.eventName == 'update.goldvalue') {
          final goldValue = num.parse(eventData['gold_value'].toString());
          appController.user.goldValue = goldValue;
          appController.saveUser(appController.user);
        }
        if (event.eventName == "message.counter.sent") {
          Get.find<ProfileController>().getNotifiactionCount();
        }
      }
    } catch (e) {
      debugPrint('pusherUser on event error: $e');
    }
  }

  void onError(String message, int? code, dynamic e) {
    debugPrint("pusherUser on Error: $message code: $code exception: $e");
  }

  void onSubscriptionSucceeded(String channelName, dynamic data) {
    debugPrint(
        "pusherUser on Subscription Succeeded: $channelName data: $data");
  }

  void onSubscriptionError(String message, dynamic e) {
    debugPrint("pusherUser on Subscription Error: $message Exception: $e");
  }

  @override
  void onInit() async {
    NotificationsService.initNotificatios();
    if (!isGuest()) {
      await addressController.getMyAddress();
      await initPusher();
      await DynamicLinkHandler.getInstance.initialize();
    }
    super.onInit();
  }
}
