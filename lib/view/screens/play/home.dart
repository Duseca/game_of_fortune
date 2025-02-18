import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:game_of_fortune/controllers/game/game_controller.dart';
import 'package:game_of_fortune/core/constants/app_images/assets.dart';
import 'package:game_of_fortune/core/constants/app_colors.dart';
import 'package:game_of_fortune/core/constants/app_sizes.dart';
import 'package:game_of_fortune/core/constants/app_styling.dart';
import 'package:game_of_fortune/core/constants/instances_constants.dart';
import 'package:game_of_fortune/services/local_storage/local_storage_service.dart';
import 'package:game_of_fortune/services/mobile_ads/mobile_ads.dart';
import 'package:game_of_fortune/view/screens/play/game_winner.dart';
import 'package:game_of_fortune/view/screens/play/play.dart';
import 'package:game_of_fortune/view/widgets/common_image_view_widget.dart';
import 'package:game_of_fortune/view/widgets/my_button_widget.dart';
import 'package:game_of_fortune/view/widgets/my_text_widget.dart';
import 'package:game_of_fortune/view/widgets/tips.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final gameController = Get.find<GameController>();
  late BannerAd bannerAd;

  bool isAdLoaded = false;

  initBannerAd() {
    bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: AdService.bannerAdUnitId!,
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            setState(() {
              isAdLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
            print("error $error");
          },
        ),
        request: AdRequest());
    bannerAd.load();
  }

  @override
  void initState() {
    super.initState();
    gameController.getGame();
    gameController.createRewardedAd(context);

    initBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: isAdLoaded,
              child: Container(
                color: kBlackColor,
                height: bannerAd.size.height.toDouble(),
                width: Get.width,
                child: AdWidget(ad: bannerAd),
              ),
            ),
            Flexible(
              child: ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  CommonImageView(
                    imagePath: Assets.imagesNewMainIcon,
                    height: 60,
                    fit: BoxFit.contain,
                  ),
                  Obx(
                    () => gameController.isloading.isFalse
                        ? ListView(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            children: [
                              Visibility(
                                visible: gameController.canReplay(),
                                child: ListView(
                                  shrinkWrap: true,
                                  padding: AppSizes.DEFAULT,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    MyText(
                                      paddingTop: 10,
                                      text: 'Lives Remaining',
                                      size: 18,
                                      paddingBottom: 10,
                                      textAlign: TextAlign.center,
                                      weight: FontWeight.w600,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                                text: userModelGlobal
                                                                .value.lives !=
                                                            null &&
                                                        userModelGlobal
                                                                .value.lives! <
                                                            0
                                                    ? '0'
                                                    : userModelGlobal
                                                        .value.lives
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
                                      paddingTop: 20,
                                      text: 'Get Another Life',
                                      size: 18,
                                      paddingBottom: 10,
                                      textAlign: TextAlign.center,
                                      weight: FontWeight.w600,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            await gameController
                                                .createRewardedAd(context);
                                            gameController
                                                .showRewardedAd(context);
                                          },
                                          child: Container(
                                            width: 150,
                                            decoration: rounded2(
                                                kSecondaryColor,
                                                kTertiaryColor),
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
                                    SizedBox(height: 20),
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
                                                  '\$${(NumberFormat('#,##,000.00').format(double.tryParse(gameController.game.value.prize ?? '0')))}',
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
                                      paddingTop: 20,
                                    ),
                                    // MyButton(
                                    //     mBottom: 120,
                                    //     onTap: () async {
                                    //       var showTips =
                                    //           await LocalStorageService.instance
                                    //               .read(key: 'showTips');
                                    //       if (showTips == null ||
                                    //           showTips == false) {
                                    //         Get.to(Tips());
                                    //       } else {
                                    //         if (userModelGlobal.value.lives! >
                                    //             0) {
                                    //           await gameController
                                    //               .updateLives('-');
                                    //           Get.to(() => Play());
                                    //         } else {
                                    //           Get.dialog(
                                    //             barrierDismissible: false,
                                    //             OhSnap(),
                                    //           );
                                    //         }
                                    //       }
                                    //     },
                                    //     buttonText: 'Play'),
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
            Padding(
              padding: AppSizes.HORIZONTAL,
              child: MyButton(
                  mBottom: 120,
                  onTap: () async {
                    var showTips = await LocalStorageService.instance
                        .read(key: 'showTips');
                    if (showTips == null || showTips == false) {
                      Get.to(Tips());
                    } else {
                      if (userModelGlobal.value.lives! > 0) {
                        await gameController.updateLives('-');
                        Get.to(() => Play());
                      } else {
                        Get.dialog(
                          barrierDismissible: false,
                          OhSnap(),
                        );
                      }
                    }
                  },
                  buttonText: 'Play'),
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
    return Material(
      color: const Color.fromRGBO(0, 0, 0, 0),
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
                        onTap: () async {
                          Get.back();
                          await gameController.createRewardedAd(context);
                          gameController.showRewardedAd(context);
                        },
                        child: Container(
                          width: 150,
                          decoration: rounded2(kSecondaryColor, kTertiaryColor),
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
    );
  }
}
