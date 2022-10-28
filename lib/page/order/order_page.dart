import 'package:dim_sum_app/base/base.dart';
import 'package:dim_sum_app/page/page_export.dart';
import 'package:flutter/material.dart';

class OrderPage extends BasePage {
  OrderPage({Key? key}) : super(bloc: OrderBloc());
  static const routeName = '/OrderPage';

  @override
  BasePageState<BasePage<BaseBloc>> getState() => _OrderPageState();

}

class _OrderPageState extends BasePageState<OrderPage> {
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