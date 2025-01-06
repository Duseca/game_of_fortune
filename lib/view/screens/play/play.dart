import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_of_fortune/controllers/game/game_controller.dart';
import 'package:game_of_fortune/core/constants/app_colors.dart';
import 'package:game_of_fortune/core/constants/app_sizes.dart';
import 'package:game_of_fortune/core/constants/app_styling.dart';
import 'package:game_of_fortune/core/constants/instances_constants.dart';
import 'package:game_of_fortune/models/choices_model.dart';
import 'package:game_of_fortune/view/widgets/common_image_view_widget.dart';
import 'package:game_of_fortune/view/widgets/my_button_widget.dart';
import 'package:game_of_fortune/view/widgets/my_text_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../../../core/constants/app_images/assets.dart';

class Play extends StatelessWidget {
  Play({super.key});
  final gameController = Get.find<GameController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool exitConfirmed = await showDialog(
          context: context,
          builder: (context) => Quit(),
        );

        // If the user confirms exit, exit the app
        if (exitConfirmed == true) {
          await gameController.updateScores();
          gameController.selectedChoices.clear();
          SystemNavigator.pop(); // Terminate the app
        }
        // Return true if the user confirms exit, false otherwise
        return exitConfirmed;
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 44,
                  ),
                  CommonImageView(
                    imagePath: Assets.imagesNewMainIcon,
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                  Obx(
                    () => MyText(
                      text: '${gameController.selectedChoices.length}/30',
                      size: 18,
                      weight: FontWeight.w500,
                      textAlign: TextAlign.center,
                      paddingTop: 10,
                    ),
                  ),
                  Container(
                    height: 90,
                    width: Get.width,
                    decoration: rounded(kSecondaryColor2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyText(text: 'Play & Win'),
                        Obx(
                          () => MyText(
                            text:
                                '\$${NumberFormat('#,##,000.00').format(double.tryParse(gameController.game.value.prize ?? '0'))}',
                            size: 46,
                            color: kSecondaryColor,
                            weight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  MyText(
                    text: 'Press left or right stepping stones to move on',
                    size: 16,
                    weight: FontWeight.w600,
                    paddingBottom: 20,
                    textAlign: TextAlign.center,
                    paddingTop: 30,
                  ),
                ],
              ),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Expanded(
                            child: MyButton(
                              buttonText: 'Press',
                              onTap: () {
                                var left = Random.secure().nextBool();
                                ChoicesModel choice =
                                    ChoicesModel(left: left, right: !left);
                                if (choice.left == true) {
                                  gameController.selectedChoices.add(choice);
                                  if (gameController.selectedChoices.length >=
                                      30) {
                                    Get.dialog(MoneyPrize());
                                  }
                                } else {
                                  Get.dialog(GameOver());
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            width: 60,
                          ),
                          Expanded(
                            child: MyButton(
                              buttonText: 'Press',
                              onTap: () {
                                var right = Random.secure().nextBool();
                                // var right = true;
                                ChoicesModel choice =
                                    ChoicesModel(left: !right, right: right);
                                if (choice.right == true) {
                                  gameController.selectedChoices.add(choice);
                                  if (gameController.selectedChoices.length ==
                                      30) {
                                    Get.dialog(MoneyPrize());
                                  }
                                  ;
                                } else {
                                  Get.dialog(GameOver());
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Obx(
                        () => ListView.builder(
                            shrinkWrap: true,
                            reverse: true,
                            itemCount: gameController.selectedChoices.length,
                            padding: EdgeInsets.all(0),
                            itemBuilder: (c, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: gameController
                                                    .selectedChoices[index]
                                                    .left ==
                                                true
                                            ? rounded2(
                                                Color(0xff00A300),
                                                Color(0xff00A300),
                                              )
                                            : rounded2(
                                                kGrey8Color, kGrey8Color),
                                        height: 40,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 60,
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: gameController
                                                    .selectedChoices[index]
                                                    .right ==
                                                true
                                            ? rounded2(
                                                Color(0xff00A300),
                                                Color(0xff00A300),
                                              )
                                            : rounded2(
                                                kGrey8Color, kGrey8Color),
                                        height: 40,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GameOver extends StatefulWidget {
  @override
  State<GameOver> createState() => _GameOverState();
}

class _GameOverState extends State<GameOver> {
  final gameController = Get.find<GameController>();

  @override
  void initState() {
    gameController.lifeUpdated(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // if (gameController.lifeUpdated.isFalse) {
        //   gameController.lifeUpdated(true);
        //   await gameController.updateLives('-');
        // }
        // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
        await gameController.updateScores();
        gameController.selectedChoices.clear();
        return await true;
      },
      child: Material(
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
                        Obx(
                          () => MyText(
                            text: gameController.selectedChoices.length
                                .toString()
                                .padLeft(2, '0'),
                            textAlign: TextAlign.center,
                            paddingBottom: 30,
                            size: 34,
                            weight: FontWeight.w800,
                            color: kSecondaryColor,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MyButton(
                              onTap: () async {
                                await gameController.updateScores();
                                gameController.selectedChoices.clear();
                                Get.back();
                                Get.back();
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
      ),
    );
  }
}

class Congrats extends StatelessWidget {
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

class Quit extends StatelessWidget {
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
                        text: 'Are you sure you want to Quit?',
                        size: 19,
                        weight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        color: kSecondaryColor,
                        paddingBottom: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MyButton(
                                  onTap: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  buttonText: 'No'),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MyButton(
                                  backgroundColor: kPrimaryColor,
                                  fontColor: kBlackColor,
                                  onTap: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  buttonText: 'Yes'),
                            ),
                          ),
                        ],
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
                  SizedBox(
                      height: 62,
                      child: Center(
                          child: Stack(
                        children: <Widget>[
                          // Stroked text as border.
                          Text(
                            'Confirm',
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
                            'Confirm',
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
  final gameController = Get.find<GameController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await gameController.updateReplayDuration();
        await gameController.updateScores();
        gameController.selectedChoices.clear();
        return await true;
      },
      child: Material(
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
                              text:
                                  'You are the Winner\nYou will be contacted by our team at ${auth.currentUser!.email} to discuss prize distribution method.',
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
                              text:
                                  '\$${'${gameController.game.value.prize}'.toString()}',
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MyButton(
                                  onTap: () async {
                                    await gameController.updateReplayDuration();
                                    await gameController.updateScores();
                                    gameController.selectedChoices.clear();
                                    Get.back();
                                    Get.back();
                                  },
                                  buttonText: 'Ok'),
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
            SizedBox(
                height: 300,
                child: Center(
                    child: Stack(
                  children: <Widget>[
                    Lottie.asset(
                      Assets.imagesGlow,
                    )
                  ],
                ))),
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
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
              padding: const EdgeInsets.only(top: 90.0),
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
      ),
    );
  }
}
