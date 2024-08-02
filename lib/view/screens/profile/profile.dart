import 'package:flutter/material.dart';
import 'package:game_of_fortune/controllers/auth/auth_controller.dart';
import 'package:game_of_fortune/core/constants/app_images/assets.dart';
import 'package:game_of_fortune/core/constants/instances_constants.dart';
import 'package:game_of_fortune/core/constants/app_colors.dart';
import 'package:game_of_fortune/core/constants/app_sizes.dart';
import 'package:game_of_fortune/core/constants/app_styling.dart';
import 'package:game_of_fortune/view/screens/profile/my_account.dart';
import 'package:game_of_fortune/view/screens/profile/terms_and_conditions.dart';
import 'package:game_of_fortune/view/widgets/common_image_view_widget.dart';
import 'package:game_of_fortune/view/widgets/my_text_widget.dart';
import 'package:game_of_fortune/view/widgets/simple_app_bar_widget.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  Profile({super.key});
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(haveBackButton: false, title: 'Profile'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: AppSizes.DEFAULT,
              physics: const BouncingScrollPhysics(),
              children: [
                Stack(
                  children: [
                    Center(
                      child: Obx(
                        () => userModelGlobal.value.img != ''
                            ? CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.transparent,
                                child: CommonImageView(
                                  url: userModelGlobal.value.img,
                                  fit: BoxFit.cover,
                                  width: Get.width,
                                  radius: 70,
                                ),
                              )
                            : CommonImageView(
                                imagePath: Assets.imagesProfile,
                                fit: BoxFit.contain,
                                height: 113,
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 11.0),
                      child: Center(
                        child: CommonImageView(
                          radius: 200,
                          height: 90,
                          width: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: kSecondaryColor,
                            blurRadius: 80,
                            offset: Offset(0, 25),
                            spreadRadius: 10)
                      ]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(
                            () => MyText(
                              textAlign: TextAlign.center,
                              paddingTop: 20,
                              text:
                                  '${userModelGlobal.value.fName} ${userModelGlobal.value.lName}',
                              size: 26,
                              weight: FontWeight.w500,
                            ),
                          ),
                          MyText(
                            textAlign: TextAlign.center,
                            text: auth.currentUser!.email!,
                            weight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                profiletile(() {
                  Get.to(() => MyAccount());
                }, 'My Account'),
                // profiletile(() {
                //   Get.to(() => Settings());
                // }, 'Settings'),
                profiletile(() {
                  Get.to(() => TermsConditions());
                }, 'Terms and Conditions'),
                profiletile(() {
                  Get.dialog(Logout());
                }, 'Log Out'),
                profiletile(() async {
                  await authController.deleteUserAccount();
                }, 'Delete Account'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget profiletile(VoidCallback ontap, String title) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          decoration: btndeco(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: MyText(text: title)),
                CommonImageView(
                  imagePath: Assets.imagesNext,
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
