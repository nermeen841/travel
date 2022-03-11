// ignore_for_file: use_key_in_widget_constructors, avoid_print, file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel/constants/colors.dart';

class MapTrackScreen extends StatefulWidget {
  @override
  _MapTrackScreenState createState() => _MapTrackScreenState();
}

class _MapTrackScreenState extends State<MapTrackScreen> {
  GoogleMapController? mapController; //contrller for Google map
  PolylinePoints polylinePoints = PolylinePoints();

  String googleAPiKey = "AIzaSyBxCWZSLFx6zvcjHUGC268Mrkw0EREsyb8";

  Set<Marker> markers = {}; //markers for google map
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction
  var iconImage;
  LatLng startLocation = const LatLng(27.6683619, 85.3101895);
  LatLng endLocation = const LatLng(27.6688312, 85.3077329);

  getMarker() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(96, 96)),
            'assets/icons/Your Location.png')
        .then((value) {
      setState(() {
        iconImage = value;
      });
    });
  }

  @override
  void initState() {
    getMarker();
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
          icon: BitmapDescriptor.defaultMarker //Icon for Marker
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
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        toolbarHeight: 0.0,
      ),
      body: Stack(
        children: [
          GoogleMap(
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
            mapType: MapType.terrain, //map type
            onMapCreated: (controller) {
              //method called when map is created
              setState(() {
                mapController = controller;
              });
            },
          ),
          backIcon(w: w, h: h),
          locationCard(w: w, h: h),
        ],
      ),
    );
  }

///////////////////////////////////////////////////////////////////////////////////////
  backIcon({required double w, required double h}) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding:
            EdgeInsets.symmetric(vertical: h * 0.013, horizontal: w * 0.03),
        child: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back_ios,
            color: MyColors.mainColor,
            size: w * 0.08,
          ),
        ),
      ),
    );
  }

////////////////////////////////////////////////////////////////////////////////////////

  locationCard({required double h, required double w}) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: h * 0.2,
        margin: EdgeInsets.all(w * 0.07),
        padding:
            EdgeInsets.symmetric(horizontal: w * 0.015, vertical: h * 0.015),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(w * 0.05),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: const Offset(0, 3))
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: w * 0.3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(w * 0.05),
                image: const DecorationImage(
                    image: NetworkImage(
                        "https://img.freepik.com/free-photo/sphinx-pyramids-egypt_414617-6.jpg?w=740"),
                    fit: BoxFit.cover),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: h * 0.015,
                ),
                SizedBox(
                  width: w * 0.3,
                  child: Text(
                    "3 Birrel Avenue",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: headingStyle.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: h * 0.05,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: MyColors.mainColor,
                      size: w * 0.04,
                    ),
                    SizedBox(
                      width: w * 0.2,
                      child: Text(
                        "10 Mtr Left",
                        style: headingStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: MyColors.backgroundColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: w * 0.1,
                    height: h * 0.07,
                    decoration: BoxDecoration(
                      color: MyColors.mainColor,
                      borderRadius: BorderRadius.circular(w * 0.02),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: w * 0.1,
                    height: h * 0.07,
                    decoration: BoxDecoration(
                      color: MyColors.mainColor,
                      borderRadius: BorderRadius.circular(w * 0.02),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.info_outline,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
