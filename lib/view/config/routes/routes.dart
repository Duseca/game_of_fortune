import 'package:game_of_fortune/view/screens/launch/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final List<GetPage> pages = [
    GetPage(
      name: AppLinks.splash_screen,
      page: () => SplashScreen(),
    ),
  ];
}

class AppLinks {
  static const splash_screen = '/splash_screen';
}
