import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_of_fortune/view/widgets/image_picker_bottom_sheet.dart';
import 'package:image_picker/image_picker.dart';
import '../snackbars.dart';

class ImagePickerService {
  //private constructor
  ImagePickerService._privateConstructor();

  //singleton instance variable
  static ImagePickerService? _instance;

  //This code ensures that the singleton instance is created only when it's accessed for the first time.
  //Subsequent calls to ImagePickerService.instance will return the same instance that was created before.

  //getter to access the singleton instance
  static ImagePickerService get instance {
    _instance ??= ImagePickerService._privateConstructor();
    return _instance!;
  }

  //select image from camera
  Future<XFile?> pickImageFromCamera() async {
    try {
      XFile? imgXFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
      if (imgXFile == null) {
        return null;
      } else {
        return imgXFile;
      }
    } on PlatformException catch (e) {
      log("This was the platform exception while selecting image: $e");

      CustomSnackBars.instance.showFailureSnackbar(
          title: "Error Occurred",
          message: "Something went wrong, please try again");

      return null;
    } catch (e) {
      log("This was the exception while selecting image: $e");

      CustomSnackBars.instance.showFailureSnackbar(
          title: "Error Occurred",
          message: "Something went wrong, please try again");

      return null;
    }
  }

  //select image from gallery
  Future<XFile?> pickSingleImageFromGallery() async {
    try {
      XFile? imgXFile = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 50);
      if (imgXFile == null) {
        return null;
      }

      return imgXFile;
    } on PlatformException catch (e) {
      log("This was the exception while selecting image: $e");

      CustomSnackBars.instance.showFailureSnackbar(
          title: "Error Occurred",
          message: "Something went wrong, please try again");

      return null;
    } catch (e) {
      log("This was the exception while selecting image: $e");

      CustomSnackBars.instance.showFailureSnackbar(
          title: "Error Occurred",
          message: "Something went wrong, please try again");

      return null;
    }
  }

  //select multiple images from gallery
  Future<List<XFile>> pickMultiImagesFromGallery() async {
    try {
      List<XFile> pickedImages =
          await ImagePicker().pickMultiImage(imageQuality: 50);
      if (pickedImages.isEmpty) {
        return [];
      }

      return pickedImages;
    } on PlatformException catch (e) {
      log("This was the exception while selecting image: $e");

      CustomSnackBars.instance.showFailureSnackbar(
          title: "Error Occurred",
          message: "Something went wrong, please try again");

      return [];
    } catch (e) {
      log("This was the exception while selecting image: $e");

      CustomSnackBars.instance.showFailureSnackbar(
          title: "Error Occurred",
          message: "Something went wrong, please try again");

      return [];
    }
  }

  //method to open modal bottom sheet for selecting profile pic
  void openProfilePickerBottomSheet(
      {required BuildContext context,
      required VoidCallback onCameraPick,
      required VoidCallback onGalleryPick}) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      elevation: 0,
      builder: (_) {
        return ImagePickerBottomSheet(
          onCameraPick: onCameraPick,
          onGalleryPick: onGalleryPick,
        );
      },
    );
  }
}
