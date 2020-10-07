import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math' show cos, sqrt, asin;

import 'package:location/location.dart';


class FullScreenMapActivity extends StatefulWidget {

  @override
  State createState() => FullScreenMap("categoryKey");
}

class FullScreenMap extends State<FullScreenMapActivity> {
  String  categoryKey = "";
  FullScreenMap(this.categoryKey);

  GoogleMapController mapController;
  Set<Marker> _marker = {};
  //LatLng _center = const LatLng(22.7196, 75.8577);
  LatLng _center = const LatLng(45.2499945, 18.4048266);
  final double _zoom = 14;
  double nearByDistance = 255.0;
  LocationData currentLocation;
  CameraPosition cameraPosition;
  var location = new Location();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  void initState() {
    super.initState();

    location.onLocationChanged.listen((LocationData cLoc) {
      currentLocation = cLoc;
      updateLocation();
    });

    setInitialLocation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 25,
            ),
          ),
          title: Text("Map of Darnis",
              style: TextStyle(fontSize: 16, color: Colors.grey)),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: mapView(context),
      ),
    );
  }

  Widget mapView(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: MediaQuery
          .of(context)
          .size
          .height,
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: false,
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
          new Factory<OneSequenceGestureRecognizer>(
                () => new EagerGestureRecognizer(),
          ),
        ].toSet(),
        rotateGesturesEnabled: true,
        scrollGesturesEnabled: true,
        tiltGesturesEnabled: true,
        buildingsEnabled: true,
        myLocationEnabled: true,
        compassEnabled: false,
        markers: _marker,
        initialCameraPosition: CameraPosition(target: _center, zoom: _zoom),
      ),
    );
  }

  void setInitialLocation() async {
    currentLocation = await location.getLocation();

    setState(() {
      cameraPosition = CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: _zoom);

      _marker.add(Marker(
        markerId: MarkerId("123"),
        position: LatLng(currentLocation.latitude, currentLocation.longitude),
      ));
/*
      mapController.animateCamera(
          CameraUpdate.newCameraPosition(cameraPosition));*/
    });
  }

  void updateLocation() async {
    if (this.mounted) {
      setState(() {
        cameraPosition = CameraPosition(
            target: LatLng(currentLocation.latitude, currentLocation.longitude),
            zoom: _zoom);

        _marker.add(Marker(
          markerId: MarkerId("123"),
          position: LatLng(currentLocation.latitude, currentLocation.longitude),
        ));

        /*mapController.animateCamera(
            CameraUpdate.newCameraPosition(cameraPosition));
*/
        // updateMarkers();
      });
    }
  }

  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
