import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game_of_fortune/core/constants/instances_constants.dart';
import 'package:game_of_fortune/models/player_model.dart';
import 'package:game_of_fortune/services/firebase/firebase_crud.dart';

import '../constants/firebase_collection_references.dart';

getUserDataStream({required String userId}) async {
  // getting user's data stream
  await FirebaseCRUDService.instance
      .getSingleDocStream(collectionReference: playersCollection, docId: userId)
      .listen((DocumentSnapshot<Object?> event) {
    userModelGlobal.value =
        PlayerModel.fromMap(event.data() as Map<String, dynamic>);
  });

  // you can cancel the stream if you wanna do
  // userDataStream.cancel();
}

bool isSameDay(DateTime a, DateTime b) {
  return b.year == a.year && b.month == a.month && b.day == a.day;
}
