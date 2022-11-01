import 'dart:developer';

import 'package:dim_sum_app/base/base.dart';
import 'package:dim_sum_app/page/page_export.dart';
import 'package:dim_sum_app/utils/prefs_const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends BaseBloc {
  late BuildContext _context;
  final _firebaseAuth = FirebaseAuth.instance;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _uidController = BehaviorSubject<String?>();

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Stream<String?> get outUID => _uidController.stream;

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    final SharedPreferences prefs = await _prefs;
    showLoading();
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                prefs.setString(PrefsCache.UID, value.user!.uid),
                prefs.setString(PrefsCache.USER, value.user!.email!),
                prefs.setString(PrefsCache.PASSWORD, password),
                Navigator.pushReplacementNamed(_context, NavigatorPage.routeName)
              });
    } on FirebaseAuthException catch (e) {
      log(e.message!);
      getMessageFromErrorCode(e.message!);
    }
    hiddenLoading();
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    showLoading();
    try {
      await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                _uidController.sink.add(value.user?.uid),
              });
    } on FirebaseAuthException catch (e) {
      log(e.message!);
    }
    hiddenLoading();
  }

  String getMessageFromErrorCode(String errorCode) {
    switch (errorCode) {
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
        return "Email already used. Go to login page.";
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
        return "Wrong email/password combination.";
      case "ERROR_USER_NOT_FOUND":
      case "user-not-found":
        return "No user found with this email.";
      case "ERROR_USER_DISABLED":
      case "user-disabled":
        return "User disabled.";
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
        return "Too many requests to log into this account.";
      case "ERROR_OPERATION_NOT_ALLOWED":
        return "Server error, please try again later.";
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
        return "Email address is invalid.";
      default:
        return "Login failed. Please try again.";
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void onCreate(BuildContext context) {
    _context = context;
  }
}
