import 'package:easy_localization/easy_localization.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_pref.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/presentation/resources/language_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/theme_manger.dart';
import 'package:new_sai/presentation/widgets/room_overlay_widget.dart';
import 'package:x_overlay/x_overlay.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    context.setLocale(
      _appPreferences.getAppLanguage() == arabic ? arabicLocale : englishLocal,
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "SAI",
      localizationsDelegates: [
        ...context.localizationDelegates,
        CountryLocalizations.delegate,
      ],
      navigatorKey: AppRoutes.navigatorKey,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      fallbackLocale: arabicLocale,
      theme: getApplicationTheme(context),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashRoute,
      getPages: AppRoutes.pages,
      builder: (context, child) {
        return XOverlayPopScope(
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1),
            ),
            child: Stack(
              children: [
                child!,
                const RoomOverlayWidget(),
              ],
            ),
          ),
        );
      },
    );
  }
}
