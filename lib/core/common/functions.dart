import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game_of_fortune/core/constants/instances_constants.dart';
import 'package:game_of_fortune/core/utils/snackbars.dart';
import 'package:game_of_fortune/models/player_model.dart';
import 'package:game_of_fortune/services/firebase/firebase_crud.dart';
import 'package:game_of_fortune/view/screens/auth/login.dart';
import 'package:get/get.dart';

import '../constants/firebase_collection_references.dart';

getUserDataStream({required String userId}) async {
  try {
    await playersCollection
        .doc(userId)
        .snapshots()
        .listen((DocumentSnapshot<Object?> event) {
      if (event.data() != null) {
        userModelGlobal.value =
            PlayerModel.fromMap(event.data() as Map<String, dynamic>);
      } else {
        Get.offAll(() => Login());
        CustomSnackBars.instance.showFailureSnackbar(
            title: 'Error', message: 'Some error occurred. Please login again');
      }
    });
  } catch (e) {
    Get.offAll(() => Login());
    CustomSnackBars.instance
        .showFailureSnackbar(title: 'Error', message: 'Please login again');
  }

  // you can cancel the stream if you wanna do
  // userDataStream.cancel();
}

bool isSameDay(DateTime a, DateTime b) {
  return b.year == a.year && b.month == a.month && b.day == a.day;
}
