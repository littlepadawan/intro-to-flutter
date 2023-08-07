import 'package:geocoding/geocoding.dart';

class ReverseGeocodingService {
  Future<LocationData> getGeolocationData(
      double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isNotEmpty) {
      Placemark placemark = placemarks[0];
      return LocationData(
          // city: placemark.toString(), country: placemark.isoCountryCode); // TODO: Remove if city is not used
          country: placemark.isoCountryCode);
    } else {
      // return LocationData(city: null, country: null); // TODO: Remove if city is not used
      return LocationData(country: null);
    }
  }
}

class LocationData {
  // final String? city; // TODO: Remove if city is not used
  final String? country;

  // LocationData({this.city, this.country}); // TODO: Remove if city is not used
  LocationData({this.country});
}
