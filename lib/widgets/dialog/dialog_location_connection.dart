import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dim_sum_app/res/colors.dart';
import 'package:dim_sum_app/utils/location_util.dart';
import 'package:dim_sum_app/utils/open_settings/open_settings.dart';
import 'package:dim_sum_app/utils/screen_util.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class DialogLocationConnect extends StatefulWidget {
  const DialogLocationConnect({Key? key}) : super(key: key);

  @override
  State<DialogLocationConnect> createState() => _DialogLocationConnectState();
}

class _DialogLocationConnectState extends State<DialogLocationConnect>
    with WidgetsBindingObserver {
  final _location = Location();
  PermissionStatus? _permissionGrant;
  bool _isPop = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _initCheckLocation();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _initCheckLocation() async {
    Geolocator.getServiceStatusStream().listen((event) {
      final isEnabled = (event.index == 1) ? true : false;
      if (!mounted) return;
      if (isEnabled == true) {
        Navigator.pop(context);
      } else {
        return;
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      final granted = await _location.serviceEnabled();
      if (!granted) {
        print('GPS not turn on');
      } else {
        Geolocator.getServiceStatusStream().listen((event) {
          final isEnabled = (event.index == 1) ? true : false;
          if (!mounted) return;
          if (isEnabled == true) {
            Navigator.pop(context);
          } else {
            return;
          }
        });
      }
    }
    if (state == AppLifecycleState.detached) {
      final granted = await _location.serviceEnabled();
      if (!granted) {
        print('GPS not turn on');
      } else {
        Geolocator.getServiceStatusStream().listen((event) {
          final isEnabled = (event.index == 1) ? true : false;
          if (!mounted) return;
          if (isEnabled == true) {
            Navigator.pop(context);
          } else {
            return;
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        child: _bodyWidget(context),
      ),
    );
  }

  Widget _bodyWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Image.asset('assets/images/img_no_network_connection.png'),
        const SizedBox(height: 10),
        Text(
          'Th??ng b??o',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: ScreenUtil().getAdapterSize(18),
              color: AppColor.colorWhiteDark,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        SvgPicture.asset(
          'assets/icon/svg/img_no_location_connection.svg',
          width: ScreenUtil.getInstance().getAdapterSize(150),
          height: ScreenUtil.getInstance().getAdapterSize(150),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil.getInstance().getAdapterSize(8)),
          child: Text(
            kIsWeb
                ? 'Y??u c???u m??? GPS trong D???ch v??? v??? tr?? ph???n C??i ?????t tr??n thi???t b???.\n ???ng d???ng c???n v??? tr?? ch??nh x??c c???a b???n. N???u b???n ???? b???t GPS, vui l??ng ???n t???i l???i'
                : 'Y??u c???u m??? GPS trong D???ch v??? v??? tr?? ph???n C??i ?????t tr??n thi???t b???.\n ???ng d???ng c???n v??? tr?? ch??nh x??c c???a b???n',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: ScreenUtil().getAdapterSize(16),
                color: AppColor.colorTextGray),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: AppColor.colorPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () async {
              if (kIsWeb) {
                LocationPermission permission;
                permission = await Geolocator.checkPermission();
                LocationUtil.instance.checkPermissionLocation(isGranted: () {
                  if (permission == LocationPermission.whileInUse) {
                    setState(() {
                      // Navigator.pop(context);
                      Navigator.popUntil(context, (route) => route.isFirst);
                    });
                  }
                }, onError: () async {
                  LocationPermission permission;
                  permission = await Geolocator.checkPermission();
                  if (permission == LocationPermission.denied ||
                      permission == LocationPermission.unableToDetermine) {
                    permission = await Geolocator.requestPermission();
                    if (permission == LocationPermission.denied ||
                        permission == LocationPermission.unableToDetermine) {
                      permission = await Geolocator.requestPermission();
                      return Future.error('Quy???n v??? tr?? b??? t??? ch???i');
                    }
                  } else if (permission == LocationPermission.deniedForever ||
                      permission == LocationPermission.unableToDetermine) {
                    permission = await Geolocator.requestPermission();
                    return Future.error(
                        'Quy???n v??? tr?? b??? t??? ch???i v??nh vi???n, ch??ng t??i kh??ng th??? y??u c???u quy???n.');
                  }
                });
              } else {
                OpenSettings.openLocationSettings();
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                kIsWeb ? 'T???i l???i'.toUpperCase() : '?????n c??i ?????t'.toUpperCase(),
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}
