import 'package:flutter/material.dart';
import 'package:game_of_fortune/controllers/auth/auth_controller.dart';
import 'package:game_of_fortune/core/constants/app_images/assets.dart';
import 'package:game_of_fortune/core/constants/instances_constants.dart';
import 'package:game_of_fortune/core/utils/file_pickers/image_picker.dart';
import 'package:game_of_fortune/view/widgets/common_image_view_widget.dart';
import 'package:game_of_fortune/view/widgets/my_text_widget.dart';
import 'package:game_of_fortune/view/widgets/simple_app_bar_widget.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MyAccount extends StatelessWidget {
  MyAccount({super.key});
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(title: 'My Account'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              physics: const BouncingScrollPhysics(),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => userModelGlobal.value.img != ''
                          ? CommonImageView(
                              url: userModelGlobal.value.img,
                              height: 95,
                              width: 95,
                              radius: 200,
                              fit: BoxFit.cover,
                            )
                          : CommonImageView(
                              imagePath: 'assets/images/placeholder.png',
                              height: 95,
                              width: 95,
                              radius: 200,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () {
                    ImagePickerService.instance.openProfilePickerBottomSheet(
                        context: context,
                        onCameraPick: () async {
                          XFile? file = await ImagePickerService.instance
                              .pickImageFromCamera();
                          Get.back();

                          if (file != null) {
                            await authController.updateProfilePicture(
                                file, context);
                          }
                        },
                        onGalleryPick: () async {
                          XFile? file = await ImagePickerService.instance
                              .pickSingleImageFromGallery();
                          Get.back();

                          if (file != null) {
                            await authController.updateProfilePicture(
                                file, context);
                          }
                        });
                  },
                  child: CommonImageView(
                    imagePath: Assets.imagesEdit,
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text: 'First Name',
                      weight: FontWeight.w600,
                    ),
                    Obx(
                      () => MyText(
                        text: userModelGlobal.value.fName!,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text: 'Last Name',
                      weight: FontWeight.w600,
                    ),
                    Obx(
                      () => MyText(
                        text: userModelGlobal.value.lName!,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                      text: 'Email',
                      weight: FontWeight.w600,
                    ),
                    Obx(
                      () => MyText(
                        text: userModelGlobal.value.email!,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
