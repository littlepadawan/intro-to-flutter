import 'package:geocoding/geocoding.dart';

class ReverseGeocodingService {
  Future<LocationData> getGeolocationData(
      double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
      return LocationData(country: placemark.isoCountryCode);
    } else {
      return LocationData(country: null);
    }
  }
}

class LocationData {
  final String? country;

  LocationData({this.country});
}
