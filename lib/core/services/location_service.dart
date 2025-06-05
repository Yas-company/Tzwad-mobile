import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

final locationServiceProvider = Provider<LocationService>(
  (ref) {
    return LocationService();
  },
);

class LocationService {
  Location location = Location();
  LocationData? _locationData;

  Future<bool> checkAndRequestLocationService() async {
    var isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      final isEnabled = await location.requestService();
      if (!isEnabled) {
        return false;
      }
      return await checkAndRequestLocationPermission();
    }
    return await checkAndRequestLocationPermission();
  }

  Future<bool> checkAndRequestLocationPermission() async {
    var permissionStatus = await location.hasPermission();
    // if (permissionStatus == PermissionStatus.deniedForever) {
    //   return false;
    // }
    if (permissionStatus == PermissionStatus.denied || permissionStatus == PermissionStatus.deniedForever) {
      permissionStatus = await location.requestPermission();
      return permissionStatus == PermissionStatus.granted;
    }

    return true;
  }

  Future<bool> checkPermission() async {
    var permissionStatus = await location.hasPermission();
    return permissionStatus == PermissionStatus.granted;
  }

  void getRealTimeLocationData(void Function(LocationData)? onData) {
    location.onLocationChanged.listen(onData);
  }

  Future<LocationData?> getCurrentLocation() async {
    var locationData = _locationData;
    return locationData ?? await _fetchLocation();
  }

  Future<LocationData?> _fetchLocation() async {
    _locationData = await location.getLocation();
    return _locationData;
  }

// LocationData getDefaultLocation() {
//   return LocationData.fromMap(
//     {
//       "latitude": 31.5204,
//       "longitude": 34.4858,
//     },
//   );
// }
}
