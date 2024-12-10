import 'package:geolocator/geolocator.dart';

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  print("[DEBUG] Checking if location services are enabled...");

  LocationPermission locationPermission = await Geolocator.requestPermission();
  print(locationPermission);

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  print(serviceEnabled);

  if (!serviceEnabled) {
    print("[ERROR] Location services are disabled.");
    return Future.error('Location services are disabled.');
  }

  print("[DEBUG] Location services are enabled.");

  print("[DEBUG] Checking location permission status...");
  permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    print("[DEBUG] Location permission is denied. Requesting permission...");
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print("[ERROR] Location permissions are denied.");
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    print("[ERROR] Location permissions are permanently denied.");
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  print("[DEBUG] Location permission granted.");

  print("[DEBUG] Fetching the current position...");
  try {
    Position position = await Geolocator.getCurrentPosition(
      forceAndroidLocationManager: true,
      desiredAccuracy: LocationAccuracy.best,
      timeLimit: const Duration(seconds: 8),
    );
    print("[DEBUG] Current position fetched: Latitude: ${position.latitude}, Longitude: ${position.longitude}");
    return position;
  } catch (e) {
    print("[ERROR] Error fetching position: $e");
    return Future.error('Failed to get current position: $e');
  }
}

