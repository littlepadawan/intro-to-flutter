import 'dart:async';
import 'package:geolocator/geolocator.dart';

Future<Position> getCurrentCoordinates() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
      timeLimit: const Duration(seconds: 15));
  return position;
}
