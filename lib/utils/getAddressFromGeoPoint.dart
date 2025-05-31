import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';

Future<String> getAddressFromGeoPoint(GeoPoint geoPoint) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      geoPoint.latitude,
      geoPoint.longitude,
    );

    if (placemarks.isNotEmpty) {
      final place = placemarks.first;
      return '${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
    } else {
      return 'No address available';
    }
  } catch (e) {
    print('Error in reverse geocoding: $e');
    return 'Error retrieving address';
  }
}
