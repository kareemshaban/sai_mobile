import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_sai/app/notification_services/firebase_option.dart';
import 'app/app.dart';
import 'app/di/basic_di.dart';
import 'presentation/resources/language_manger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    log(e.toString());
  }
  await EasyLocalization.ensureInitialized();
  await initBasicsModule();
  runApp(
    EasyLocalization(
      supportedLocales: const [arabicLocale, englishLocal],
      path: assetPath,
      fallbackLocale: arabicLocale,
      child: const MyApp(),
    ),
  );
}
