import 'dart:developer';

import 'package:dim_sum_app/base/base.dart';
import 'package:dim_sum_app/generated/l10n.dart';
import 'package:dim_sum_app/page/page_export.dart';
import 'package:dim_sum_app/utils/prefs_const.dart';
import 'package:dim_sum_app/widgets/custom_dialog_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigatorBloc extends BaseBloc {
  late BuildContext _context;
  final _firebaseAuth = FirebaseAuth.instance;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    final SharedPreferences prefs = await _prefs;
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                prefs.setString(PrefsCache.UID, value.user!.uid),
              });
    } on FirebaseAuthException catch (e) {
      log(e.message!);
      getMessageFromErrorCode(e.message!);
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

  void getMessageFromErrorCode(String errorCode) async {
    final SharedPreferences prefs = await _prefs;
    switch (errorCode) {
      case "user-not-found":
      case "There is no user record corresponding to this identifier. The user may have been deleted.":
        prefs.clear();
        showDialog(
            context: _context,
            builder: (buildContext) {
              return CustomDialogBox(
                title: S.current.notification,
                descriptions: S.current.account_expired,
                text: S.current.close,
                img: 'assets/gif/dim_sum_gif.gif',
                onTap: (){
                  Navigator.pushNamedAndRemoveUntil(
                      _context, SplashPage.routeName, (route) => false);
                },
              );
            });
        break;
      case "unknown":
        prefs.clear();
        showDialog(
            context: _context,
            builder: (buildContext) {
              return CustomDialogBox(
                title: S.current.notification,
                descriptions: S.current.account_expired,
                text: S.current.close,
                img: 'assets/gif/dim_sum_gif.gif',
                onTap: (){
                  Navigator.pushNamedAndRemoveUntil(
                      _context, SplashPage.routeName, (route) => false);
                },
              );
            });
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
      case "account-exists-with-different-credential":
      case "email-already-in-use":
      case "ERROR_WRONG_PASSWORD":
      case "wrong-password":
      case "ERROR_USER_NOT_FOUND":
      case "ERROR_USER_DISABLED":
      case "user-disabled":
      case "ERROR_TOO_MANY_REQUESTS":
      case "operation-not-allowed":
      case "ERROR_OPERATION_NOT_ALLOWED":
      case "ERROR_INVALID_EMAIL":
      case "invalid-email":
      default:
        break;
    }
  }
}
