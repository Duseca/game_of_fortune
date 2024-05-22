import 'package:flutter/material.dart';

import 'package:game_of_fortune/core/constants/app_colors.dart';
import 'package:game_of_fortune/core/constants/app_sizes.dart';
import 'package:game_of_fortune/core/constants/app_styling.dart';
import 'package:game_of_fortune/view/widgets/common_image_view_widget.dart';
import 'package:game_of_fortune/view/widgets/my_button_widget.dart';
import 'package:game_of_fortune/view/widgets/my_text_widget.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/app_images/assets.dart';

class Play extends StatelessWidget {
  const Play({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 44,
          ),
          CommonImageView(
            imagePath: Assets.imagesGE,
            height: 50,
            fit: BoxFit.contain,
          ),
          MyText(
            text: '4/30',
            size: 18,
            weight: FontWeight.w500,
            textAlign: TextAlign.center,
            paddingTop: 10,
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                  height: 90,
                  decoration: rounded(kSecondaryColor2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MyText(text: 'Play & Win'),
                      MyText(
                        text: '\$10.000',
                        size: 46,
                        color: kSecondaryColor,
                        weight: FontWeight.bold,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.25,
                ),
                MyText(
                  text: 'Press left or right stepping stones to move on',
                  size: 16,
                  weight: FontWeight.w600,
                  paddingBottom: 20,
                  textAlign: TextAlign.center,
                  paddingTop: 30,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        MyButton(
                          buttonText: 'Press',
                          onTap: () {
                            Get.dialog(Congrats());
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: rounded2(kGrey8Color, kGrey8Color),
                          height: 40,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: rounded2(
                            Color(0xff00A300),
                            Color(0xff00A300),
                          ),
                          height: 40,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: rounded2(kGrey8Color, kGrey8Color),
                          height: 40,
                        )
                      ],
                    )),
                    SizedBox(
                      width: 57,
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        MyButton(
                          buttonText: 'Press',
                          onTap: () {
                            Get.dialog(GameOver());
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: rounded2(
                            Color(0xff00A300),
                            Color(0xff00A300),
                          ),
                          height: 40,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: rounded2(kGrey8Color, kGrey8Color),
                          height: 40,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: rounded2(
                            Color(0xff00A300),
                            Color(0xff00A300),
                          ),
                          height: 40,
                        ),
                      ],
                    ))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GameOver extends StatelessWidget {
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
                        text: 'Your New Score is',
                        textAlign: TextAlign.center,
                      ),
                      MyText(
                        text: '24',
                        textAlign: TextAlign.center,
                        paddingBottom: 30,
                        size: 34,
                        weight: FontWeight.w800,
                        color: kSecondaryColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MyButton(onTap: () {}, buttonText: 'Done'),
                      ),
                      SizedBox(
                        height: 40,
                      )
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
                            'Game Over',
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
                            'Game Over',
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

class Congrats extends StatelessWidget {
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
                        text: 'You are on Top of Scoreboard',
                        size: 19,
                        weight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        color: kSecondaryColor,
                      ),
                      MyText(
                        paddingTop: 20,
                        text: 'Your New Score is',
                        textAlign: TextAlign.center,
                      ),
                      MyText(
                        text: '24',
                        textAlign: TextAlign.center,
                        paddingBottom: 30,
                        size: 34,
                        weight: FontWeight.w800,
                        color: kSecondaryColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MyButton(
                            onTap: () {
                              Get.dialog(MoneyPrize());
                            },
                            buttonText: 'Done'),
                      ),
                      SizedBox(
                        height: 40,
                      )
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
                            'Congrats',
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
                            'Congrats',
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

class MoneyPrize extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromRGBO(0, 0, 0, 0),
      child: Stack(
        children: [
          Column(
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
                          Center(
                              child: Stack(
                            children: <Widget>[
                              // Stroked text as border.
                              Text(
                                'Congratulations',
                                style: TextStyle(
                                  fontSize: 24,
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
                                    ..strokeWidth = 1.5
                                    ..color = kSecondaryColor,
                                ),
                              ),
                              // Solid text as fill.
                              Text(
                                'Congratulations',
                                style: TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 24,
                                  color: Colors.grey[300],
                                ),
                              ),
                            ],
                          )),
                          MyText(
                            paddingTop: 20,
                            text: 'You are the Winner',
                            size: 19,
                            weight: FontWeight.w600,
                            textAlign: TextAlign.center,
                            color: kSecondaryColor,
                          ),
                          MyText(
                            paddingTop: 20,
                            text: 'You have won',
                            textAlign: TextAlign.center,
                          ),
                          MyText(
                            text: '\$10,000',
                            textAlign: TextAlign.center,
                            size: 34,
                            weight: FontWeight.w800,
                            color: kSecondaryColor,
                          ),
                          MyText(
                            paddingTop: 20,
                            text: 'Your Score is',
                            textAlign: TextAlign.center,
                          ),
                          MyText(
                            text: '30',
                            textAlign: TextAlign.center,
                            size: 34,
                            weight: FontWeight.w800,
                            color: kBlueColor,
                          ),
                          MyText(
                            paddingTop: 20,
                            text: 'Please verify your email to get the reward',
                            paddingBottom: 20,
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MyButton(
                                onTap: () {}, buttonText: 'Verify Email'),
                          ),
                          SizedBox(
                            height: 20,
                          )
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
                    ],
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: SizedBox(
                height: 300,
                child: Center(
                    child: Stack(
                  children: <Widget>[
                    Lottie.asset(
                      Assets.imagesGlow,
                    )
                  ],
                ))),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: SizedBox(
                height: 142,
                child: Center(
                    child: Stack(
                  children: <Widget>[
                    CommonImageView(
                      imagePath: Assets.imagesGlow2,
                    )
                  ],
                ))),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: SizedBox(
                height: 162,
                child: Center(
                    child: Stack(
                  children: <Widget>[
                    CommonImageView(
                      imagePath: Assets.imagesMoney,
                    )
                  ],
                ))),
          )
        ],
      ),
    );
  }
}
