import 'dart:async';
import 'package:custom_map_markers/custom_map_markers.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'map_pin.dart';

class MapPathScreen extends StatefulWidget {
  const MapPathScreen({Key? key}) : super(key: key);

  @override
  State<MapPathScreen> createState() => MapPathScreenState();
}

class MapPathScreenState extends State<MapPathScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final locations = const [
    LatLng(37.42796133580664, -122.085749655962),
    LatLng(37.41796133580664, -122.085749655962),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomGoogleMapMarkerBuilder(
        customMarkers: [
          MarkerData(
              marker: Marker(
                  markerId: const MarkerId('id-1'), position: locations[0]),
              child: _customMarker('A', Colors.black)),
          MarkerData(
              marker: Marker(
                  markerId: const MarkerId('id-2'), position: locations[1]),
              child: _customMarker('B', Colors.red)),
        ],
        builder: (BuildContext context, Set<Marker>? markers) {
          if (markers == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(37.42796133580664, -122.085749655962),
              zoom: 14.4746,
            ),
            markers: markers,
            onMapCreated: (GoogleMapController controller) {},
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  _customMarker(String s, Color black) {
    return CustomPaint(
      painter: MapPin(black, s),
      size: MediaQuery.of(context).size / 10,
    );
  }
}
