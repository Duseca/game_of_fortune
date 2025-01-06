import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:game_of_fortune/config/routes/routes.dart';
import 'package:game_of_fortune/config/themes/light_theme.dart';
import 'package:game_of_fortune/core/bindings/bindings.dart';
import 'package:game_of_fortune/firebase_options.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await MobileAds.instance.initialize();
    await GetStorage.init();
    await UnityAds.init(
      gameId: Platform.isAndroid ? '5698309' : '5698308',
      onComplete: () => print("init complete"),
      onFailed: (error, errorMessage) => print("init failed"),
    );

    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    runApp(MyApp());
  }, (err, stacktrace) {
    print('Exception caught in run zoned guarded');
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'GAME OF FORTUNE',
      theme: lightTheme,
      themeMode: ThemeMode.light,
      initialBinding: InitialBindings(),
      initialRoute: AppLinks.splash_screen,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
      getPages: AppRoutes.pages,
    );
  }
}
