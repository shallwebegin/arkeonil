import 'package:arkeonil/router/router_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userControlRepository =
    Provider((ref) => UserControllerRepository(auth: FirebaseAuth.instance));

class UserControllerRepository {
  final FirebaseAuth auth;

  UserControllerRepository({required this.auth});

  isUserSignedIn() {
    final user = auth.currentUser;
    if (user != null) {
      return AppRouteNames.home;
    } else {
      return AppRouteNames.signIn;
    }
  }
}
