import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:game_of_fortune/core/constants/instances_constants.dart';
import 'package:game_of_fortune/core/enums/network_status.dart';
import 'package:game_of_fortune/core/utils/dialogs.dart';
import 'package:game_of_fortune/core/utils/network_connectivity.dart';
import 'package:game_of_fortune/view/screens/auth/login.dart';
import 'package:get/get.dart';
import '../../core/utils/snackbars.dart';

class FirebaseAuthService extends GetxController {
  static FirebaseAuthService get instance => FirebaseAuthService();

  //signing up user with email and password
  Future<User?> signUpUsingEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (FirebaseAuth.instance.currentUser != null) {
        User user = FirebaseAuth.instance.currentUser!;

        return user;
      }
      if (FirebaseAuth.instance.currentUser == null) {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      //showing failure snackbar
      CustomSnackBars.instance.showFailureSnackbar(
          title: 'Authentication Error', message: '${e.message}');

      return null;
    } on FirebaseException catch (e) {
      //showing failure snackbar
      CustomSnackBars.instance.showFailureSnackbar(
          title: 'Authentication Error', message: '${e.message}');

      return null;
    } catch (e) {
      log("This was the exception while signing up: $e");

      return null;
    }

    return null;
  }

  //signing in user with email and password
  Future<User?> signInUsingEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      NetworkStatus status =
          await NetworkConnectivity.instance.getNetworkStatus();

      if (status == NetworkStatus.online) {
        DialogService.instance.showProgressDialog(context: context);
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        DialogService.instance.hideLoading();
        if (FirebaseAuth.instance.currentUser != null) {
          User user = FirebaseAuth.instance.currentUser!;

          return user;
        }
        if (FirebaseAuth.instance.currentUser == null) {
          return null;
        }
      } else {
        CustomSnackBars.instance
            .showFailureSnackbar(title: 'error'.tr, message: 'network'.tr);
      }
    } on FirebaseAuthException catch (e) {
      DialogService.instance.hideLoading();

      //showing failure snackbar
      CustomSnackBars.instance.showFailureSnackbar(
          title: 'Authentication Error', message: '${e.message}');

      return null;
    } on FirebaseException catch (e) {
      DialogService.instance.hideLoading();

      //showing failure snackbar
      CustomSnackBars.instance.showFailureSnackbar(
          title: 'Authentication Error', message: '${e.message}');

      return null;
    } catch (e) {
      DialogService.instance.hideLoading();

      log("This was the exception while signing up: $e");

      return null;
    }

    return null;
  }

  //reAuthenticating user to confirm if the same user is requesting
  Future<void> changeFirebaseEmail(
      {required String email,
      required String password,
      required String newEmail}) async {
    try {
      final User user = await FirebaseAuth.instance.currentUser!;

      final cred =
          EmailAuthProvider.credential(email: email, password: password);

      await user.reauthenticateWithCredential(cred).then((value) async {
        await user.verifyBeforeUpdateEmail(newEmail);

        CustomSnackBars.instance.showSuccessSnackbar(
          title: "Vefification Link Sent",
          message:
              "We have sent you a verification email, please update your email by verifying from the link",
          duration: 6,
        );

        //logging out user (so that we can update his email on the Firebase when he logs in again)
        await FirebaseAuth.instance.signOut();

        //navigating back to Login Screen
        Get.offAll(() => Login());
      }).onError((error, stackTrace) {
        CustomSnackBars.instance
            .showFailureSnackbar(title: 'Error', message: '$error');
      });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          CustomSnackBars.instance
              .showFailureSnackbar(title: 'Error', message: 'User not found');
          break;
        case 'wrong-password':
          CustomSnackBars.instance
              .showFailureSnackbar(title: 'Error', message: 'Wrong password');
          break;
        case 'invalid-email':
          CustomSnackBars.instance
              .showFailureSnackbar(title: 'Error', message: 'Invalid email');
          break;
        case 'email-already-in-use':
          CustomSnackBars.instance.showFailureSnackbar(
              title: 'Error', message: 'Email already in use');
          break;
        default:
          CustomSnackBars.instance.showFailureSnackbar(
              title: 'Retry', message: 'Something went wrong');
          break;
      }
    }
  }

  //method to change Firebase password
  Future<void> changeFirebasePassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  }) async {
    final user = await FirebaseAuth.instance.currentUser;
    final cred =
        EmailAuthProvider.credential(email: email, password: oldPassword);

    try {
      user!.reauthenticateWithCredential(cred).then((value) {
        user.updatePassword(newPassword).then((_) {
          CustomSnackBars.instance.showSuccessSnackbar(
              title: "Success", message: "Password updated successfully");
        }).onError((error, stackTrace) {
          CustomSnackBars.instance
              .showFailureSnackbar(title: "Failure", message: "$error");
        });
      }).onError((error, stackTrace) {
        CustomSnackBars.instance
            .showFailureSnackbar(title: "Failure", message: "$error");
      });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          CustomSnackBars.instance
              .showFailureSnackbar(title: 'Error', message: 'User not found');
          break;
        case 'wrong-password':
          CustomSnackBars.instance
              .showFailureSnackbar(title: 'Error', message: 'Wrong password');
          break;
        case 'invalid-email':
          CustomSnackBars.instance
              .showFailureSnackbar(title: 'Error', message: 'Invalid email');
          break;
        case 'email-already-in-use':
          CustomSnackBars.instance.showFailureSnackbar(
              title: 'Error', message: 'Email already in use');
          break;
        default:
          CustomSnackBars.instance.showFailureSnackbar(
              title: 'Retry', message: 'Something went wrong');
          break;
      }
    }
  }

  logOut() async {
    await auth.signOut();
    Get.offAll(Login());
  }
}
