import 'package:dim_sum_app/res/colors.dart';
import 'package:dim_sum_app/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget getLoadingWidget() {
  return Container(
    height: ScreenUtil.getInstance().screenHeight,
    width: ScreenUtil.getInstance().screenWidth,
    color: AppColor.colorLoadingDelivery,
    child: Center(
        child: SizedBox(
          width: 150,
          height: 150,
          child: Lottie.asset('assets/gif/loading_lottie_gif.json',fit: BoxFit.fill),
        )
    ),
    // child: Container()
  );
}