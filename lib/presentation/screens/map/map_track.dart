// ignore_for_file: use_key_in_widget_constructors, avoid_print, file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel/constants/colors.dart';

import '../../../constants/constants.dart';
import '../layout/bottomNave.dart';

class MapTrackScreen extends StatefulWidget {
  final String latitude;
  final String logtitude;

  const MapTrackScreen(
      {Key? key, required this.latitude, required this.logtitude})
      : super(key: key);
  @override
  _MapTrackScreenState createState() => _MapTrackScreenState();
}

class _MapTrackScreenState extends State<MapTrackScreen> {
  GoogleMapController? mapController; //contrller for Google map
  List<Polyline> myPolyline = [];
  Set<Marker> markers = {};
  LatLng startLocation =
      (BottomNave.startLatitude != null || BottomNave.startLongitude != null)
          ? LatLng(BottomNave.startLatitude!, BottomNave.startLongitude!)
          : const LatLng(30.1552360, 31.6128923);

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
        icon: markerImage,
      ),
    );

    markers.add(
      Marker(
        markerId: MarkerId(LatLng(
                double.parse(widget.latitude), double.parse(widget.logtitude))
            .toString()),
        position: LatLng(
            double.parse(widget.latitude), double.parse(widget.logtitude)),
        icon: markerImage,
      ),
    );
    createPolyline();
    super.initState();
  }

  createPolyline() {
    myPolyline.add(
      Polyline(
          polylineId: const PolylineId('1'),
          color: const Color(0xff3366cc),
          width: 5,
          points: [
            LatLng(startLocation.latitude, startLocation.longitude),
            LatLng(
              double.parse(widget.latitude),
              double.parse(widget.logtitude),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          googleMapUI(),
          backIcon(w: w, h: h),
          locationCard(w: w, h: h),
        ],
      ),
    );
  }

  Widget googleMapUI() {
    return Column(
      children: [
        Expanded(
          child: GoogleMap(
            mapType: MapType.normal,
            markers: markers,
            initialCameraPosition: CameraPosition(
              target: LatLng(double.parse(widget.latitude),
                  double.parse(widget.logtitude)),
              zoom: 10,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) async {},
            // circles: circles,
            polylines: myPolyline.toSet(),
          ),
        ),
      ],
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
                        FontAwesomeIcons.locationArrow,
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
