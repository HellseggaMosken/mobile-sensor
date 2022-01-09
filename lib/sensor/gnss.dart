import 'package:flutter/foundation.dart';
import 'package:location/location.dart';

class GNSS {
  static final Location _location = Location();
  static final GNSS _instance = GNSS._();
  GNSS._();
  factory GNSS() => _instance;

  static Stream<double> latitude() =>
      _location.onLocationChanged.map((e) => e.latitude!);

  static Stream<double> longitude() =>
      _location.onLocationChanged.map((e) => e.longitude!);

  static Stream<double> altitude() =>
      _location.onLocationChanged.map((e) => e.altitude!);

  static Future<bool> initGnssSensor() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    while (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
    }

    if (kDebugMode) {
      print("Location Service Enabled!");
    }

    _permissionGranted = await _location.hasPermission();
    while (_permissionGranted == PermissionStatus.denied ||
        _permissionGranted == PermissionStatus.deniedForever) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted == PermissionStatus.deniedForever) {
        if (kDebugMode) {
          print("Location Permission Denied Forever!");
        }
        return false;
      }
    }

    if (kDebugMode) {
      print("Location Permission Granted!");
    }

    return true;
  }
}
