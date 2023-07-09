import 'dart:async';
import 'dart:convert';

import 'package:colibri/components/nearby_responce.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:slidable_button/slidable_button.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  bool status = true;
  late DateTime arrive;
  late DateTime comming;
  String texto = "Vamos al";
  static LatLng? _initialPosition;
  String apiKey = "AIzaSyBtlvVOfjzkzTQ7iabXp3bdsJB27oswIG0";
  String radius = "500";
  var _positionB = SlidableButtonPosition.right;

  NearbyPlaces nearbyPlaces = NearbyPlaces();

  void getCurrentLocation() async {
    Position _position = await GeolocatorPlatform.instance.getCurrentPosition(
        locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.bestForNavigation));
    _initialPosition = LatLng(_position.latitude, _position.longitude);
  }

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _initialPosition == null
          ? Container(
              child: Center(
                child: Text(
                  'loading map..',
                  style: TextStyle(
                      fontFamily: 'Avenir-Medium', color: Colors.grey[400]),
                ),
              ),
            )
          : Container(
              child: Stack(children: <Widget>[
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: _initialPosition!,
                    zoom: 16,
                  ),
                  myLocationEnabled: true,
                  onMapCreated: onMapCreated,
                ),
                Positioned(
                  left: w * 0.25,
                  top: 600,
                  child: FloatingActionButton.extended(
                    onPressed: _goToThePark,
                    label: Text('Vamos al Parque!'),
                    icon: const Icon(Icons.park_outlined),
                    backgroundColor: Colors.green[400],
                  ),
                ),
                Positioned(
                  left: w * 0.15,
                  top: 500,
                  child: SlidableButton(
                    initialPosition: _positionB,
                    width: 250,
                    height: 45,
                    buttonWidth: 90.0,
                    color: Colors.green[400],
                    buttonColor: Colors.amber,
                    dismissible: false,
                    label: Center(
                        child: Text('Al parque',
                            style:
                                TextStyle(fontSize: 17, color: Colors.white))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Vamonos',
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                          Text(
                            'Llegamos',
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    onChanged: (position) {
                      setState(() {
                        if (position == SlidableButtonPosition.right) {
                          _goToThePark();
                        }
                        if (position == SlidableButtonPosition.left) {
                          _goOfThePark();
                        }
                      });
                    },
                  ),
                )
              ]),
            ),
    );
  }

  void getNearbyPlaces() async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/search/json?radius=' +
            radius +
            '&name=park&key=' +
            apiKey +
            '&location=' +
            _initialPosition!.latitude.toString() +
            ',' +
            _initialPosition!.longitude.toString());
    var response = await http.post(url);
    nearbyPlaces = NearbyPlaces.fromJson(jsonDecode(response.body));
    print(url);
    print(_initialPosition!.latitude.toString());
    print(_initialPosition!.longitude.toString());
    Results results = Results();
    results = nearbyPlaces.results![0];
    print(results.name);
    setState(() {});
  }

  Future<void> _goToThePark() async {
    getNearbyPlaces();
    arrive = DateTime.now();
    print(arrive.toString());
  }

  Future<void> _goOfThePark() async {
    getNearbyPlaces();
    comming = DateTime.now();
    print(comming.toString());
  }
}
