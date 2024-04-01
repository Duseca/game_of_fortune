import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:game_of_fortune/constants/app_images/assets.dart';
import 'package:game_of_fortune/view/constants/app_colors.dart';
import 'package:game_of_fortune/view/constants/app_sizes.dart';
import 'package:game_of_fortune/view/constants/app_styling.dart';
import 'package:game_of_fortune/view/screens/auth/login.dart';
import 'package:game_of_fortune/view/screens/auth/otp_verification.dart';
import 'package:game_of_fortune/view/widgets/common_image_view_widget.dart';
import 'package:game_of_fortune/view/widgets/custom_check_box.dart';
import 'package:game_of_fortune/view/widgets/my_button_widget.dart';
import 'package:game_of_fortune/view/widgets/my_text_field_widget.dart';
import 'package:game_of_fortune/view/widgets/my_text_widget.dart';
import 'package:game_of_fortune/view/widgets/simple_app_bar_widget.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:get/get.dart';

class Register extends StatelessWidget {
  const Register({super.key});

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
                  text: 'Register',
                  weight: FontWeight.w500,
                  paddingBottom: 5,
                  size: 22,
                ),
                MyText(
                  text: 'Please enter your details to Register yourself',
                  size: 16,
                  paddingBottom: 40,
                ),
                MyTextField(
                  label: 'First Name',
                  suffix: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: CommonImageView(
                      imagePath: Assets.imagesUser,
                      height: 10,
                    ),
                  ),
                  hint: 'Enter username',
                ),
                MyTextField(
                  label: 'Last Name',
                  suffix: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: CommonImageView(
                      imagePath: Assets.imagesUser,
                      height: 10,
                    ),
                  ),
                  hint: 'Enter username',
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
                ),
                MyText(
                  text: 'Country',
                  weight: FontWeight.w600,
                  paddingBottom: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: rounded2(kSecondaryColor2, kGrey2Color),
                        child: CountryCodePicker(
                          showOnlyCountryWhenClosed: true,
                          initialSelection: 'IT',
                          showDropDownButton: true,
                          alignLeft: true,
                          padding: EdgeInsets.zero,
                          flagDecoration:
                              rounded2r(kPrimaryColor, kPrimaryColor, 9),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                MyTextField(
                  label: 'Password',
                  suffix: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: CommonImageView(
                      imagePath: Assets.imagesKey,
                      height: 10,
                    ),
                  ),
                  hint: 'Enter your New Password',
                ),
                MyTextField(
                  label: 'Password',
                  suffix: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: CommonImageView(
                      imagePath: Assets.imagesKey,
                      height: 10,
                    ),
                  ),
                  hint: 'Repeat your Password',
                ),
                Row(
                  children: [
                    CustomCheckBox(isActive: false, onTap: () {}),
                    MyText(text: ' I accept the '),
                    MyText(
                      text: 'Terms and Condition ',
                      weight: FontWeight.bold,
                      color: kSecondaryColor,
                    ),
                    MyText(text: 'of Game of Fortune '),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                MyButton(
                    onTap: () {
                      Get.to(() => OTPVerification());
                    },
                    buttonText: 'Create Account'),
                MyText(
                  text: 'Login',
                  weight: FontWeight.w600,
                  size: 18,
                  textAlign: TextAlign.center,
                  paddingTop: 20,
                  onTap: () {
                    Get.to(() => Login());
                  },
                  color: kSecondaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
