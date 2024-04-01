import 'package:flutter/material.dart';
import 'package:game_of_fortune/constants/app_images/assets.dart';
import 'package:game_of_fortune/view/constants/app_colors.dart';
import 'package:game_of_fortune/view/constants/app_sizes.dart';
import 'package:game_of_fortune/view/widgets/my_button_widget.dart';
import 'package:game_of_fortune/view/widgets/my_text_widget.dart';
import 'package:game_of_fortune/view/widgets/simple_app_bar_widget.dart';
import 'package:get/get.dart';

class OTPVerification extends StatelessWidget {
  const OTPVerification({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: closeAppBar(title: 'Verify Account'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: AppSizes.DEFAULT,
              physics: const BouncingScrollPhysics(),
              children: [
                MyText(
                    lineHeight: 1.7,
                    paddingBottom: 40,
                    text:
                        'Please enter the verification code we sent to your email address. The code you received will expire in 10 minutes.'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(5, (index) {
                    return SizedBox(
                      width: 40,
                      height: 48,
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          enabled: true,
                          focusColor: Color.fromARGB(255, 255, 255, 255),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: kGrey2Color, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: kSecondaryColor, width: 2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        //maxLength: 1,
                      ),
                    );
                  }),
                ),
                SizedBox(
                  height: 150,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      text: 'Didn’t receive code? ',
                      weight: FontWeight.w500,
                    ),
                    MyText(
                      text: 'Resend code',
                      weight: FontWeight.w500,
                      color: kSecondaryColor,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                MyButton(
                    onTap: () {
                      Get.dialog(_NoBudgetAddedDialog());
                    },
                    buttonText: 'Confirm')
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NoBudgetAddedDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(28),
            margin: AppSizes.DEFAULT,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kPrimaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Image.asset(
                    Assets.imagesTick,
                    height: 114,
                  ),
                ),
                SizedBox(
                  height: 26,
                ),
                MyText(
                  text: 'Account Created Successfully',
                  size: 20,
                  weight: FontWeight.w600,
                  textAlign: TextAlign.center,
                  paddingBottom: 10,
                ),
                MyText(
                  text:
                      'Your account has been created successfully. Now you can Get Started',
                  size: 14,
                  textAlign: TextAlign.center,
                  paddingBottom: 28,
                ),
                MyButton(onTap: () {}, buttonText: 'Get Started')
              ],
            ),
          ),
        ],
      ),
    );
  }
}
