import 'dart:io';

import 'package:easy_ads_flutter/easy_ads_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:game_of_fortune/config/routes/routes.dart';
import 'package:game_of_fortune/config/themes/light_theme.dart';
import 'package:game_of_fortune/core/bindings/bindings.dart';
import 'package:game_of_fortune/firebase_options.dart';
import 'package:get/get.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'core/utils/easy_ads_sdk.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

const IAdIdManager adIdManager = MyAdIdManager();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UnityAds.init(
    gameId: Platform.isAndroid ? '5698309' : '5698308',
    onComplete: () => print("init complete"),
    onFailed: (error, errorMessage) => print("init failed"),
  );
  await EasyAds.instance.initialize(
    isShowAppOpenOnAppStateChange: false,
    adIdManager,
    // adMobAdRequest: const AdRequest(),
    // admobConfiguration: RequestConfiguration(),
    showAdBadge: Platform.isIOS,
  );

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

const dummyimg1 =
    'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=633&q=80';
const dummyimg12 =
    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';
const dummyimg3 =
    'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

final String dummyImage =
    'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';

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
