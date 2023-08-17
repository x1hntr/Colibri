import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colibri/components/nearby_responce.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  bool? status;
  late DateTime llegada;
  late int _time;
  String texto = "Vamos al";
  LatLng? _initialPosition;
  String apiKey = "AIzaSyBtlvVOfjzkzTQ7iabXp3bdsJB27oswIG0";
  String radius = "1";
  String? parque;
  dynamic slidable = SlidableButtonPosition.left;
  final green = Colors.green[400];
  final amber = Colors.red[400];
  Color? colorBtnPark;
  String? butText;

  Results results = Results();

  NearbyPlaces nearbyPlaces = NearbyPlaces();

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<LatLng> getCurrentLocation() async {
    Position _position = await determinePosition();

    final currentPosition = LatLng(_position.latitude, _position.longitude);
    return currentPosition;
  }

  Future<void> moveInitialPosition() async {
    final currentLocation = await getCurrentLocation();
    moveCameraPosition(currentLocation);
  }

  Future<String?> getNearbyPlaces(LatLng? position) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/search/json?radius=' +
            radius +
            '&name=park&key=' +
            apiKey +
            '&location=' +
            position!.latitude.toString() +
            ',' +
            position.longitude.toString());
    var response = await http.post(url);
    nearbyPlaces = NearbyPlaces.fromJson(jsonDecode(response.body));
    print('Donde estoy: ' + nearbyPlaces.results.toString());

    if (nearbyPlaces.results!.isNotEmpty) {
      results = nearbyPlaces.results![0];
      parque = results.name;
      print("el parque" + parque!);
      return parque;
    }
    return null;
  }

  Future<void> moveCameraPosition(LatLng? position) async {
    final GoogleMapController controller2 = await _controller.future;
    controller2.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: position!, zoom: 17)));
  }

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  getData() async {
    try {
      final value = FirebaseAuth.instance.currentUser;
      final uidUser = value!.uid;
      print(uidUser.toString());
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      DocumentSnapshot documentSnapshot = await users.doc(uidUser).get();
      if (documentSnapshot.exists) {
        dynamic userDoc = documentSnapshot.data();
        status = userDoc!['contando'];
        llegada = DateTime.parse(userDoc!['arrive']);
        _time = userDoc!['time'];
        setState(() {
          if (status == true) {
            colorBtnPark = amber;
          } else {
            colorBtnPark = green;
            butText = 'Vamos al Parque!';
          }
        });
      } else {
        print("ErrorBDD");
      }
    } catch (e) {
      print("$e");
    }
  }

  setArrive(_estado, date) async {
    try {
      final arrive = {
        "contando": _estado,
        "arrive": date,
      };
      final value = FirebaseAuth.instance.currentUser;
      final uidUser = value!.uid;
      final datos = FirebaseFirestore.instance;
      datos.collection('users').doc(uidUser).update(arrive);
    } catch (e) {
      print("$e");
    }
  }

  setTime(_estado, date) async {
    try {
      final time = {
        "contando": _estado,
        "time": date,
      };
      final value = FirebaseAuth.instance.currentUser;
      final uidUser = value!.uid;
      final datos = FirebaseFirestore.instance;
      datos.collection('users').doc(uidUser).update(time);
    } catch (e) {
      print("$e");
    }
  }

  @override
  void initState() {
    moveInitialPosition();
    colorBtnPark = amber;
    getData();
    butText = 'Vamos al Parque!';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        child: Stack(children: <Widget>[
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: const CameraPosition(
              target: LatLng(-0.18523526393205988, -78.48430776506714),
              zoom: 16,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            myLocationEnabled: true,
          ),
          Positioned(
            left: w * 0.25,
            top: 600,
            child: FloatingActionButton.extended(
              onPressed: _goToThePark,
              label: Text(butText.toString()),
              icon: const Icon(Icons.park_outlined),
              backgroundColor: colorBtnPark,
            ),
          )
        ]),
      ),
    );
  }

  Future<void> _goToThePark() async {
    final park = await getNearbyPlaces(await getCurrentLocation());
    print(park);
    //await moveCameraPosition();
    if (park == null) {
      Widget okButton = TextButton(
        child: Text("Ok"),
        onPressed: () async {
          Navigator.pop(context);
        },
      );

      AlertDialog alertPark = AlertDialog(
        title: Text("Lo sentimos"),
        content: Text("¡Asegurate de encontrarte en un parque!"),
        actions: [
          okButton,
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertPark;
        },
      );
    } else {
      print("Lo que imprimo: " + results.name.toString());
      if (status == false) {
        Widget okButton = TextButton(
          child: Text("ok"),
          onPressed: () async {
            print('LLEGANDO');
            status = true;
            llegada = DateTime.now();
            setArrive(true, llegada.toString());
            Navigator.pop(context);
            setState(() {
              colorBtnPark = amber;
              butText = 'Vámonos del Parque!';
            });
          },
        );

        AlertDialog alert = AlertDialog(
          title: Text("Empezar contar"),
          content: Text("Vas a empezar a contar tu tiempo en: " +
              results.name.toString()),
          actions: [
            okButton,
          ],
        );

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      } else {
        getData();
        status = false;
        print(llegada.toString());
        print(DateTime.now().toString());
        Duration tiempo = DateTime.now().difference(llegada);
        print(tiempo.inMinutes);
        setTime(false, tiempo.inMinutes.toInt() + _time);
      }
    }
  }
}
