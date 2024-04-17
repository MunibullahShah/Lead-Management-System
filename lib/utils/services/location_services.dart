import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationServices {
  Position? position;
  Future<bool> getLocation() async {
    bool serviceEnabled;
    PermissionStatus permission;

    permission = await Permission.location.request();

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return serviceEnabled;
    }

    if (permission == PermissionStatus.denied) {
      permission = await Permission.location.request();
      if (permission == PermissionStatus.denied) {
        return serviceEnabled;
      }
    }
    if (permission == PermissionStatus.permanentlyDenied) {
      await Geolocator.openAppSettings();
      return serviceEnabled;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    position = await Geolocator.getCurrentPosition();
    return serviceEnabled;
  }
}
