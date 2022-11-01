import 'dart:async';

import 'package:dim_sum_app/base/base.dart';
import 'package:dim_sum_app/data/services/auth.dart';
import 'package:dim_sum_app/generated/l10n.dart';
import 'package:dim_sum_app/page/page_export.dart';
import 'package:dim_sum_app/utils/prefs_const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigatorPage extends BasePage {
  NavigatorPage({Key? key}) : super(bloc: NavigatorBloc());
  static const routeName = '/NavigatorPage';

  @override
  BasePageState<BasePage<BaseBloc>> getState() => _NavigatorPageState();
}

class _NavigatorPageState extends BasePageState<NavigatorPage> {
  int _selectedIndex = 0;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final User? user = Auth().currentUser;
  String? email;
  String? password;
  late NavigatorBloc _bloc;

  Future<void> checkUserExpired() async {
    final SharedPreferences prefs = await _prefs;
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      debugPrint(timer.tick.toString());
      _bloc.signInWithEmailAndPassword(
          email: prefs.getString(PrefsCache.USER)!,
          password: prefs.getString(PrefsCache.PASSWORD)!);
    });
  }

  @override
  void onCreate() {
    _bloc = getBloc();
    checkUserExpired();
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: _navigateToScreen(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: S.current.home,
                ),
                GButton(
                  icon: Icons.ac_unit,
                  text: S.current.order,
                ),
                GButton(
                  icon: Icons.notifications,
                  text: S.current.notification,
                ),
                GButton(
                  icon: Icons.person,
                  text: S.current.profile,
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _navigateToScreen(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return OrderPage();
      case 2:
        return NotificationPage();
      case 3:
        return ProfilePage();
      default:
        return HomePage();
    }
  }
}
