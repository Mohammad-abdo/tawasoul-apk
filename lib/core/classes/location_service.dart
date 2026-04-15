import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  // Singleton
  LocationService._internal();
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;

  // Stream للموقع
  final StreamController<Position> _controller =
      StreamController<Position>.broadcast();

  Stream<Position> get positionStream => _controller.stream;

  StreamSubscription<Position>? _subscription;

  LocationAccuracy accuracy = LocationAccuracy.high;
  double distanceFilter = 10;

  // ---------------- Permissions ----------------
  Future<bool> requestPermission() async {
    final permission = await Geolocator.requestPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<bool> checkPermission() async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  // ---------------- Current Location ----------------
  Future<Position> getCurrentLocation() {
    return Geolocator.getCurrentPosition(
      desiredAccuracy: accuracy,
    );
  }

  // ---------------- Listening ----------------
  void startListening() {
    _subscription?.cancel();
    _subscription = Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: accuracy,
        distanceFilter: distanceFilter.toInt(),
      ),
    ).listen(_controller.add);
  }

  void stopListening() {
    _subscription?.cancel();
    _subscription = null;
  }

  // ---------------- Open settings ----------------
  Future<bool> openLocationSettings() async {
    return Geolocator.openLocationSettings();
  }

  // ---------------- Settings ----------------
  void setAccuracy(LocationAccuracy value) {
    accuracy = value;
  }

  void setDistanceFilter(double meters) {
    distanceFilter = meters;
  }

  // ---------------- Service enabled ----------------
  Future<bool> get isLocationServiceEnabled =>
      Geolocator.isLocationServiceEnabled();

  // ---------------- Geocoding ----------------

  // Coordinates -> Address (from Position)
  Future<String> getAddressFromCoordinates(Position pos) async {
    return getAddressFromLatLng(pos.latitude, pos.longitude);
  }

  // Coordinates -> Address (from lat/lng)
  Future<String> getAddressFromLatLng(double lat, double lng) async {
    final placemarks = await placemarkFromCoordinates(lat, lng);
    if (placemarks.isEmpty) return '';
    final p = placemarks.first;
    return '${p.street}, ${p.locality}, ${p.country}';
  }

  /// Short address (street + locality) for destination display
  Future<String> getShortAddressFromLatLng(double lat, double lng) async {
    final placemarks = await placemarkFromCoordinates(lat, lng);
    if (placemarks.isEmpty) return '';
    final p = placemarks.first;
    return '${p.street}, ${p.locality}';
  }

  // Address -> Coordinates
  Future<Position> getCoordinatesFromAddress(String address) async {
    final locations = await locationFromAddress(address);

    if (locations.isEmpty) {
      throw Exception('Address not found');
    }

    final loc = locations.first;

    return Position(
      latitude: loc.latitude,
      longitude: loc.longitude,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
      altitudeAccuracy: 0,
      headingAccuracy: 0,
    );
  }

  void dispose() {
    _subscription?.cancel();
    _controller.close();
  }
}
