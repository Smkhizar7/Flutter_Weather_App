import 'package:location/location.dart';

class LocationService {
  void _requestPermission() async {
    final Location location = Location();
    final bool _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      final bool _serviceRequested = await location.requestService();
      if (!_serviceRequested) {
        // Handle the case where the user denies enabling location services.
      }
    }

    final PermissionStatus _permissionGranted =
        await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      // Handle the case where the user denies location permission.
    }
  }

  Future<Map<String, dynamic>> _getLocation() async {
    final Location location = Location();
    try {
      final LocationData _locationResult = await location.getLocation();
      final double latitude = _locationResult.latitude!;
      final double longitude = _locationResult.longitude!;
      final Map<String, dynamic> locationObj = Map();
      locationObj.addAll({'lat': latitude, 'lng': longitude});
      return locationObj;
      // You can use latitude and longitude to do whatever you need with the location data.
    } catch (e) {
      throw Exception("Location error");
      // Handle errors that may occur when trying to get the location.
    }
  }
}
