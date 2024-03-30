import 'package:arkeonil/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
      firebaseFirestore: FirebaseFirestore.instance,
      auth: FirebaseAuth.instance),
);

class AuthRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth auth;

  AuthRepository({required this.firebaseFirestore, required this.auth});

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<void> storeUserInfoFirebase(UserModel userModel) async {
    userModel.profilePhoto ??=
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5jIY1G0NyLWJzkvbkUWXsvWU9zAHc8Upcv_zH-WlkWA&s';

    userModel.uid = auth.currentUser!.uid;

    await firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set(userModel.toMap());
  }
}
