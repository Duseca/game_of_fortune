import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';

class CustomSnackBars {
  // Private constructor
  CustomSnackBars._privateConstructor();

  // Singleton instance variable
  static CustomSnackBars? _instance;

  //This code ensures that the singleton instance is created only when it's accessed for the first time.
  //Subsequent calls to CustomSnackBars.instance will return the same instance that was created before.

  // Getter to access the singleton instance
  static CustomSnackBars get instance {
    _instance ??= CustomSnackBars._privateConstructor();
    return _instance!;
  }

  //method to show success snackbar
  void showSuccessSnackbar(
      {required String title, required String message, int duration = 3}) {
    Get.snackbar(title, message,
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.symmetric(
            horizontal: 24.00 * 0.5, vertical: 24.00 * 0.5),
        backgroundColor: Colors.black,
        colorText: Colors.white,
        leftBarIndicatorColor: Colors.green,
        progressIndicatorBackgroundColor: Colors.red,
        isDismissible: true,
        animationDuration: const Duration(microseconds: 800),
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 5.0,
        mainButton: TextButton(
            onPressed: () => Get.back(), child: const Text('Dismiss')),
        // boxShadows: BoxShadow()
        icon: const Icon(Icons.check_circle_rounded, color: Colors.green));
  }

  //method to show failure snackbar
  void showFailureSnackbar(
      {required String title, required String message, int duration = 3}) {
    Get.snackbar(title, message,
        duration: Duration(seconds: duration),
        margin: const EdgeInsets.symmetric(
            horizontal: 24.00 * 0.5, vertical: 24.00 * 0.5),
        backgroundColor: Colors.black,
        colorText: Colors.white,
        leftBarIndicatorColor: Colors.red,
        progressIndicatorBackgroundColor: Colors.red,
        isDismissible: true,
        animationDuration: const Duration(microseconds: 800),
        snackPosition: SnackPosition.BOTTOM,
        borderRadius: 5.0,
        mainButton: TextButton(
            onPressed: () => Get.back(), child: const Text('Dismiss')),
        // boxShadows: BoxShadow()
        icon: const Icon(Icons.warning, color: Colors.red));
  }

  void showToast({required String message}) {
    Fluttertoast.showToast(
      msg: message,
      fontSize: 14,
      backgroundColor: kSecondaryColor,
      textColor: kPrimaryColor,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}
