import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference<Map<String, dynamic>> playersCollection =
    FirebaseFirestore.instance.collection("player");
CollectionReference<Map<String, dynamic>> gameCollection =
    FirebaseFirestore.instance.collection("game");
