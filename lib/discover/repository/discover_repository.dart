import 'package:arkeonil/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final discoverRepositoryProvider = Provider((ref) => DiscoverRepository(
    firebaseFirestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance));

class DiscoverRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth auth;

  DiscoverRepository({required this.firebaseFirestore, required this.auth});

  Stream<List<UserModel>> getProfilePhotos() {
    return firebaseFirestore
        .collection('users')
        .orderBy('profilePhoto', descending: true)
        .snapshots()
        .map((snapshot) {
      List<UserModel> list = [];
      for (var model in snapshot.docs) {
        list.add(UserModel.fromMap(model.data()));
      }
      return list;
    });
  }
}
