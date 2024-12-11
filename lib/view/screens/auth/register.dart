import 'package:flutter/material.dart';
import 'package:game_of_fortune/controllers/auth/auth_controller.dart';
import 'package:game_of_fortune/core/constants/app_images/assets.dart';
import 'package:game_of_fortune/core/constants/app_colors.dart';
import 'package:game_of_fortune/core/constants/app_sizes.dart';
import 'package:game_of_fortune/core/constants/app_styling.dart';
import 'package:game_of_fortune/core/utils/snackbars.dart';
import 'package:game_of_fortune/core/utils/validators.dart';
import 'package:game_of_fortune/view/screens/auth/login.dart';
import 'package:game_of_fortune/view/widgets/common_image_view_widget.dart';
import 'package:game_of_fortune/view/widgets/custom_check_box.dart';
import 'package:game_of_fortune/view/widgets/my_button_widget.dart';
import 'package:game_of_fortune/view/widgets/my_text_field_widget.dart';
import 'package:game_of_fortune/view/widgets/my_text_widget.dart';
import 'package:game_of_fortune/view/widgets/simple_app_bar_widget.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:get/get.dart';

class Register extends StatelessWidget {
  Register({super.key});
  final authController = Get.find<AuthController>();
  final _signupForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: closeAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Form(
              key: _signupForm,
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
                      label: 'Username',
                      suffix: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CommonImageView(
                          imagePath: Assets.imagesUser,
                          height: 10,
                        ),
                      ),
                      hint: 'Enter username',
                      controller: authController.username,
                      validator: (value) {
                        return ValidationService.instance
                            .userNameValidator(value);
                      }),
                  MyTextField(
                      label: 'First Name',
                      suffix: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CommonImageView(
                          imagePath: Assets.imagesUser,
                          height: 10,
                        ),
                      ),
                      hint: 'Enter first name',
                      controller: authController.fName,
                      validator: (value) {
                        return ValidationService.instance.emptyValidator(value);
                      }),
                  MyTextField(
                      label: 'Last Name',
                      suffix: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CommonImageView(
                          imagePath: Assets.imagesUser,
                          height: 10,
                        ),
                      ),
                      hint: 'Enter last name',
                      controller: authController.lName,
                      validator: (value) {
                        return ValidationService.instance.emptyValidator(value);
                      }),
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
                  MyText(
                    text: 'Country',
                    weight: FontWeight.w600,
                    paddingBottom: 5,
                  ),
                  MyTextField(
                      prefix: CountryCodePicker(
                        hideMainText: true,
                        initialSelection: 'IT',
                        alignLeft: true,
                        padding: EdgeInsets.all(0),
                        flagDecoration:
                            rounded2r(kPrimaryColor, kPrimaryColor, 9),
                        onChanged: (code) {
                          authController.isoCode.value = code.dialCode!;
                        },
                      ),
                      hint: 'Enter phone number',
                      controller: authController.phoneNum,
                      keyBoardType: TextInputType.number,
                      validator: (value) {
                        return ValidationService.instance.emptyValidator(value);
                      }),
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
                      controller: authController.password,
                      validator: (value) {
                        return ValidationService.instance.emptyValidator(value);
                      }),
                  MyTextField(
                      label: 'Confirm Password',
                      suffix: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: CommonImageView(
                          imagePath: Assets.imagesKey,
                          height: 10,
                        ),
                      ),
                      hint: 'Repeat your Password',
                      controller: authController.confirmPass,
                      validator: (value) {
                        if (value!.isNotEmpty &&
                            value != authController.password.text) {
                          return 'Passwords not same!';
                        }
                        return ValidationService.instance.emptyValidator(value);
                      }),
                  Row(
                    children: [
                      Obx(
                        () => CustomCheckBox(
                            isActive: authController.acceptTerms.value,
                            onTap: () {
                              authController.acceptTerms.value =
                                  !authController.acceptTerms.value;
                            }),
                      ),
                      MyText(text: ' I accept the '),
                      MyText(
                        text: 'Terms and Condition ',
                        weight: FontWeight.bold,
                        color: kSecondaryColor,
                      ),
                      // MyText(text: 'of Game of Fortune '),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MyButton(
                      onTap: () async {
                        if (_signupForm.currentState!.validate()) {
                          if (authController.acceptTerms.isTrue) {
                            await authController.createPlayer(context);
                          } else {
                            CustomSnackBars.instance.showFailureSnackbar(
                                title: 'Attention',
                                message:
                                    'Please agree to the terms and conditions to continue.');
                          }
                        }
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
          ),
        ],
      ),
    );
  }
}
