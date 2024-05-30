import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game_of_fortune/core/constants/firebase_collection_references.dart';
import 'package:game_of_fortune/core/constants/instances_constants.dart';
import 'package:game_of_fortune/models/choices_model.dart';
import 'package:game_of_fortune/models/game_model.dart';
import 'package:game_of_fortune/models/player_model.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  late StreamSubscription<QuerySnapshot> playersStream;
  RxList<PlayerModel> players = RxList<PlayerModel>([]);
  late StreamSubscription<QuerySnapshot> gameStream;
  Rx<GameModel> game = GameModel().obs;
  RxList<ChoicesModel> selectedChoices = RxList<ChoicesModel>([]);

  @override
  void onInit() {
    super.onInit();
    getAllPlayers();
    getGame();
  }

  getAllPlayers() async {
    try {
      playersStream = await playersCollection.snapshots().listen((snapshot) {
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

  getGame() async {
    try {
      gameStream = await gameCollection.limit(1).snapshots().listen((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          game.value = GameModel.fromMap(snapshot.docs.first.data());
        }
      });
    } catch (e) {
      log("Exception::getGame():$e");
    }
  }

  updateLives() async {
    var updatedLives = userModelGlobal.value.lives! - 1;

    await playersCollection
        .doc(auth.currentUser!.uid)
        .update({'lives': updatedLives});
  }

  updateScores() async {
    if (userModelGlobal.value.highestScore == null ||
        userModelGlobal.value.highestScore! < selectedChoices.length) {
      await playersCollection.doc(auth.currentUser!.uid).update({
        'highestScore': selectedChoices.length,
        'scoredDate': DateTime.now()
      });
    }
  }

  updateReplayDuration() async {
    await gameCollection.doc(game.value.gameId).update(
        {'canReplayAfter': DateTime.now().add(const Duration(days: 1))});
  }

  @override
  void onClose() {
    super.onClose();
    gameStream.cancel();
    playersStream.cancel();
  }
}
