import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:game_of_fortune/core/constants/firebase_collection_references.dart';
import 'package:game_of_fortune/core/constants/instances_constants.dart';
import 'package:game_of_fortune/core/utils/dialogs.dart';
import 'package:game_of_fortune/models/choices_model.dart';
import 'package:game_of_fortune/models/game_model.dart';
import 'package:game_of_fortune/models/player_model.dart';
import 'package:game_of_fortune/services/firebase/firebase_crud.dart';
import 'package:game_of_fortune/services/mobile_ads/mobile_ads.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GameController extends GetxController {
  late StreamSubscription<QuerySnapshot> playersStream, weeklyPlayerStream;
  RxList<PlayerModel> players = RxList<PlayerModel>([]),
      weeklyPlayers = RxList<PlayerModel>([]);
  late StreamSubscription<QuerySnapshot> gameStream;
  Rx<GameModel> game = GameModel().obs;
  Rx<PlayerModel> winner = PlayerModel().obs;
  RxBool isloading = false.obs;
  RewardedAd? rewardedAd;
  RxBool lifeUpdated = false.obs;
  RxInt rewardedScore = 0.obs;
  RxList<ChoicesModel> selectedChoices = RxList<ChoicesModel>([]);

  @override
  void onInit() async {
    super.onInit();
    isloading(false);
    await getAllPlayers();
    await getGame();
    await getPlayersofCurrentWeek();
  }

  getAllPlayers() async {
    try {
      playersStream = await playersCollection
          .orderBy('highestScore', descending: true)
          .limit(100)
          .snapshots()
          .listen((snapshot) {
        players.clear();
        for (var doc in snapshot.docs) {
          PlayerModel player = PlayerModel.fromMap(doc.data());
          players.add(player);
        }
        update(['overall']);
      });
    } catch (e) {
      print("Exception::getAllPlayers(): $e");
    }
  }

  getPlayersofCurrentWeek() async {
    // Calculate the start and end of the current week
    DateTime startOfWeek =
        DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 6));
    weeklyPlayerStream = await playersCollection
        .where('scoredDate', isGreaterThanOrEqualTo: startOfWeek)
        .where('scoredDate', isLessThanOrEqualTo: endOfWeek)
        .orderBy('highestScore', descending: true)
        .snapshots()
        .listen((snapshot) {
      weeklyPlayers.value =
          (snapshot.docs).map((d) => PlayerModel.fromMap(d.data())).toList();
      update(['weekly']);
    });
  }

  getGame() async {
    try {
      isloading(true);
      gameStream = await gameCollection.limit(1).snapshots().listen((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          game.value = GameModel.fromMap(snapshot.docs.first.data());
        }
        isloading(false);
      });
    } catch (e) {
      isloading(false);
      log("Exception::getGame():$e");
    }
  }

  updateLives(String operator) async {
    try {
      var updatedLives = operator == '+'
          ? userModelGlobal.value.lives! + 1
          : userModelGlobal.value.lives! - 1;
      await playersCollection
          .doc(auth.currentUser!.uid)
          .update({'lives': updatedLives});
    } catch (e) {
      log("Exception::$e");
    }
  }

  updateScores() async {
    if (userModelGlobal.value.highestScore == null ||
        userModelGlobal.value.highestScore! < selectedChoices.length) {
      await playersCollection.doc(auth.currentUser!.uid).update({
        'highestScore': selectedChoices.length,
        'scoredDate': DateTime.now()
      });
    }
    await updatePrizepool();
  }

  updateReplayDuration() async {
    await gameCollection.doc(game.value.gameId).update({
      'canReplayAfter': DateTime.now().add(const Duration(days: 1)),
      'lastWonBy': auth.currentUser!.uid,
      'prize': double.parse(game.value.prize ?? '0') * 2,
    });
  }

  getWinner() async {
    PlayerModel? player =
        players.where((p) => p.playerId == game.value.lastWonBy).firstOrNull;
    if (player != null) {
      winner.value = player;
    } else {
      await FirebaseCRUDService.instance
          .readSingleDocument(
              collectionReference: playersCollection,
              docId: game.value.lastWonBy ?? '')
          .then((snapshot) {
        if (snapshot != null) {
          winner.value =
              PlayerModel.fromMap(snapshot.data() as Map<String, dynamic>);
        }
      });
    }
  }

  addLife() async {
    int difference =
        DateTime.now().difference(userModelGlobal.value.livesUpdatedOn!).inDays;
    var playerLives = userModelGlobal.value.lives! + difference;

    await playersCollection
        .doc(auth.currentUser!.uid)
        .update({'lives': playerLives > 5 ? 5 : playerLives});
  }

  bool canReplay() {
    return game.value.canReplayAfter == null ||
        (game.value.canReplayAfter != null &&
            game.value.canReplayAfter!.isBefore(DateTime.now()));
  }

  createRewardedAd(BuildContext context) async {
    try {
      DialogService.instance.showProgressDialog(context: context);
      await RewardedAd.load(
          adUnitId: AdService.rewardedAdUnitId!,
          request: const AdRequest(),
          rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
            rewardedAd = ad;
            DialogService.instance.hideLoading();
          }, onAdFailedToLoad: (ad) {
            DialogService.instance.hideLoading();
            log("message:: ${ad.message}, ${ad.code}");
            rewardedAd = null;
          }));
    } catch (e) {
      DialogService.instance.hideLoading();
    }
  }

  showRewardedAd(BuildContext context) async {
    try {
      if (rewardedAd != null) {
        rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad) {
            ad.dispose();
          },
          onAdFailedToShowFullScreenContent: (ad, error) {
            ad.dispose();
            createRewardedAd(context);
          },
        );
        await rewardedAd!.show(onUserEarnedReward: (ad, reward) async {
          await updateLives('+');
        });
        rewardedAd = null;
      }
    } catch (e) {
      log("Exception:::showRewardedAd():$e");
    }
  }

  updatePrizepool() async {
    var count = 0;
    if (game.value.playCount == null ||
        (game.value.playCount != null && game.value.playCount! < 10)) {
      count = game.value.playCount! + 1;
      await gameCollection.doc(game.value.gameId).update({'playCount': count});
    }
    if (game.value.playCount == 10) {
      await gameCollection.doc(game.value.gameId).update({'playCount': 0});
      var prizePool = double.tryParse(game.value.prize ?? '0.0')! + 0.01;
      await gameCollection
          .doc(game.value.gameId)
          .update({'prize': prizePool.toString()});
    }
  }

  getTermsCond() async {
    await tcCollection.get().then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        termsCond.value = snapshot.docs.first.data()['termsAndConditions'];
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    isloading(false);
    gameStream.cancel();
    playersStream.cancel();
  }
}
