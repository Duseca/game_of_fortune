import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:game_of_fortune/models/player_model.dart';
import 'package:get/get.dart';

//user model for global access
Rx<PlayerModel> userModelGlobal = PlayerModel().obs;
const adVideo='https://firebasestorage.googleapis.com/v0/b/game-of-fortune-6a305.appspot.com/o/Showreel-Grid-Mobile-%5Bremix%5D%20(1).mp4?alt=media&token=ddb327f8-58dd-4848-9e3b-8ab1bbbd3291';
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;
