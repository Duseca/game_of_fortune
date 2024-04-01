import 'package:flutter/material.dart';
import 'package:game_of_fortune/constants/app_images/assets.dart';
import 'package:game_of_fortune/view/constants/app_strings.dart';
import 'package:game_of_fortune/view/widgets/common_image_view_widget.dart';
import 'package:game_of_fortune/view/widgets/my_button_widget.dart';
import 'package:game_of_fortune/view/widgets/my_text_field_widget.dart';
import 'package:game_of_fortune/view/widgets/my_text_widget.dart';
import 'package:game_of_fortune/view/widgets/simple_app_bar_widget.dart';

class CreateNewPass extends StatelessWidget {
  const CreateNewPass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: closeAppBar(title: 'Create Password'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
              physics: const BouncingScrollPhysics(),
              children: [
                MyTextField(
                  hint: 'Enter your New Password',
                  label: 'Password',
                  suffix: Padding(
                    padding: const EdgeInsets.all(12),
                    child: CommonImageView(
                      imagePath: Assets.imagesKey,
                      height: 10,
                      width: 10,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                MyTextField(
                  label: 'Repeat your Password',
                  suffix: Padding(
                    padding: const EdgeInsets.all(12),
                    child: CommonImageView(
                      imagePath: Assets.imagesKey,
                      height: 10,
                      width: 10,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                MyText(text: change1),
                MyText(text: change2),
                MyText(text: change3),
                MyText(text: change4),
                MyText(
                  text: change5,
                  paddingBottom: 80,
                ),
                MyButton(
                    buttonText: 'Reset Password',
                    onTap: () {
                      //   Get.to(() => const PasswordReset());
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
