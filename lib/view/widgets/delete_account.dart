import 'package:flutter/material.dart';
import 'package:game_of_fortune/controllers/auth/auth_controller.dart';
import 'package:get/get.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';
import '../../services/firebase/firebase_authentication.dart';
import 'my_button_widget.dart';
import 'my_text_widget.dart';

class DeleteAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: const Color.fromRGBO(0, 0, 0, 0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                  margin: AppSizes.DEFAULT,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: kPrimaryColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 26,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MyText(
                        text: 'Are you sure you want to delete your account?',
                        paddingLeft: 30,
                        paddingRight: 30,
                        paddingTop: 20,
                        paddingBottom: 20,
                        textAlign: TextAlign.center,
                        size: 18,
                        weight: FontWeight.w600,
                      ),
                      Padding(
                        padding: AppSizes.DEFAULT,
                        child: Row(
                          children: [
                            Expanded(
                              child: MyButton(
                                onTap: () {
                                  Get.back();
                                },
                                backgroundColor: kGrey4Color,
                                buttonText: 'No',
                                radius: 50,
                                outlineColor: kGrey4Color,
                                hasshadow: true,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: MyButton(
                                onTap: () async {
                                  Get.back();
                                  await Get.find<AuthController>()
                                      .deleteUserAccount(context);
                                },
                                backgroundColor: kRedColor,
                                buttonText: "Yes, I'm sure",
                                radius: 50,
                                outlineColor: kRedColor,
                                hasshadow: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              )
            ]));
  }
}
