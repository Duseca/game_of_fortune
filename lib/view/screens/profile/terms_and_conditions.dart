import 'package:flutter/material.dart';
import 'package:game_of_fortune/core/constants/app_colors.dart';
import 'package:game_of_fortune/core/constants/app_sizes.dart';
import 'package:game_of_fortune/services/firebase/firebase_authentication.dart';
import 'package:game_of_fortune/view/widgets/my_button_widget.dart';
import 'package:game_of_fortune/view/widgets/my_text_widget.dart';
import 'package:game_of_fortune/view/widgets/simple_app_bar_widget.dart';
import 'package:get/get.dart';

// List<Map<String, String>> dataList = [
//   {
//     'title': '1. Accepting of Terms and conditions:',
//     'subtitle':
//         '''Games Of Fortune is owned by the company Games Of Fortune, Ryttergrøftvejen
// 48, 7000 Fredericia, Denmark. CVR: 42569348. When you use Games Of Fortune
// and its facilities you accept the following terms and conditions, and agree that you
// consent to it''',
//   },
//   {
//     'title': '2. About Games Of Fortune and the prize pool',
//     'subtitle':
//         '''On Games Of Fortune you can play for free without any payment. By playing you can
// win the priz epool, if you are the first to make it all the way through the game. You
// can read more about the prize pool under “Prize pool”. You need to be the first to
// make it through to win.

// Everyone can participate in Games Of Fortune. If you are the lucky one to win the
// game, you will be contacted by the email used to sign in into the app. If the email is
// not answered within 30 days, then the right to the prize pool will be canceled. There
// can go up to 30 days, within the bank details have been delivered to us, before the
// money will get transferred to the winners account. By accepting the prize pool the
// winner furthermore accepts that we have the right to announce the winners
// username and game statistics in any given newsletter or social media, without any
// form for payment of this. Employees of Games Of Fortune cannot participate in the
// competition, but are allowed to use the app for testing purposes.

// Reservations are made for errors / technical problems in the prize pool.''',
//   },
//   {
//     'title': '3. Datapolitics:',
//     'subtitle':
//         '''The European Union's general data protection regulation (GDPR), demands that all
// organizations that collect sensitive personal information for those, who are living in
// the EU, are clearly asked about consent, before they collect this data. According to
// GDPR is personal information any information, that can be used to identify the
// person, who delivered the information.

// Games Of Fortune is surely keeping these rules at any time given the law about
// personal information. Personal information is defined by any information that can be
// led to a single person, for example Name, birthdate, address and so on. Fotos can
// also be qualified as personal data, if it is possible to identify the person. Crypted data
// is also qualified as personal data, as there is a possibility to decrypt it, and hereby
// identify the person.
// '''
//   },
//   {
//     'title': '4. Cookies:',
//     'subtitle':
//         '''We use cookies to store certain types of information on our app. Cookie gives our system
// the possibility to give you the best experience on our app.'''
//   },
//   {
//     'title': '5. Ip-address:',
//     'subtitle':
//         '''When using Games Of Fortune, the used IP-address is registered. Your IP-address is
// registered on the device and internet connection you use on our app. The purpose of the
// IP-address registration is that we always can find the used device, if there should be an
// abuse of our terms and conditions on Games Of Fortune.
// '''
//   },
//   {
//     'title': '6. Data responsible:',
//     'subtitle':
//         '''Games Of Fortune is responsible for the information that is connected to you on Games Of
// Fortune. We can be contacted on Contact@gamesoffortune.net if there are any questions.
// '''
//   },
//   {
//     'title': '7. Updates:',
//     'subtitle':
//         'Terms may undergo updates; it is your responsibility to stay informed'
//   },

// Add more items as needed
// ];

// class TermsConditions extends StatelessWidget {
//   const TermsConditions({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: simpleAppBar(title: 'Terms and Conditions'),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Expanded(
//             child: ListView(
//               shrinkWrap: true,
//               padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//               physics: const BouncingScrollPhysics(),
//               children: [
//                 MyText(
//                   text: 'Games of Fortune Terms & Conditions',
//                   size: 18,
//                   paddingBottom: 10,
//                   weight: FontWeight.w600,
//                 ),
//                 for (int i = 0; i < dataList.length; i++)
//                   Column(
//                     children: [
//                       Row(
//                         children: [
//                           MyText(
//                             text: dataList[i]['title'] ?? '',
//                             size: 15,
//                             color: kGrey8Color,
//                             paddingBottom: 5,
//                           ),
//                         ],
//                       ),
//                       MyText(
//                           color: kGrey5Color,
//                           lineHeight: 1.5,
//                           paddingBottom: 25,
//                           text: dataList[i]['subtitle'] ?? ''),
//                     ],
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
