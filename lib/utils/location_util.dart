import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationUtil {
  LocationUtil._internal();

  static final LocationUtil instance = LocationUtil._internal();

  Future<Position> checkPermissionLocation(
      {required VoidCallback isGranted, required VoidCallback onError}) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Dịch vụ vị trí bị tắt.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        onError.call();
        return Future.error('Quyền vị trí bị từ chối');
      }
    } else if (permission == LocationPermission.deniedForever) {
      onError.call();
      return Future.error(
          'Quyền vị trí bị từ chối vĩnh viễn, chúng tôi không thể yêu cầu quyền.');
    }
    isGranted.call();
    return await Geolocator.getCurrentPosition();
  }

  Future<Position> getLocation() async {
    return await Geolocator.getCurrentPosition();
  }
}
