import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:great_places/utils/location_util.dart';
import 'package:location/location.dart';

class LocationInputWidget extends StatefulWidget {
  final Function(LatLng) onSelectedPosition;
  const LocationInputWidget({super.key, required this.onSelectedPosition});

  @override
  State<LocationInputWidget> createState() => _LocationInputWidgetState();
}

class _LocationInputWidgetState extends State<LocationInputWidget> {
  String? _previewImageURl;

  void _showPreview(double latitude, double longitude) {
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude,
      longitude,
    );

    setState(() {
      _previewImageURl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentLocation() async {
    try {
      final locData = await Location().getLocation();

      if (locData.latitude == null || locData.longitude == null) return;

      _showPreview(locData.latitude!, locData.longitude!);

      widget.onSelectedPosition(LatLng(locData.latitude!, locData.longitude!));
    } on Exception catch (e) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    try {
      final LatLng selectedPosition = await Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (context) => MapScreen(),
        ),
      );

      if (selectedPosition == null) return;

      _showPreview(selectedPosition.latitude, selectedPosition.longitude);

      widget.onSelectedPosition(selectedPosition);
    } catch (e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          alignment: Alignment.center,
          child: _previewImageURl == null
              ? const Text(
                  'Nenhuma localização fornecida',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )
              : Image.network(
                  _previewImageURl!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => _getCurrentLocation(),
              icon: const Icon(Icons.location_on),
              label: const Text(
                'Localização atual',
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            ElevatedButton.icon(
              onPressed: () => _selectOnMap(),
              icon: const Icon(Icons.map),
              label: const Text(
                'Selecione no mapa',
              ),
            ),
          ],
        )
      ],
    );
  }
}
