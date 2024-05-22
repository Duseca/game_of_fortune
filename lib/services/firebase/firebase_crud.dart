import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game_of_fortune/core/enums/network_status.dart';
import 'package:game_of_fortune/core/utils/network_connectivity.dart';
import '../../core/utils/snackbars.dart';

class FirebaseCRUDService {
  //private constructor
  FirebaseCRUDService._privateConstructor();

  //singleton instance variable
  static FirebaseCRUDService? _instance;

  //This code ensures that the singleton instance is created only when it's accessed for the first time.
  //Subsequent calls to FirebaseCRUDService.instance will return the same instance that was created before.

  //getter to access the singleton instance
  static FirebaseCRUDService get instance {
    _instance ??= FirebaseCRUDService._privateConstructor();
    return _instance!;
  }

  /// Create Document
  Future<bool> createDocument({
    required CollectionReference collectionReference,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    try {
      NetworkStatus status =
          await NetworkConnectivity.instance.getNetworkStatus();

      if (status == NetworkStatus.online) {
        await collectionReference.doc(docId).set(data);
      } else {
        CustomSnackBars.instance.showFailureSnackbar(
            title: "Error", message: "Please check your internet connection");
      }

      //returning true to indicate that the document is created
      return true;
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);

      //returning false to indicate that the document was not created
      return false;
    } catch (e) {
      log("This was the exception while creating document on Firestore: $e");

      //returning false to indicate that the document was not created
      return false;
    }
  }

  /// Read Single Document
  Future<DocumentSnapshot?> readSingleDocument(
      {required CollectionReference collectionReference,
      required String docId}) async {
    try {
      DocumentSnapshot documentSnapshot =
          await collectionReference.doc(docId).get();

      if (documentSnapshot.exists) {
        return documentSnapshot;
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);
      return null;
    } catch (e) {
      log("This was the exception while reading document from Firestore: $e");
      return null;
    }
  }

  /// Read Single Document with where query
  Future<QueryDocumentSnapshot?> readSingleDocByFieldName({
    required CollectionReference collectionReference,
    required String fieldName,
    required String fieldValue,
  }) async {
    try {
      QuerySnapshot documentSnapshot = await collectionReference
          .where(fieldName, isEqualTo: fieldValue)
          .get();

      if (documentSnapshot.docs.isNotEmpty) {
        return documentSnapshot.docs[0];
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);
      return null;
    } catch (e) {
      log("This was the exception while reading document from Firestore: $e");
      return null;
    }
  }

  //method to get single document stream
  Stream<DocumentSnapshot<Object?>> getSingleDocStream(
      {required CollectionReference collectionReference,
      required String docId}) {
    return collectionReference.doc(docId).snapshots();
  }

  //method to get stream of snapshots
  StreamSubscription<QuerySnapshot>? getStream(
      {required CollectionReference collectionReference}) {
    try {
      //getting document snapshots stream
      StreamSubscription<QuerySnapshot> stream =
          collectionReference.snapshots().listen((event) {});

      return stream;
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);

      return null;
    } catch (e) {
      log("This was the exception while getting stream from Firestore: $e");

      return null;
    }
  }

  /// check if the document exists in Firestore
  Future<bool> isDocExist(
      {required CollectionReference collectionReference,
      required String docId}) async {
    try {
      DocumentSnapshot documentSnapshot =
          await collectionReference.doc(docId).get();

      if (documentSnapshot.exists) {
        return true;
      } else {
        return false;
      }
    } on FirebaseException catch (e) {
      log("This was the exception while reading document from Firestore: $e");

      return false;
    } catch (e) {
      log("This was the exception while reading document from Firestore: $e");

      return false;
    }
  }

  /// Read all documents
  Future<QuerySnapshot<Map<String, dynamic>>?> readAllDocument(
      {required CollectionReference<Map<String, dynamic>> collection}) async {
    await processFirebaseRequest(() async => await collection.get());
    return null;
  }

  /// Update Document
  Future<bool> updateDocument(
      {required CollectionReference collection,
      required String docId,
      required Map<String, dynamic> data}) async {
    try {
      await collection.doc(docId).update(data);

      return true;
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);

      //returning false to indicate that the document was not created
      return false;
    } catch (e) {
      log("This was the exception while updating document on Firestore: $e");

      //returning false to indicate that the document was not created
      return false;
    }
  }

  //update single key of a document
  Future<bool> updateDocumentSingleKey({
    required CollectionReference collection,
    required String docId,
    required String key,
    required var value,
  }) async {
    try {
      await collection.doc(docId).update({
        key: value,
      });

      return true;
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);

      //returning false to indicate that the document was not created
      return false;
    } catch (e) {
      log("This was the exception while updating document single key on Firestore: $e");

      //returning false to indicate that the document was not created
      return false;
    }
  }

  /// Delete Document
  Future<void> deleteDocument(
      {required CollectionReference<Map<String, dynamic>> collection,
      required String docId}) async {
    await processFirebaseRequest(() => collection.doc(docId).delete());
  }

  /// Read All Documents (Snapshot)
  Stream<QuerySnapshot> readAllDocuments(
      {required CollectionReference<Map<String, dynamic>> collection}) {
    return collection.snapshots();
  }

  /// Read Some Documents (Snapshot)
  Stream<QuerySnapshot> readDocumentsByKey(
      {required CollectionReference<Map<String, dynamic>> collection,
      required searchKey,
      required value}) {
    return collection.where(searchKey, isEqualTo: value).snapshots();
  }

  /// This method is responsible for executing and handling Firebase operations
  Future<T?> processFirebaseRequest<T>(Future<T> Function() call) async {
    try {
      return await call();
    } on FirebaseException catch (e) {
      final errorMessage = getFirestoreErrorMessage(e);
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);
      return null; // or handle as needed
    } catch (e) {
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: e.toString());
      return null; // or handle as needed
    }
  }

  /// Method to get a user-friendly message from FirebaseException
  String getFirestoreErrorMessage(FirebaseException e) {
    switch (e.code) {
      case 'cancelled':
        return 'The operation was cancelled.';
      case 'unknown':
        return 'An unknown error occurred.';
      case 'invalid-argument':
        return 'Invalid argument provided.';
      case 'deadline-exceeded':
        return 'The deadline was exceeded, please try again.';
      case 'not-found':
        return 'Requested document was not found.';
      case 'already-exists':
        return 'The document already exists.';
      case 'permission-denied':
        return 'You do not have permission to execute this operation.';
      case 'resource-exhausted':
        return 'Resource limit has been exceeded.';
      case 'failed-precondition':
        return 'The operation failed due to a precondition.';
      case 'aborted':
        return 'The operation was aborted, please try again.';
      case 'out-of-range':
        return 'The operation was out of range.';
      case 'unimplemented':
        return 'This operation is not implemented or supported yet.';
      case 'internal':
        return 'Internal error occurred.';
      case 'unavailable':
        return 'The service is currently unavailable, please try again later.';
      case 'data-loss':
        return 'Data loss occurred, please try again.';
      case 'unauthenticated':
        return 'You are not authenticated, please login and try again.';
      default:
        return 'An unexpected error occurred, please try again.';
    }
  }
}
