import 'package:arkeonil/models/archae_category_models.dart';
import 'package:arkeonil/models/article_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryRepositoryProvider = Provider((ref) => CategoryRepository(
    firebaseFirestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance));

class CategoryRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth auth;

  CategoryRepository({required this.firebaseFirestore, required this.auth});

  Stream<List<ArticleModel>> getArticles(String category) {
    return firebaseFirestore
        .collection('articles')
        .where('category', isEqualTo: category)
        .snapshots()
        .map((snapshot) {
      List<ArticleModel> list = [];
      for (var model in snapshot.docs) {
        list.add(
          ArticleModel.fromMap(model.data()),
        );
      }
      return list;
    });
  }

  Stream<List<ArchaeCategory>> getCitiesName(
      String category, List<String> cityName) {
    return firebaseFirestore
        .collection('archaecategory')
        .where('category', isEqualTo: category)
        .where('cityName', arrayContainsAny: cityName)
        .snapshots()
        .map((snapshot) {
      List<ArchaeCategory> list = [];
      for (var model in snapshot.docs) {
        list.add(ArchaeCategory.fromMap(model.data()));
      }
      return list;
    });
  }

  Stream<List<ArticleModel>> getArticlesCities(List<String> cityName) {
    return firebaseFirestore
        .collection('articles')
        .where('cityName', arrayContainsAny: cityName)
        .snapshots()
        .map((snapshot) {
      List<ArticleModel> list = [];
      for (var model in snapshot.docs) {
        list.add(
          ArticleModel.fromMap(model.data()),
        );
      }
      return list;
    });
  }
}
