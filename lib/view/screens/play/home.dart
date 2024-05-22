import 'package:flutter/material.dart';
import 'package:game_of_fortune/core/constants/app_images/assets.dart';
import 'package:game_of_fortune/core/constants/app_colors.dart';
import 'package:game_of_fortune/core/constants/app_sizes.dart';
import 'package:game_of_fortune/core/constants/app_styling.dart';
import 'package:game_of_fortune/core/constants/instances_constants.dart';
import 'package:game_of_fortune/view/screens/play/play.dart';
import 'package:game_of_fortune/view/widgets/common_image_view_widget.dart';
import 'package:game_of_fortune/view/widgets/my_button_widget.dart';
import 'package:game_of_fortune/view/widgets/my_text_widget.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
            Expanded(
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
                        decoration: rounded2(kSecondaryColor, kTertiaryColor),
                        child: Center(
                          child: Obx(
                            () => MyText(
                              paddingBottom: 10,
                              paddingTop: 10,
                              text: userModelGlobal.value.lives
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
                      Container(
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
                    ],
                  ),
                  SizedBox(height: 40),
                  Container(
                    height: 138,
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
                        Get.to(() => Play());
                      },
                      buttonText: 'Play')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
