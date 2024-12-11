import 'package:flutter/material.dart';
import 'package:game_of_fortune/controllers/auth/auth_controller.dart';
import 'package:game_of_fortune/core/constants/app_images/assets.dart';
import 'package:game_of_fortune/core/constants/app_colors.dart';
import 'package:game_of_fortune/core/constants/app_sizes.dart';
import 'package:game_of_fortune/core/utils/validators.dart';
import 'package:game_of_fortune/view/screens/auth/forget_pass.dart';
import 'package:game_of_fortune/view/screens/auth/register.dart';
import 'package:game_of_fortune/view/widgets/common_image_view_widget.dart';
import 'package:game_of_fortune/view/widgets/my_button_widget.dart';
import 'package:game_of_fortune/view/widgets/my_text_field_widget.dart';
import 'package:game_of_fortune/view/widgets/my_text_widget.dart';
import 'package:game_of_fortune/view/widgets/simple_app_bar_widget.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: closeAppBar(),
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
                  text: 'Login',
                  weight: FontWeight.w500,
                  paddingBottom: 5,
                  size: 22,
                ),
                MyText(
                  text: 'Please enter your email and password to Sign In',
                  size: 16,
                  paddingBottom: 40,
                ),
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
                    }),
                MyTextField(
                    label: 'Password',
                    isObSecure: true,
                    suffix: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: CommonImageView(
                        imagePath: Assets.imagesKey,
                        height: 10,
                      ),
                    ),
                    hint: 'Enter your New Password',
                    controller: authController.password,
                    validator: (value) {
                      return ValidationService.instance.emptyValidator(value);
                    }),
                MyText(
                  text: 'Forget Password?',
                  color: kSecondaryColor,
                  textAlign: TextAlign.end,
                  onTap: () {
                    Get.to(() => ForgetPasswords());
                  },
                  paddingBottom: 30,
                ),
                MyButton(
                    onTap: () async {
                      await authController.authenticateUser(context);
                    },
                    buttonText: 'Login'),
                MyText(
                  text: 'Create Account',
                  weight: FontWeight.w600,
                  size: 18,
                  textAlign: TextAlign.center,
                  paddingTop: 20,
                  onTap: () {
                    Get.to(() => Register());
                  },
                  color: kSecondaryColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
