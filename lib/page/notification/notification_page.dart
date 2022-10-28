import 'package:dim_sum_app/base/base.dart';
import 'package:dim_sum_app/page/page_export.dart';
import 'package:flutter/material.dart';

class NotificationPage extends BasePage {
  NotificationPage({Key? key}) : super(bloc: NotificationBloc());
  static const routeName = '/NotificationPage';

  @override
  BasePageState<BasePage<BaseBloc>> getState() => _NotificationPageState();

}

class _NotificationPageState extends BasePageState<NotificationPage> {
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