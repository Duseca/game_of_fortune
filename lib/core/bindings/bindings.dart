import 'package:game_of_fortune/controllers/auth/auth_controller.dart';
import 'package:game_of_fortune/controllers/game/game_controller.dart';
import 'package:get/get.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}

class BottomBarBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(GameController());
  }
}
