import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsService {
  final PolylinePoints _polylinePoints = PolylinePoints();

  Future<List<LatLng>> getRoute({
    required LatLng start,
    required LatLng end,
  }) async {
    try {
      final result = await _polylinePoints.getRouteBetweenCoordinates(
        // NOTE: Replace with a real key (Directions API enabled + billing).
        googleApiKey: "AIzaSyC2iDlAq0lghjjC6EuVgSIzVsHfKlISs14",//'YOUR_GOOGLE_MAPS_API_KEY',
        request: PolylineRequest(
          origin: PointLatLng(start.latitude, start.longitude),
          destination: PointLatLng(end.latitude, end.longitude),
          mode: TravelMode.driving,
        ),
      );

      // flutter_polyline_points may return an error message or throw.
      if (result.errorMessage != null && result.errorMessage!.isNotEmpty) {
        // Keep app alive; route polyline is optional UI enhancement.
        // ignore: avoid_print
        print('DirectionsService.getRoute error: ${result.errorMessage}');
        return [];
      }

      if (result.points.isNotEmpty) {
        return result.points
            .map((e) => LatLng(e.latitude, e.longitude))
            .toList();
      }

      return [];
    } catch (e) {
      // Most common: REQUEST_DENIED (bad/missing key, API not enabled, billing).
      // ignore: avoid_print
      print('DirectionsService.getRoute exception: $e');
      return [];
    }
  }
}
