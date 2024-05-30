import 'package:flutter/material.dart';
import 'package:game_of_fortune/constants/app_images/assets.dart';
import 'package:game_of_fortune/main.dart';
import 'package:game_of_fortune/view/constants/app_colors.dart';
import 'package:game_of_fortune/view/constants/app_sizes.dart';
import 'package:game_of_fortune/view/constants/app_styling.dart';
import 'package:game_of_fortune/view/widgets/common_image_view_widget.dart';
import 'package:game_of_fortune/view/widgets/my_text_widget.dart';

class GameWinner extends StatelessWidget {
  const GameWinner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          child: CommonImageView(
                            url: dummyimg1,
                            radius: 200,
                            height: 110,
                            width: 110,
                            fit: BoxFit.cover,
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
                          "The winner has been found. Unfortunately it wasn't you, but try your luck again soon, when we will announce our next game")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
