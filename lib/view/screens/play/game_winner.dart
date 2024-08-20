import 'package:flutter/material.dart';
import 'package:game_of_fortune/constants/app_images/assets.dart';
import 'package:game_of_fortune/controllers/game/game_controller.dart';
import 'package:game_of_fortune/core/constants/app_colors.dart';
import 'package:game_of_fortune/core/constants/app_sizes.dart';
import 'package:game_of_fortune/core/constants/app_styling.dart';
import 'package:game_of_fortune/view/widgets/my_text_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../widgets/common_image_view_widget.dart';

class GameWinner extends StatefulWidget {
  const GameWinner({super.key});

  @override
  State<GameWinner> createState() => _GameWinnerState();
}

class _GameWinnerState extends State<GameWinner> {
  final gameController = Get.find<GameController>();
  @override
  void initState() {
    super.initState();
    gameController.getWinner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: AppSizes.HORIZONTAL,
              child: Container(
                decoration: rounded(
                  kPrimaryColor,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Stack(
                      children: [
                        Center(
                          child: CommonImageView(
                            imagePath: Assets.imagesProfile,
                            fit: BoxFit.contain,
                            height: 135,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 11.0),
                          child: Center(
                            child: Obx(
                              () => CommonImageView(
                                url: gameController.winner.value.img,
                                radius: 200,
                                height: 110,
                                width: 110,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    MyText(
                        paddingTop: 10,
                        lineHeight: 2,
                        paddingLeft: 20,
                        textAlign: TextAlign.center,
                        paddingRight: 20,
                        paddingBottom: 16,
                        size: 20,
                        text:
                            "The winner has been found. Our next game will be released on ${DateFormat('dd MMM, yyyy').format(gameController.game.value.canReplayAfter!)} at"),
                    MyText(
                        lineHeight: 1,
                        paddingLeft: 20,
                        textAlign: TextAlign.center,
                        paddingBottom: 20,
                        size: 24,
                        color: kSecondaryColor,
                        weight: FontWeight.bold,
                        text:
                            '${DateFormat('jm').format(gameController.game.value.canReplayAfter!)}')
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
