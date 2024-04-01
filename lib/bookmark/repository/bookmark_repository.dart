import 'package:arkeonil/models/article_model.dart';
import 'package:arkeonil/models/favorite_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookMarkRepositoryProvider = Provider(
  (ref) => BookMarkRepository(
      firebaseFirestore: FirebaseFirestore.instance,
      auth: FirebaseAuth.instance),
);

class BookMarkRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth auth;

  BookMarkRepository({required this.firebaseFirestore, required this.auth});

  Stream<List<ArticleModel>> getArticleFavorite() {
    return firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('favorite')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (doc) => ArticleModel.fromMap(
                doc.data(),
              ),
            )
            .toList());
  }

  Future<void> setArticleFavorite(FavoriteModel model) async {
    await firebaseFirestore
        .collection('favorite')
        .doc(model.uid)
        .set(model.toMap());
    await addSubCollection(
        'users', auth.currentUser!.uid, 'favorite', model.uid, model.toMap());
  }

  Future<void> addSubCollection(
      String collectionName,
      String docId,
      String subCollectionName,
      subCollectionId,
      Map<String, dynamic> data) async {
    await firebaseFirestore
        .collection(collectionName)
        .doc(docId)
        .collection(subCollectionName)
        .doc(subCollectionId)
        .set(data);
  }
}
