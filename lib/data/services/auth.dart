import 'package:dim_sum_app/utils/prefs_const.dart';
import 'package:dim_sum_app/utils/prefs_util.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then(
            (value) => {PrefsUtil.putString(PrefsCache.UID, value.user!.uid)});
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
