import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game_of_fortune/core/constants/firebase_collection_references.dart';
import 'package:game_of_fortune/core/constants/instances_constants.dart';
import 'package:game_of_fortune/models/choices_model.dart';
import 'package:game_of_fortune/models/game_model.dart';
import 'package:game_of_fortune/models/player_model.dart';
import 'package:game_of_fortune/services/firebase/firebase_crud.dart';
import 'package:game_of_fortune/services/mobile_ads/mobile_ads.dart';
import 'package:game_of_fortune/view/screens/play_ad_video/play_video.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GameController extends GetxController {
  late StreamSubscription<QuerySnapshot> playersStream;
  RxList<PlayerModel> players = RxList<PlayerModel>([]);
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
      log("message:: $operator");

      var updatedLives = operator == '+'
          ? userModelGlobal.value.lives! + 1
          : userModelGlobal.value.lives! - 1;
      log("message:: ${updatedLives}");
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

  void createRewardedAd() {
    RewardedAd.load(
        adUnitId: AdService.rewardedAdUnitId!,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
          rewardedAd = ad;
        }, onAdFailedToLoad: (ad) {
          log("message:: ${ad.message}, ${ad.code}");
          rewardedAd = null;
        }));
  }

  showRewardedAd() async {
    try {
      if (rewardedAd != null) {
        rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad) {
            ad.dispose();
            createRewardedAd();
          },
          onAdFailedToShowFullScreenContent: (ad, error) {
            ad.dispose();
            createRewardedAd();
          },
        );
        await rewardedAd!.show(onUserEarnedReward: (ad, reward) async {
          await updateLives('+');
        });
        rewardedAd = null;
      } else {
        // CustomSnackBars.instance.showFailureSnackbar(
        //     title: "Alert!",
        //     message: "Currently no ads available, but coming soon!");
        // Get.defaultDialog(
        //   title: 'Ads not ready yet!',
        //   barrierDismissible: false,
        //   content: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: MyText(
        //       text: 'Ads not ready yet, you are still awarded a life. Have fun !!',
        //     ),
        //   ),
        //   confirm: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: MyBorderButton(buttonText: 'Okay', onTap: () async {
        //       await updateLives('+');
        //       Get.back();
        //     }),
        //   )
        // );
        Get.to(() => VideoApp());
        await updateLives('+');
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
    } else if (game.value.playCount == 10) {
      var prizePool = double.tryParse(game.value.prize ?? '0.0')! + 0.01;
      await gameCollection
          .doc(game.value.gameId)
          .update({'prize': prizePool.toString()});
    }

    await gameCollection.doc(game.value.gameId).update({'playCount': count});
  }

  @override
  void onClose() {
    super.onClose();
    isloading(false);
    gameStream.cancel();
    playersStream.cancel();
  }

  getTermsCond() async {
    await tcCollection.get().then((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        termsCond.value = snapshot.docs.first.data()['termsAndConditions'];
      }
    });
  }
}
