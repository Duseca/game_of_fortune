import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:game_of_fortune/core/constants/app_colors.dart';
import 'package:game_of_fortune/core/constants/app_sizes.dart';
import 'package:game_of_fortune/core/constants/instances_constants.dart';
import 'package:game_of_fortune/services/firebase/firebase_authentication.dart';
import 'package:game_of_fortune/view/widgets/my_button_widget.dart';
import 'package:game_of_fortune/view/widgets/my_text_widget.dart';
import 'package:game_of_fortune/view/widgets/simple_app_bar_widget.dart';
import 'package:get/get.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: simpleAppBar(title: 'Terms and Conditions'),
        body: ListView(
          shrinkWrap: true,
          children: [
            Obx(() => Html(
                  data: termsCond.value,
                )),
          ],
        ));
  }
}

class Logout extends StatelessWidget {
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
                        text:
                            'Are you sure you want to Logout from your account?',
                        paddingLeft: 30,
                        paddingRight: 30,
                        paddingTop: 20,
                        paddingBottom: 20,
                        textAlign: TextAlign.center,
                        size: 18,
                        weight: FontWeight.w600,
                      ),
                      MyText(
                        text: 'You can login any time',
                        textAlign: TextAlign.center,
                        paddingLeft: 20,
                        paddingRight: 20,
                        paddingBottom: 20,
                        color: kGrey5Color,
                      ),
                      Padding(
                        padding: AppSizes.DEFAULT,
                        child: Row(
                          children: [
                            Expanded(
                              child: MyButton(
                                onTap: () {
                                  Get.back();
                                  //  Get.to(() => Reciept());
                                },
                                backgroundColor: kGrey4Color,
                                buttonText: 'Cancel',
                                radius: 50,
                                outlineColor: kGrey4Color,
                                hasshadow: true,
                              ),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              child: MyButton(
                                onTap: () async {
                                  await FirebaseAuthService.instance.logOut();
                                },
                                backgroundColor: kRedColor,
                                buttonText: 'Logout',
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
