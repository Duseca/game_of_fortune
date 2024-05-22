import 'dart:async';
import 'package:flutter/material.dart';
import 'package:game_of_fortune/core/bindings/bindings.dart';
import 'package:game_of_fortune/core/common/functions.dart';
import 'package:game_of_fortune/core/constants/app_images/assets.dart';
import 'package:game_of_fortune/core/constants/instances_constants.dart';
import 'package:game_of_fortune/core/utils/snackbars.dart';
import 'package:game_of_fortune/view/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:game_of_fortune/view/widgets/my_text_widget.dart';
import 'package:game_of_fortune/view/widgets/simple_app_bar_widget.dart';
import 'package:get/get.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  Timer timer = Timer(Duration(), () {});
  @override
  void initState() {
    auth.currentUser!.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkStatus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: closeAppBar(title: 'Verify Account'),
      body: SizedBox(
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.imagesTick,
              height: 114,
            ),
            SizedBox(
              height: 20,
            ),
            MyText(
                lineHeight: 1.7,
                paddingBottom: 40,
                text:
                    'Please click the account verification link we sent on your email address. If not found in inbox, check your spam folder as well.'),

            SizedBox(
              height: 20,
            ),
            // MyButton(
            //     onTap: () {
            //       Get.dialog(_NoBudgetAddedDialog());
            //     },
            //     buttonText: 'Confirm')
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> checkStatus() async {
    await auth.currentUser?.reload();
    if (auth.currentUser!.emailVerified) {
      timer.cancel();
      await getUserDataStream(userId: auth.currentUser!.uid);

      Get.offAll(BottomNavBar(), binding: BottomBarBindings());
      CustomSnackBars.instance.showSuccessSnackbar(
          title: 'Congratulations!',
          message: 'Your player profile has been created successfully.');
    }
  }
}

// class _NoBudgetAddedDialog extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             padding: EdgeInsets.all(28),
//             margin: AppSizes.DEFAULT,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               color: kPrimaryColor,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Center(
                  // child: Image.asset(
                  //   Assets.imagesTick,
                  //   height: 114,
                  // ),
//                 ),
//                 SizedBox(
//                   height: 26,
//                 ),
//                 MyText(
//                   text: 'Account Created Successfully',
//                   size: 20,
//                   weight: FontWeight.w600,
//                   textAlign: TextAlign.center,
//                   paddingBottom: 10,
//                 ),
//                 MyText(
//                   text:
//                       'Your account has been created successfully.Now you can Get Started',
//                   size: 14,
//                   textAlign: TextAlign.center,
//                   paddingBottom: 28,
//                 ),
//                 MyButton(onTap: () {Get.offAll(BottomNavBar())}, buttonText: 'Get Started')
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
