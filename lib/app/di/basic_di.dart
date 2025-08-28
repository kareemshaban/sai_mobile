import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/app_pref.dart';
import 'package:new_sai/app/di/chat_di.dart';
import 'package:new_sai/app/di/stories_di.dart';
import 'package:new_sai/app/di/wallet_di.dart';
import 'package:new_sai/app/notification_services/notifications_service.dart';
import 'package:new_sai/data/network/app_api.dart';
import 'package:new_sai/data/network/dio_factory.dart';
import 'package:new_sai/data/network/network_info.dart';
import 'package:new_sai/presentation/pages/address_pages/address/getx/address_controller.dart';
import 'package:new_sai/presentation/pages/product_pages/cart/getx/cart_controller.dart';
import 'package:new_sai/presentation/pages/wallet_pages/cash_withdrawal/getx/cash_withdrawal_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_di.dart';
import 'auth_di.dart';
import 'hive_di.dart';
import 'notification_di.dart';
import 'reels_di.dart';
import 'room_di.dart';
import 'settings_di.dart';
import 'store_di.dart';

final instance = GetIt.instance;

Future<void> initBasicsModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(
    () => sharedPrefs,
  );

  instance.registerLazySingleton<AppPreferences>(
    () => AppPreferences(
      instance(),
    ),
  );

  instance.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      InternetConnectionChecker(),
    ),
  );

  instance.registerLazySingleton<DioFactory>(
    () => DioFactory(),
  );

  Dio dio = await instance<DioFactory>().getDio();

  instance.registerLazySingleton<AppServiceClient>(
    () => AppServiceClientImpl(dio),
  );
  await initHive();
  initAppModule();
  initAuthModule();
  initStoreModule();
  initRoomModule();
  initChatModule();
  initNotificationModule();
  initSettingsModule();
  initWalletModule();
  initStoriesModule();
  initReelsModule();

  Get.put(AppController(), permanent: true);
  Get.put(AddressController(), permanent: true);
  Get.put(CartController(), permanent: true);
  Get.put(CashWithdrawalController(), permanent: true);

  await NotificationsService.initNotificatios();
}
