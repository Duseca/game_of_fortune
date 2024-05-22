import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:game_of_fortune/core/utils/dialogs.dart';
import 'package:path/path.dart' as path;
import '../../core/utils/snackbars.dart';

class FirebaseStorageService {
  //singleton instance
  static FirebaseStorageService get instance => FirebaseStorageService();

  //method to upload single image on Firebase
  Future<String> uploadSingleImage(
      {required String imgFilePath,
      String storageRef = "images",
      required BuildContext context}) async {
    try {
      DialogService.instance.showProgressDialog(context: context);
      final filePath = path.basename(imgFilePath);
      final ref =
          FirebaseStorage.instance.ref().child(storageRef).child(filePath);

      await ref.putFile(File(imgFilePath)).timeout(Duration(seconds: 30));

      String downloadUrl = await ref.getDownloadURL();
      DialogService.instance.hideLoading();
      return downloadUrl;
    } on FirebaseException catch (e) {
      DialogService.instance.hideLoading();

      CustomSnackBars.instance
          .showFailureSnackbar(title: "Failed", message: '$e');
      return '';
    } on TimeoutException {
      DialogService.instance.hideLoading();

      CustomSnackBars.instance
          .showFailureSnackbar(title: "Failed", message: 'Request Timeout');
      return '';
    } catch (e) {
      DialogService.instance.hideLoading();

      CustomSnackBars.instance
          .showFailureSnackbar(title: "Failed", message: '$e');
      return '';
    }
  }

  //get image url paths functions
  Future<List> uploadMultipleImages(
      {required List imagesPaths,
      String storageRef = "images",
      required BuildContext context}) async {
    try {
      DialogService.instance.showProgressDialog(context: context);
      final futureList = imagesPaths.map((element) async {
        final filePath = path.basename(element);
        final ref =
            FirebaseStorage.instance.ref().child(storageRef).child(filePath);
        await ref.putFile(File(element));
        return ref.getDownloadURL();
      });
      final downloadURLs = await Future.wait(futureList);
      DialogService.instance.hideLoading();
      return downloadURLs;
    } on FirebaseException catch (e) {
      DialogService.instance.hideLoading();
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Failed", message: '$e');
      return [];
    } on TimeoutException {
      DialogService.instance.hideLoading();

      CustomSnackBars.instance
          .showFailureSnackbar(title: "Failed", message: 'Request Timeout');
      return [];
    } catch (e) {
      DialogService.instance.hideLoading();

      CustomSnackBars.instance
          .showFailureSnackbar(title: "Failed", message: '$e');
      return [];
    }
  }

  deleteSingleFile(String path) async {
    try {
      var ref = FirebaseStorage.instance.refFromURL(path);
      await ref.delete();
    } on FirebaseException catch (e) {
      DialogService.instance.hideLoading();
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Failed", message: '$e');
      return [];
    } on TimeoutException {
      DialogService.instance.hideLoading();

      CustomSnackBars.instance
          .showFailureSnackbar(title: "Failed", message: 'Request Timeout');
      return [];
    } catch (e) {
      DialogService.instance.hideLoading();

      CustomSnackBars.instance
          .showFailureSnackbar(title: "Failed", message: '$e');
      return [];
    }
  }
}
