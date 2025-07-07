import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as loc;

class AddressService {
  static Future<Map<String, dynamic>> getAddress(loc.LocationData locationData) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      locationData.latitude!,
      locationData.longitude!,
    );
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      final address = {
        'street': place.street,
        'city': place.locality,
        'country': place.country,
        'latitude': locationData.latitude,
        'longitude': locationData.longitude,
      };
      return address;
    } else {
      return {};
    }
  }
}
