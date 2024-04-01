import 'package:arkeonil/models/article_model.dart';
import 'package:arkeonil/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final moreRepositoryProvider = Provider(
  (ref) => MoreRepository(
      auth: FirebaseAuth.instance,
      firebaseFirestore: FirebaseFirestore.instance),
);

class MoreRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firebaseFirestore;
  MoreRepository({required this.auth, required this.firebaseFirestore});

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<UserModel> getUser() async {
    final user = await firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get();

    return UserModel.fromMap(user.data()!);
  }

  Future<void> writeArticle(ArticleModel model) async {
    await firebaseFirestore
        .collection('articles')
        .doc(model.uid)
        .set(model.toMap());
    await addSubCollection(
        'users', auth.currentUser!.uid, 'articles', model.uid, model.toMap());
  }

  Stream<List<ArticleModel>> getArticle() {
    return firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('articles')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(
              (doc) => ArticleModel.fromMap(
                doc.data(),
              ),
            )
            .toList());
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
