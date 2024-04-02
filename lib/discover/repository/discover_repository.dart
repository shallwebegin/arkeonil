import 'package:arkeonil/models/archae_category_models.dart';
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

  Stream<List<ArchaeCategory>> getProfilePhotos() {
    return firebaseFirestore
        .collection('archaecategory')
        .orderBy('image', descending: true)
        .snapshots()
        .map((snapshot) {
      List<ArchaeCategory> list = [];
      for (var model in snapshot.docs) {
        list.add(ArchaeCategory.fromMap(model.data()));
      }
      return list;
    });
  }
}
