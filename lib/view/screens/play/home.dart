import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:game_of_fortune/controllers/game/game_controller.dart';
import 'package:game_of_fortune/core/constants/app_images/assets.dart';
import 'package:game_of_fortune/core/constants/app_colors.dart';
import 'package:game_of_fortune/core/constants/app_sizes.dart';
import 'package:game_of_fortune/core/constants/app_styling.dart';
import 'package:game_of_fortune/core/constants/instances_constants.dart';
import 'package:game_of_fortune/view/screens/play/game_winner.dart';
import 'package:game_of_fortune/view/screens/play/play.dart';
import 'package:game_of_fortune/view/widgets/common_image_view_widget.dart';
import 'package:game_of_fortune/view/widgets/my_button_widget.dart';
import 'package:game_of_fortune/view/widgets/my_text_widget.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final gameController = Get.find<GameController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 20,
            ),
            CommonImageView(
              imagePath: Assets.imagesGE,
              height: 50,
              fit: BoxFit.contain,
            ),
            Obx(
              () => gameController.isloading.isFalse
                  ? Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Visibility(
                            visible: gameController.canReplay(),
                            child: ListView(
                              shrinkWrap: true,
                              padding: AppSizes.DEFAULT,
                              physics: const BouncingScrollPhysics(),
                              children: [
                                MyText(
                                  paddingTop: 30,
                                  text: 'Lives Remaining',
                                  size: 18,
                                  paddingBottom: 20,
                                  textAlign: TextAlign.center,
                                  weight: FontWeight.w600,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 150,
                                      decoration: rounded2(
                                          kSecondaryColor, kTertiaryColor),
                                      child: Center(
                                        child: Obx(
                                          () => MyText(
                                            paddingBottom: 10,
                                            paddingTop: 10,
                                            text: userModelGlobal.value.lives !=
                                                        null &&
                                                    userModelGlobal
                                                            .value.lives! <
                                                        0
                                                ? '0'
                                                : userModelGlobal.value.lives
                                                    .toString()
                                                    .padLeft(2, '0'),
                                            color: kPrimaryColor,
                                            size: 22,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                MyText(
                                  paddingTop: 30,
                                  text: 'Get Another Life',
                                  size: 18,
                                  paddingBottom: 20,
                                  textAlign: TextAlign.center,
                                  weight: FontWeight.w600,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        gameController.showRewardedAd();
                                        log("message:shown ${userModelGlobal.value.lives}");
                                      },
                                      child: Container(
                                        width: 150,
                                        decoration: rounded2(
                                            kSecondaryColor, kTertiaryColor),
                                        child: Center(
                                          child: MyText(
                                            paddingBottom: 10,
                                            paddingTop: 10,
                                            text: 'Watch Video',
                                            color: kPrimaryColor,
                                            size: 22,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 40),
                                Container(
                                  height: 138,
                                  decoration: rounded(kSecondaryColor2),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      MyText(text: 'Play & Win'),
                                      Obx(
                                        () => MyText(
                                          text:
                                              '\$${'${gameController.game.value.prize}.'.toString().padRight(6, '0')}',
                                          size: 46,
                                          color: kSecondaryColor,
                                          weight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                MyText(
                                  text: 'Playing cost one Life',
                                  size: 16,
                                  weight: FontWeight.w600,
                                  paddingBottom: 20,
                                  textAlign: TextAlign.center,
                                  paddingTop: 30,
                                ),
                                MyButton(
                                    onTap: () {
                                      if (userModelGlobal.value.lives! > 0) {
                                        Get.to(() => Play());
                                      } else {
                                        Get.dialog(OhSnap());
                                      }
                                    },
                                    buttonText: 'Play')
                              ],
                            ),
                          ),
                          Visibility(
                              visible: !gameController.canReplay(),
                              child: Container(
                                  alignment: Alignment.center,
                                  height: Get.height * 0.75,
                                  child: GameWinner())),
                        ],
                      ),
                    )
                  : SizedBox(
                      height: Get.height * 0.8,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class OhSnap extends StatelessWidget {
  final gameController = Get.find<GameController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Material(
        color: const Color.fromRGBO(0, 0, 0, 0),
        child: GestureDetector(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                      padding: EdgeInsets.all(28),
                      margin: AppSizes.DEFAULT,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: kPrimaryColor,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 8),
                            color: kTertiaryColor,
                            blurRadius: 0,
                            spreadRadius: 0,
                          ),
                          BoxShadow(
                            offset: Offset(0, 3),
                            color: kSecondaryColor,
                            blurRadius: 0,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 26,
                          ),
                          MyText(
                            paddingTop: 20,
                            text: 'You are out of lives',
                            textAlign: TextAlign.center,
                          ),
                          MyText(
                            text: '0',
                            textAlign: TextAlign.center,
                            paddingBottom: 30,
                            size: 50,
                            weight: FontWeight.w800,
                            color: kRedColor,
                          ),
                          InkWell(
                            onTap: () {
                              gameController.showRewardedAd();
                              Get.back();
                            },
                            child: Container(
                              width: 150,
                              decoration:
                                  rounded2(kSecondaryColor, kTertiaryColor),
                              child: Center(
                                child: MyText(
                                  paddingBottom: 10,
                                  paddingTop: 10,
                                  text: 'Watch Video',
                                  color: kPrimaryColor,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Center(
                        child: CommonImageView(
                          imagePath: Assets.imagesRibbon,
                          height: 94,
                        ),
                      ),
                      SizedBox(
                          height: 62,
                          child: Center(
                              child: Stack(
                            children: <Widget>[
                              // Stroked text as border.
                              Text(
                                'Oh Snap!',
                                style: TextStyle(
                                  fontSize: 20,
                                  letterSpacing: 1,
                                  shadows: [
                                    Shadow(
                                      color: Colors
                                          .black, // Choose the color of the first shadow
                                      blurRadius:
                                          0.0, // Adjust the blur radius for the first shadow effect
                                      offset: Offset(2.0,
                                          2.0), // Set the horizontal and vertical offset for the first shadow
                                    ),
                                  ],
                                  foreground: Paint()
                                    ..style = PaintingStyle.stroke
                                    ..strokeWidth = 2
                                    ..color = kSecondaryColor,
                                ),
                              ),
                              // Solid text as fill.
                              Text(
                                'Oh Snap! 😭',
                                style: TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 20,
                                  color: Colors.grey[300],
                                ),
                              ),
                            ],
                          )))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
