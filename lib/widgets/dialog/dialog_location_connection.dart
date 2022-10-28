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
          'Thông báo',
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
                ? 'Yêu cầu mở GPS trong Dịch vụ vị trí phần Cài đặt trên thiết bị.\n Ứng dụng cần vị trí chính xác của bạn. Nếu bạn đã bật GPS, vui lòng ấn tải lại'
                : 'Yêu cầu mở GPS trong Dịch vụ vị trí phần Cài đặt trên thiết bị.\n Ứng dụng cần vị trí chính xác của bạn',
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
                      return Future.error('Quyền vị trí bị từ chối');
                    }
                  } else if (permission == LocationPermission.deniedForever ||
                      permission == LocationPermission.unableToDetermine) {
                    permission = await Geolocator.requestPermission();
                    return Future.error(
                        'Quyền vị trí bị từ chối vĩnh viễn, chúng tôi không thể yêu cầu quyền.');
                  }
                });
              } else {
                OpenSettings.openLocationSettings();
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                kIsWeb ? 'Tải lại'.toUpperCase() : 'Đến cài đặt'.toUpperCase(),
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
