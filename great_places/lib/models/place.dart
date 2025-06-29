import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String? address;

  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    this.address,
  });

  LatLng toLatLng() {
    return LatLng(this.latitude, this.longitude);
  }
}

class Place {
  final String id;
  final String title;
  final File image;
  final PlaceLocation? location;

  Place({
    required this.id,
    required this.title,
    required this.image,
    required this.location,
  });
}
