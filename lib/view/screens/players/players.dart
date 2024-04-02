import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game_of_fortune/constants/app_images/assets.dart';
import 'package:game_of_fortune/main.dart';
import 'package:game_of_fortune/view/constants/app_colors.dart';
import 'package:game_of_fortune/view/constants/app_sizes.dart';
import 'package:game_of_fortune/view/constants/app_styling.dart';
import 'package:game_of_fortune/view/widgets/common_image_view_widget.dart';
import 'package:game_of_fortune/view/widgets/my_text_widget.dart';
import 'package:game_of_fortune/view/widgets/simple_app_bar_widget.dart';

class Players extends StatelessWidget {
  const Players({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(haveBackButton: false, title: 'Players'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: AppSizes.DEFAULT,
              physics: const BouncingScrollPhysics(),
              children: [
                Container(
                  decoration: rounded2(kSecondaryColor, kSecondaryColor),
                  height: 158,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          profilecircle(51.0, 38.0, 9.1, 7.0),
                          profilecircle(65.0, 50.0, 10.1, 8.0),
                          profilecircle(51.0, 38.0, 9.1, 7.0),
                        ],
                      ),
                    ],
                  ),
                ),
                for (int i = 0; i < 8; i++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 9.0),
                    child: Container(
                      decoration: rounded(Colors.white),
                      child: Stack(
                        children: [
                          ListTile(
                            leading: CommonImageView(
                              url: dummyimg3,
                              fit: BoxFit.cover,
                              radius: 200,
                              width: 50,
                              height: 50,
                            ),
                            title: MyText(
                              text: 'Terrence Wilderman',
                              paddingBottom: 10,
                              weight: FontWeight.w500,
                            ),
                            subtitle: MyText(
                              text: '10 feb 2024',
                              color: kGrey8Color,
                            ),
                            trailing: MyText(
                              text: 'Highest Score',
                              paddingBottom: 24,
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 40,
                            child: MyText(
                              weight: FontWeight.bold,
                              text: '27',
                              size: 30,
                              color: kSecondaryColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget profilecircle(double height1, height2, margin, margin2) {
    return Stack(
      children: [
        Center(
          child: CommonImageView(
            imagePath: Assets.imagesProfile,
            fit: BoxFit.contain,
            height: height1,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: margin2, left: margin),
          child: Center(
            child: CommonImageView(
              url: dummyimg1,
              radius: 200,
              height: height2,
              width: height2,
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }
}
