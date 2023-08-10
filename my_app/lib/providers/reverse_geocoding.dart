import 'package:geocoding/geocoding.dart';

Future<Placemark?> getPlacemarks(double latitude, double longitude) async {
  try {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    return placemarks.first;
  } catch (_) {
    return null;
  }
}
