import 'package:flutter/material.dart';
import 'package:game_of_fortune/controllers/game/game_controller.dart';
import 'package:game_of_fortune/core/constants/app_images/assets.dart';
import 'package:game_of_fortune/main.dart';
import 'package:game_of_fortune/core/constants/app_colors.dart';
import 'package:game_of_fortune/core/constants/app_sizes.dart';
import 'package:game_of_fortune/core/constants/app_styling.dart';
import 'package:game_of_fortune/view/widgets/common_image_view_widget.dart';
import 'package:game_of_fortune/view/widgets/my_text_widget.dart';
import 'package:game_of_fortune/view/widgets/simple_app_bar_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Players extends StatelessWidget {
  Players({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(haveBackButton: false, title: 'Players'),
      body: GetBuilder<GameController>(
          init: GameController(),
          builder: (gameController) {
            return gameController.players.isNotEmpty
                ? Container(
                    padding: AppSizes.DEFAULT,
                    width: Get.width,
                    height: Get.height,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          decoration:
                              rounded2(kSecondaryColor, kSecondaryColor),
                          height: 158,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              gameController.players.length >= 2
                                  ? Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        profilecircle(
                                          51.0,
                                          38.0,
                                          9.1,
                                          7.0,
                                          gameController.players[1].img,
                                        ),
                                        MyText(
                                          text:
                                              '${gameController.players[1].fName} ${gameController.players[1].lName}',
                                          color: Colors.white,
                                          maxLines: 2,
                                          textOverflow: TextOverflow.ellipsis,
                                          paddingTop: 2,
                                        )
                                      ],
                                    )
                                  : SizedBox.shrink(),
                              gameController.players.length >= 1
                                  ? Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        profilecircle(
                                          65.0,
                                          50.0,
                                          10.1,
                                          8.0,
                                          gameController.players.first.img,
                                        ),
                                        MyText(
                                          text:
                                              '${gameController.players.first.fName} ${gameController.players.first.lName}',
                                          color: Colors.white,
                                          maxLines: 2,
                                          textOverflow: TextOverflow.ellipsis,
                                          paddingTop: 2,
                                        )
                                      ],
                                    )
                                  : SizedBox.shrink(),
                              gameController.players.length >= 3
                                  ? Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        profilecircle(
                                          51.0,
                                          38.0,
                                          9.1,
                                          7.0,
                                          gameController.players[2].img,
                                        ),
                                        MyText(
                                          text:
                                              '${gameController.players[2].fName} ${gameController.players[2].lName}',
                                          color: Colors.white,
                                          maxLines: 2,
                                          textOverflow: TextOverflow.ellipsis,
                                          paddingTop: 2,
                                        )
                                      ],
                                    )
                                  : SizedBox.shrink()
                            ],
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: gameController.players.length,
                            itemBuilder: (c, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 9.0),
                                child: Container(
                                  decoration: rounded(Colors.white),
                                  child: Stack(
                                    children: [
                                      ListTile(
                                        leading: CommonImageView(
                                          url: gameController
                                                  .players[index].img ??
                                              dummyimg3,
                                          fit: BoxFit.cover,
                                          radius: 200,
                                          width: 50,
                                          height: 50,
                                        ),
                                        title: MyText(
                                          text:
                                              '${gameController.players[index].fName} ${gameController.players[index].lName}',
                                          paddingBottom: 10,
                                          weight: FontWeight.w500,
                                        ),
                                        subtitle: MyText(
                                          text:
                                              '${DateFormat('dd MMM yyyy').format(gameController.players[index].scoredDate!)}',
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
                                          text:
                                              '${gameController.players[index].highestScore}',
                                          size: 30,
                                          color: kSecondaryColor,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ],
                    ),
                  )
                : Center(
                    child: MyText(text: 'Be the first champion of this game'),
                  );
          }),
    );
  }

  Widget profilecircle(double height1, height2, margin, margin2, url) {
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
              url: url,
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
