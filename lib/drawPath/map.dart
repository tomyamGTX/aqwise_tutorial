import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapPathScreen extends StatefulWidget {
  const MapPathScreen({Key? key}) : super(key: key);

  @override
  State<MapPathScreen> createState() => MapPathScreenState();
}

class MapPathScreenState extends State<MapPathScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Set<Marker> _marker = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: GoogleMap(
      //   mapType: MapType.hybrid,
      //   initialCameraPosition: _kGooglePlex,
      //   markers: _marker,
      //   onMapCreated: (GoogleMapController controller) async {
      //     _controller.complete(controller);
      //     setState(() {});
      //     _marker.add(Marker(
      //         markerId: const MarkerId('1'),
      //         icon: await circleCanvasWithText(
      //             size: const Size(100, 200), text: '20'),
      //         position:
      //             LatLng(_kLake.target.latitude, _kLake.target.longitude)));
      //   },
      // ),

      body: CustomPaint(
        painter: MapPin(),
        child: const Center(
          child: Text(
            '01',
            style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
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
}

class MapPin extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 5
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    var path1 = Path();
    var height = 100;
    var width = 50.0;
    path1.moveTo(size.width / 2 - width, size.height / 2);
    path1.lineTo(size.width / 2, size.height / 2 + height);
    path1.lineTo(size.width / 2 + width, size.height / 2);

    canvas.drawPath(path1, paint);
    canvas.drawCircle(Offset.zero, 10, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
