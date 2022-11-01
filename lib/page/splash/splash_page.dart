import 'package:dim_sum_app/data/services/auth.dart';
import 'package:dim_sum_app/page/page_export.dart';
import 'package:dim_sum_app/utils/prefs_const.dart';
import 'package:dim_sum_app/utils/prefs_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dim_sum_app/utils/screen_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  static const routeName = '/SplashPage';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final User? user = Auth().currentUser;

  Future<void> initToken() async {
    final SharedPreferences prefs = await _prefs;
    final tokenUID = prefs.getString(PrefsCache.UID);

    if (tokenUID != null) {
      Future.delayed(
          const Duration(seconds: 3),
          () => {
                Navigator.pushReplacementNamed(context, NavigatorPage.routeName)
              });
    } else {
      Future.delayed(const Duration(seconds: 3),
          () => {Navigator.pushReplacementNamed(context, LoginPage.routeName)});
    }
  }

  @override
  void initState() {
    super.initState();
    initToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: ScreenUtil.getInstance().screenHeight,
        width: ScreenUtil.getInstance().screenWidth,
        child: Center(
          child: Image.asset(
            'assets/gif/dim_sum_gif.gif',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
