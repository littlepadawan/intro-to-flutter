import 'package:geocoding/geocoding.dart';

Future<Placemark?> getPlacemarks(double latitude, double longitude) async {
  try {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    return placemarks.first;
  } catch (e) {
    // Handle any errors that may occur during geocoding // TODO: Update
    print('Error during geocoding: $e');
  }

  // Return an empty string if no city and country found
  return null;
}
