import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_of_fortune/core/bindings/bindings.dart';
import 'package:game_of_fortune/core/common/functions.dart';
import 'package:game_of_fortune/core/constants/app_images/assets.dart';
import 'package:game_of_fortune/core/constants/app_colors.dart';
import 'package:game_of_fortune/core/constants/instances_constants.dart';
import 'package:game_of_fortune/core/utils/snackbars.dart';
import 'package:game_of_fortune/view/screens/auth/login.dart';
import 'package:game_of_fortune/view/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:game_of_fortune/view/screens/launch/get_started.dart';
import 'package:game_of_fortune/view/widgets/common_image_view_widget.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLoginScreen();
  }

  void _navigateToLoginScreen() {
    Timer(const Duration(seconds: 3), () async {
      if (auth.currentUser != null) {
        if (auth.currentUser!.emailVerified != true) {
          await auth.currentUser!.sendEmailVerification();
          auth.signOut();
          Get.offAll(Login());
          CustomSnackBars.instance.showFailureSnackbar(
              title: 'Attention',
              message:
                  'Emeail verification link sent. Please verify your email before proceeding further');
        } else {
          getUserDataStream(userId: auth.currentUser!.uid);
          Get.offAll(() => BottomNavBar(), binding: BottomBarBindings());
        }
      } else {
        Get.offAll(() => const GetStarted());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(color: kSecondaryColor),
      width: Get.width,
      height: Get.height,
      child: Center(
          child: CommonImageView(
        imagePath: Assets.imagesLogo,
        height: 280,
        fit: BoxFit.contain,
      )),
    ));
  }
}
