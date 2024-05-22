import 'package:flutter/material.dart';
import 'package:game_of_fortune/core/constants/app_colors.dart';
import 'package:game_of_fortune/core/constants/app_sizes.dart';
import 'package:game_of_fortune/services/firebase/firebase_authentication.dart';
import 'package:game_of_fortune/view/screens/auth/login.dart';
import 'package:game_of_fortune/view/widgets/my_button_widget.dart';
import 'package:game_of_fortune/view/widgets/my_text_widget.dart';
import 'package:game_of_fortune/view/widgets/simple_app_bar_widget.dart';
import 'package:get/get.dart';

List<Map<String, String>> dataList = [
  {
    'title': '1. Acceptance of Terms:',
    'subtitle':
        'By using the Games of Fortune App, you agree to comply with these terms and conditions',
  },
  {
    'title': '2. User Responsibilities:',
    'subtitle':
        'You are responsible for the data you input. Adhere to the guidelines and ensure your contributions are lawful and respectful.',
  },
  {
    'title': '3. Privacy:',
    'subtitle':
        'We prioritize your privacy. Review our Privacy Policy to understand how we collect, use, and safeguard your personal information.'
  },
  {
    'title': '4. Intellectual Property:',
    'subtitle':
        'Respect intellectual property rights. Do not infringe on copyrights or trademarks when utilizing the app.'
  },
  {
    'title': '5. Prohibited Activities:',
    'subtitle':
        ' Engaging in harmful activities, spam, or any form of abuse is strictly prohibited. Contribute positively to our data community.'
  },
  {
    'title': '6. Termination:',
    'subtitle':
        'We retain the right to terminate accounts violating our terms without prior notice.'
  },
  {
    'title': '7. Updates:',
    'subtitle':
        'Terms may undergo updates; it is your responsibility to stay informed'
  },

  // Add more items as needed
];

class TermsConditions extends StatelessWidget {
  const TermsConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(title: 'Terms and Conditions'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              physics: const BouncingScrollPhysics(),
              children: [
                MyText(
                  text: 'Games of Fortune Terms & Conditions',
                  size: 18,
                  paddingBottom: 10,
                  weight: FontWeight.w600,
                ),
                for (int i = 0; i < dataList.length; i++)
                  Column(
                    children: [
                      Row(
                        children: [
                          MyText(
                            text: dataList[i]['title'] ?? '',
                            size: 15,
                            color: kGrey8Color,
                            paddingBottom: 5,
                          ),
                        ],
                      ),
                      MyText(
                          color: kGrey5Color,
                          lineHeight: 1.5,
                          paddingBottom: 25,
                          text: dataList[i]['subtitle'] ?? ''),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
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
