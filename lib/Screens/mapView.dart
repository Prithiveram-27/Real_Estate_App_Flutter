// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const LatLng _currentLocation = LatLng(11.0168, 76.9558);

class MapViewController extends StatefulWidget {
  static const route = "/MapScreen";

  const MapViewController({super.key});

  @override
  State<MapViewController> createState() => _MapViewControllerState();
}

class _MapViewControllerState extends State<MapViewController> {
  late MapViewController mapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: _currentLocation,
          zoom: 14,
        ),
        onMapCreated: (controller) {
          mapController = controller as MapViewController;
        },
      ),
    );
  }
}
