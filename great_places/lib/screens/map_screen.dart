import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initialLocation;
  final isReadOnly;

  const MapScreen({
    this.initialLocation = const PlaceLocation(
        latitude: -8.417240565485155, longitude: -55.52308636661782),
    this.isReadOnly = false,
    Key? key,
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _pickedPosition;

  _selectPosition(LatLng position) {
    setState(() {
      _pickedPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione sua localização'),
        actions: [
          IconButton(
            onPressed: _pickedPosition == null
                ? null
                : () {
                    Navigator.of(context).pop(_pickedPosition);
                  },
            icon: const Icon(
              Icons.check,
              size: 30,
            ),
          )
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 4,
        ),
        onTap: widget.isReadOnly ? null : _selectPosition,
        markers: _pickedPosition == null
            ? Set()
            : {
                Marker(
                  markerId: MarkerId('p4'),
                  position: _pickedPosition!,
                  icon: BitmapDescriptor.defaultMarkerWithHue(270),
                )
              },
      ),
    );
  }
}
