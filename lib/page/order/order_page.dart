import 'package:dim_sum_app/base/base.dart';
import 'package:dim_sum_app/generated/l10n.dart';
import 'package:dim_sum_app/page/page_export.dart';
import 'package:dim_sum_app/utils/screen_util.dart';
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
    return Scaffold(
      body: SizedBox(
        height: ScreenUtil.getInstance().screenHeight,
        width: ScreenUtil.getInstance().screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                S.current.order,
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
  void onCreate() {
    // TODO: implement onCreate
  }

  @override
  void onDestroy() {
    // TODO: implement onDestroy
  }

}