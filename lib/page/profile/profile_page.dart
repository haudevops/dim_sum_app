import 'package:dim_sum_app/base/base.dart';
import 'package:dim_sum_app/page/page_export.dart';
import 'package:flutter/material.dart';

class ProfilePage extends BasePage {
  ProfilePage({Key? key}) : super(bloc: ProfileBloc());
  static const routeName = '/ProfilePage';

  @override
  BasePageState<BasePage<BaseBloc>> getState() => _ProfilePageState();

}

class _ProfilePageState extends BasePageState<ProfilePage> {
  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold();
  }

  @override
  void onCreate() {
    // TODO: implement onCreate
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }

}