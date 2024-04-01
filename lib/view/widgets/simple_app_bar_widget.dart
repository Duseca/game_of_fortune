import 'package:flutter/material.dart';
import 'package:game_of_fortune/constants/app_images/assets.dart';
import 'package:game_of_fortune/view/constants/app_colors.dart';
import 'package:game_of_fortune/view/widgets/my_text_widget.dart';
import 'package:get/get.dart';

AppBar simpleAppBar({
  String? title,
  VoidCallback? onBackIconTap,
  Color? bgColor,
  Color? contentColor,
  bool? haveBackButton = true,
  List<Widget>? actions,
}) {
  return AppBar(
    backgroundColor: bgColor ?? kPrimaryColor,
    centerTitle: true,
    leading: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (haveBackButton!)
          GestureDetector(
            onTap: onBackIconTap ?? () => Get.back(),
            child: Image.asset(
              Assets.imagesBack,
              height: 30,
              color: contentColor ?? kTertiaryColor,
            ),
          ),
      ],
    ),
    title: MyText(
      text: title ?? '',
      size: 20,
      weight: FontWeight.w600,
      color: contentColor ?? kTertiaryColor,
    ),
    actions: actions,
  );
}

AppBar closeAppBar({
  String? title,
  VoidCallback? onBackIconTap,
  Color? bgColor,
  Color? contentColor,
  bool? haveBackButton = true,
  List<Widget>? actions,
}) {
  return AppBar(
    backgroundColor: bgColor ?? kPrimaryColor,
    centerTitle: true,
    leading: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (haveBackButton!)
          GestureDetector(
            onTap: onBackIconTap ?? () => Get.back(),
            child: Image.asset(
              Assets.imagesClose,
              height: 30,
            ),
          ),
      ],
    ),
    title: MyText(
      text: title ?? '',
      size: 20,
      weight: FontWeight.w600,
      color: contentColor ?? kTertiaryColor,
    ),
    actions: actions,
  );
}
