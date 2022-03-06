// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel/constants/colors.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController; //contrller for Google map
  PolylinePoints polylinePoints = PolylinePoints();

  String googleAPiKey = "AIzaSyBxCWZSLFx6zvcjHUGC268Mrkw0EREsyb8";

  Set<Marker> markers = {}; //markers for google map
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  LatLng startLocation = const LatLng(27.6683619, 85.3101895);
  LatLng endLocation = const LatLng(27.6688312, 85.3077329);

  @override
  void initState() {
    markers.add(
      Marker(
        //add start location marker
        markerId: MarkerId(startLocation.toString()),
        position: startLocation, //position of marker
        infoWindow: const InfoWindow(
          //popup info
          title: 'Starting Point ',
          snippet: 'Start Marker',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ),
    );

    markers.add(
      Marker(
        //add distination location marker
        markerId: MarkerId(endLocation.toString()),
        position: endLocation, //position of marker
        infoWindow: const InfoWindow(
          //popup info
          title: 'Destination Point ',
          snippet: 'Destination Marker',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ),
    );

    getDirections(); //fetch direction polylines from Google API

    super.initState();
  }

  getDirections() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(endLocation.latitude, endLocation.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      print(result.errorMessage);
    }
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      visible: true,
      consumeTapEvents: true,
      patterns: <PatternItem>[PatternItem.dash(5), PatternItem.gap(5)],
      color: MyColors.mainColor,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: polylineCoordinates,
      width: 8,
    );

    setState(() {
      polylines[id] = polyline;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        toolbarHeight: 0.0,
      ),
      body: GoogleMap(
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        zoomGesturesEnabled: false,
        initialCameraPosition: CameraPosition(
          target: startLocation,
          zoom: 16.0,
        ),
        markers: markers, //markers to show on map
        polylines: Set<Polyline>.of(polylines.values),
        zoomControlsEnabled: false,
        mapType: MapType.normal, //map type
        onMapCreated: (controller) {
          //method called when map is created
          setState(() {
            mapController = controller;
          });
        },
      ),
    );
  }
}
