import 'package:dim_sum_app/base/base.dart';
import 'package:dim_sum_app/data/services/auth.dart';
import 'package:dim_sum_app/page/page_export.dart';
import 'package:dim_sum_app/res/colors.dart';
import 'package:dim_sum_app/utils/screen_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends BasePage {
  HomePage({Key? key}) : super(bloc: HomeBloc());

  @override
  BasePageState<BasePage<BaseBloc>> getState() => _HomePageState();
  static const routeName = '/HomePage';
}

class _HomePageState extends BasePageState<HomePage> {

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: ScreenUtil.getInstance().screenHeight,
        width: ScreenUtil.getInstance().screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Home Screen',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenUtil.getInstance().getAdapterSize(25),),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onCreate() {}

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }
}
