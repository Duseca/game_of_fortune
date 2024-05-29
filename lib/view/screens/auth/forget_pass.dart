import 'package:flutter/material.dart';
import 'package:game_of_fortune/controllers/auth/auth_controller.dart';
import 'package:game_of_fortune/core/constants/app_images/assets.dart';
import 'package:game_of_fortune/core/constants/app_sizes.dart';
import 'package:game_of_fortune/core/utils/validators.dart';
import 'package:game_of_fortune/view/widgets/common_image_view_widget.dart';
import 'package:game_of_fortune/view/widgets/my_button_widget.dart';
import 'package:game_of_fortune/view/widgets/my_text_field_widget.dart';
import 'package:game_of_fortune/view/widgets/my_text_widget.dart';
import 'package:game_of_fortune/view/widgets/simple_app_bar_widget.dart';
import 'package:get/get.dart';

class ForgetPasswords extends StatelessWidget {
  ForgetPasswords({super.key});
  final authController = Get.find<AuthController>();
  final _resetKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: closeAppBar(title: 'Forget Password'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Form(
              key: _resetKey,
              child: ListView(
                shrinkWrap: true,
                padding: AppSizes.DEFAULT,
                physics: const BouncingScrollPhysics(),
                children: [
                  MyText(
                      lineHeight: 1.8,
                      paddingBottom: 30,
                      text:
                          'Please Enter your registered Email so that we can verify and help you reset your password'),
                  MyTextField(
                    label: 'Email',
                    suffix: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: CommonImageView(
                        imagePath: Assets.imagesMail,
                        height: 10,
                      ),
                    ),
                    hint: 'Enter your Email',
                    controller: authController.email,
                    validator: (value) {
                      return ValidationService.instance.emailValidator(value);
                    },
                    marginBottom: 70,
                  ),
                  MyButton(
                      onTap: () async {
                        if (_resetKey.currentState!.validate()) {
                          await authController.resetPassword();
                        }
                      },
                      buttonText: 'Reset Password')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
