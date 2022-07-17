import 'package:flutter/services.dart';
import 'package:location/location.dart';

void askPermissionLocation() async {
  // print("cominy");
  final location = Location();
  bool _serviceEnabled;
  PermissionStatus permissionGranted;

  try {
    _serviceEnabled = await location.serviceEnabled();
  } on PlatformException catch (err) {
    // print ("Platform exception calling serviceEnabled(): $err");q
    _serviceEnabled = false;
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted == PermissionStatus.granted) {
      return;
    }
  }
}
