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
                Navigator.pushReplacementNamed(_context, HomePage.routeName)
              });
    } on FirebaseAuthException catch (e) {
      log(e.message!);
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

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void onCreate(BuildContext context) {
    _context = context;
  }
}
