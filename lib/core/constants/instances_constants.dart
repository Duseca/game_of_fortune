import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:game_of_fortune/models/player_model.dart';
import 'package:get/get.dart';

//user model for global access
Rx<PlayerModel> userModelGlobal = PlayerModel().obs;

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
FirebaseStorage storage = FirebaseStorage.instance;
