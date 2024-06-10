import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_of_fortune/core/bindings/bindings.dart';
import 'package:game_of_fortune/core/common/functions.dart';
import 'package:game_of_fortune/core/constants/firebase_collection_references.dart';
import 'package:game_of_fortune/core/constants/instances_constants.dart';
import 'package:game_of_fortune/core/enums/network_status.dart';
import 'package:game_of_fortune/core/utils/dialogs.dart';
import 'package:game_of_fortune/core/utils/network_connectivity.dart';
import 'package:game_of_fortune/core/utils/snackbars.dart';
import 'package:game_of_fortune/models/player_model.dart';
import 'package:game_of_fortune/services/firebase/firebase_authentication.dart';
import 'package:game_of_fortune/services/firebase/firebase_crud.dart';
import 'package:game_of_fortune/services/firebase/firebase_storage.dart';
import 'package:game_of_fortune/view/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../view/screens/auth/email_verification.dart';

class AuthController extends GetxController {
  final email = TextEditingController(),
      password = TextEditingController(),
      confirmPass = TextEditingController(),
      phoneNum = TextEditingController(),
      fName = TextEditingController(),
      lName = TextEditingController();

  var isoCode = '+1'.obs, acceptTerms = false.obs, profilePicture = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  //create player
  createPlayer(BuildContext context) async {
    User? user = await FirebaseAuthService.instance.signUpUsingEmailAndPassword(
        email: email.text.trim(), password: password.text.trim());
    if (user != null) {
      try {
        DialogService.instance.showProgressDialog(context: context);
        PlayerModel newPlayer = PlayerModel(
          playerId: user.uid,
          fName: fName.text.trim(),
          lName: lName.text.trim(),
          email: user.email,
          phoneNum: phoneNum.text.trim(),
          iso: isoCode.value,
          lives: 0,
        );

        bool isCreated = await FirebaseCRUDService.instance.createDocument(
            collectionReference: playersCollection,
            docId: newPlayer.playerId!,
            data: newPlayer.toMap());
        DialogService.instance.hideLoading();
        if (isCreated) {
          Get.to(() => EmailVerification());
        }
      } catch (e) {
        DialogService.instance.hideLoading();
        print('Exception::createPlayer(): $e');
      }
    }
  }

  //login user
  authenticateUser(BuildContext context) async {
    try {
      User? user = await FirebaseAuthService.instance
          .signInUsingEmailAndPassword(
              email: email.text.trim(),
              password: password.text.trim(),
              context: context);
      if (user != null) {
        if (user.emailVerified == true) {
          await getUserDataStream(userId: user.uid);
          //navigate user accordingly
          Get.offAll(BottomNavBar(), binding: BottomBarBindings());
        } else {
          await auth.currentUser!.sendEmailVerification();
          CustomSnackBars.instance.showFailureSnackbar(
              title: 'Attention',
              message:
                  'Emeail verification link sent. Please verify your email before proceeding further');
        }
      }
      // ignore: unused_catch_clause
    } catch (e) {
      DialogService.instance.hideLoading();
      print('Exception::authticateUser(): $e');
    }
  }

  resetPassword() async {
    NetworkStatus status =
        await NetworkConnectivity.instance.getNetworkStatus();

    if (status == NetworkStatus.online) {
      try {
        await auth
            .sendPasswordResetEmail(email: email.text.trim())
            .then((value) {
          log("message::::");
          // Handle success (email sent) here if needed
          CustomSnackBars.instance.showSuccessSnackbar(
            title: 'Reset Link Sent',
            message:
                'Check your registered email address to find the password reset link',
          );
        }).catchError((error) {
          // Handle errors here
          if (error is FirebaseAuthException) {
            switch (error.code) {
              case 'user-not-found':
                CustomSnackBars.instance.showFailureSnackbar(
                  title: 'Password Reset Error',
                  message: 'User not found. Please check the email address.',
                );
                break;
              case 'invalid-email':
                CustomSnackBars.instance.showFailureSnackbar(
                  title: 'Password Reset Error',
                  message: 'The email address is not valid.',
                );
                break;
              // Add more cases to handle other error codes as needed

              default:
                // Handle generic error
                CustomSnackBars.instance.showFailureSnackbar(
                  title: 'Password Reset Error',
                  message: 'An error occurred during password reset.',
                );
            }
          } else {
            // Handle other types of errors if needed
          }
        });
      } catch (e) {
        // Handle other exceptions if needed
      }
    } else {
      CustomSnackBars.instance.showFailureSnackbar(
          title: "Error", message: "Please check your internet connection");
    }
  }

  Future<void> updateProfilePicture(XFile file, BuildContext context) async {
    var downloadUrl = await FirebaseStorageService.instance
        .uploadSingleImage(imgFilePath: file.path, context: context);
    await FirebaseCRUDService.instance.updateDocumentSingleKey(
        collection: playersCollection,
        docId: auth.currentUser!.uid,
        key: 'img',
        value: downloadUrl);
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    confirmPass.dispose();
    phoneNum.dispose();
    fName.dispose();
    lName.dispose();
    super.onClose();
  }
}
