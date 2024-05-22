import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game_of_fortune/core/constants/firebase_collection_references.dart';
import 'package:game_of_fortune/core/constants/instances_constants.dart';
import 'package:game_of_fortune/models/player_model.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  late StreamSubscription<QuerySnapshot> playersStream;
  RxList<PlayerModel> players = RxList<PlayerModel>([]);

  @override
  void onInit() {
    super.onInit();
    getAllPlayers();
  }

  getAllPlayers() async {
    try {
      playersStream = await playersCollection
          .where('playerId', isNotEqualTo: auth.currentUser!.uid)
          .snapshots()
          .listen((snapshot) {
        players.clear();
        for (var doc in snapshot.docs) {
          PlayerModel player = PlayerModel.fromMap(doc.data());
          players.add(player);
        }

        players.sort((a, b) {
          if (a.highestScore != null && b.highestScore != null) {
            return b.highestScore!.compareTo(a.highestScore!);
          } else if (a.highestScore == null && b.highestScore == null) {
            return 0;
          } else if (a.highestScore == null) {
            return 1; // Place null scores at the end
          } else {
            return -1; // Place null scores at the end
          }
        });
      });
    } catch (e) {
      print("Exception::getAllPlayers(): $e");
    }
  }

  @override
  void onClose() {
    super.onClose();
    playersStream.cancel();
  }
}
