import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dim_sum_app/base/common_function.dart';
import 'package:dim_sum_app/utils/location_util.dart';
import 'package:dim_sum_app/widgets/dialog/dialog_location_connection.dart';
import 'package:geolocator/geolocator.dart';

import 'base.dart';

abstract class BasePage<B extends BaseBloc> extends StatefulWidget {
  BasePage({this.bloc});

  late final BasePageState basePageState;
  final B? bloc;

  @override
  BasePageState createState() {
    basePageState = getState();
    return basePageState;
  }

  BasePageState getState();

  String getStateName() {
    return basePageState.getWidgetName();
  }
}

abstract class BasePageState<T extends BasePage> extends State<T>
    with WidgetsBindingObserver, BaseFunction {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool _onResumed = false;
  bool _onPause = false;
  bool _isShowCheckInternet = false;

  @override
  void initState() {
    initBaseCommon(this);
    NavigatorManger().addWidget(this);
    WidgetsBinding.instance.addObserver(this);
    onCreate();
    widget.bloc?.onCreate(context);
    widget.bloc?.loadingStream.listen((isLoading) {
      showLoading(isLoading);
    });
    widget.bloc?.msgStream.listen((msg) {
      showToastMessage(msg);
    });
    _initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _initCheckLocation();
    super.initState();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  bool get isLoading => isShowLoading;

  dynamic getBloc() {
    return widget.bloc;
  }

  @override
  void deactivate() {
    if (NavigatorManger().isSecondTop(this)) {
      if (!_onPause) {
        onPause();
        _onPause = true;
      } else {
        onResume();
        _onPause = false;
      }
    } else if (NavigatorManger().isTopPage(this)) {
      if (!_onPause) {
        onPause();
      }
    }
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    if (!_onResumed) {
      if (NavigatorManger().isTopPage(this)) {
        _onResumed = true;
        onResume();
      }
    }
    return getBaseView(context);
  }

  @override
  void dispose() {
    onDestroy();
    WidgetsBinding.instance.removeObserver(this);
    _onResumed = false;
    _onPause = false;
    widget.bloc?.dispose();
    widget.bloc?.onDestroy();
    NavigatorManger().removeWidget(this);
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {

      if (NavigatorManger().isTopPage(this)) {

        onForeground();
        onResume();

      }
    } else if (state == AppLifecycleState.paused) {
      if (NavigatorManger().isTopPage(this)) {
        onBackground();
        onPause();
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  Future<void> _initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        if (_isShowCheckInternet) {
          Navigator.of(context).pop();
          _isShowCheckInternet = false;
        }
        break;
      case ConnectivityResult.none:
        _isShowCheckInternet = true;
        showDialogInternetConnect(context);
        break;
      default:
        break;
    }
  }

  Future<void> _initCheckLocation() async {
    if (kIsWeb) {
      LocationUtil.instance.checkPermissionLocation(isGranted: () async{
        Geolocator.getServiceStatusStream().listen((event) {
          final isEnabled = (event.index == 1) ? true : false;
          if (!mounted) return;
          if (isEnabled == false) {
            showLocationConnect(context);
          } else {
            return;
          }
        });
      }, onError: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            useRootNavigator: false,
            builder: (context) {
              return DialogLocationConnect();
            });
      });
    } else {
      Geolocator.getServiceStatusStream().listen((event) {
        final isEnabled = (event.index == 1) ? true : false;
        if (!mounted) return;
        if (isEnabled == false) {
          showLocationConnect(context);
        } else {
          return;
        }
      });
    }
  }
}
