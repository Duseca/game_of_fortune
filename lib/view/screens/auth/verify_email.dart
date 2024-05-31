import 'package:flutter/material.dart';
import 'package:game_of_fortune/core/constants/app_images/assets.dart';
import 'package:game_of_fortune/view/widgets/my_text_widget.dart';
import 'package:game_of_fortune/view/widgets/simple_app_bar_widget.dart';
import 'package:get/get.dart';

class VerifyEmail extends StatelessWidget {
  const VerifyEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: closeAppBar(title: 'Verify Account'),
      body: SizedBox(
        width: Get.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              Assets.imagesTick,
              height: 114,
            ),
            SizedBox(
              height: 20,
            ),
            MyText(
                textAlign: TextAlign.center,
                lineHeight: 1.7,
                paddingBottom: 40,
                text:
                    'Email verification link has been sent on your email address. \nPlease check the spam folder if not found in the inbox:)'),
          ],
        ),
      ),
    );
  }
}
