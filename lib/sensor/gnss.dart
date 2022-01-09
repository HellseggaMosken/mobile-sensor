import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:location/location.dart';

class GNSS {
  static final Location _location = Location();
  static final GNSS _instance = GNSS._();

  final _gnssStreamCtl = StreamController<LocationData>.broadcast();

  GNSS._() {
    _location.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 100, // 10Hz
    );

    // _location.onLocationChanged only change when location changed, the _timer
    // and _gnssStreamCtl can make a stream of constant frequency
    Timer.periodic(const Duration(milliseconds: 100), (timer) async {
      var _lc = await _location.getLocation();
      _gnssStreamCtl.sink.add(_lc);
    });
  }
  factory GNSS() => _instance;

  Stream<double> latitude() => _gnssStreamCtl.stream.map((e) => e.latitude!);

  Stream<double> longitude() => _gnssStreamCtl.stream.map((e) => e.longitude!);

  Stream<double> altitude() => _gnssStreamCtl.stream.map((e) => e.altitude!);

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
