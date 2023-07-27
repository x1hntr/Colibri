import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

import '../components/health.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  double? nofSleep = 0;
  int? nofSteps = 0;
  int? nofArea = 0;
  int edad = 0;
  DateTime? birthday;
  var clima = 'Cargando..';
  var temperatura = 0;
  var icono = '';
  String? email = '';
  String? surname = '';
  late WeatherFactory ws;
  List<Weather> _data = [];
  String rankingText = "img/ranking0.png";

  double? ranking;

  Future<void> weatherData() async {
    double lat = -0.183038;
    double lon = -78.484401;
    String key = 'eb42031611601a1401c1e7423f7ce112';
    ws = new WeatherFactory(key, language: Language.SPANISH);
    Weather weather = await ws.currentWeatherByLocation(lat, lon);
    setState(() {
      temperatura = weather.temperature!.celsius!.round();
      clima = weather.weatherDescription.toString();
      icono = weather.weatherIcon.toString();
    });
  }

  StepData stepData = StepData();

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
        nofSteps = userDoc!['steps'];
        nofSleep = userDoc!['sleep'].toDouble();
        nofArea = userDoc!['time'];
        surname = userDoc!['surname'];
        email = userDoc!['email'];
        birthday = DateTime.parse(userDoc!['birthday']);
        edad = DateTime.now().difference(birthday!).inDays;
        ranking = (0.5 * (nofSteps! / 10000)) +
            (0.3 * (nofSleep! / 480)) +
            (0.2 * (nofArea! / 60));
        setState(() {
          if (ranking! >= 0 && ranking! <= 0.4) {
            rankingText = "img/ranking0.png";
          }
          if (ranking! > 0.4 && ranking! <= 0.6) {
            rankingText = "img/ranking1.png";
          }
          if (ranking! > 0.6 && ranking! <= 0.8) {
            rankingText = "img/ranking2.png";
          }
          if (ranking! > 0.8) {
            rankingText = "img/ranking3.png";
          }
        });
      } else {
        print("ErrorBDD");
      }
    } catch (e) {
      print("$e");
    }
  }

  @override
  void initState() {
    weatherData();
    getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: h * 0.01,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            width: w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: h * 0.013,
                ),
                SizedBox(
                  height: h * 0.13,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("img/profileBack.png"),
                          fit: BoxFit.fill),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 30, top: 10, bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'HOLA DE NUEVO',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  surname.toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                Text(
                                  email.toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                                Text(
                                  '${(edad ~/ 360)} años',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, right: 30, top: 5, bottom: 5),
                          child: SizedBox(
                            child: Container(
                              child: Image.asset(rankingText.toString()),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: w * 0.013,
                ),
                SizedBox(
                  height: h * 0.035,
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      "INFORMACIÓN DE TU CIUDAD ",
                      style: TextStyle(color: Colors.blue[600]),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200],
                    ),
                  ),
                ),
                SizedBox(
                  height: w * 0.013,
                ),
                SizedBox(
                  height: h * 0.13,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("img/box.png"), fit: BoxFit.fill),
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 10),
                          child: SizedBox(
                            child: Container(
                              child: Image.asset("img/quitoLogo.png"),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: AlignmentDirectional.centerEnd,
                            margin: const EdgeInsets.only(
                                left: 10, right: 25, top: 10, bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  clima.toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 19),
                                ),
                                Text(
                                  temperatura.toString() + '°C',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 35),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: w * 0.013,
                ),
                SizedBox(
                  height: h * 0.035,
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      "TU ACTIVIDAD DE HOY: ",
                      style: TextStyle(color: Colors.blue[600]),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey[200],
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.01,
                ),
                Container(
                  height: h * 0.13,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("img/box1.png"), fit: BoxFit.fill),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "PASOS",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            Text(
                              nofSteps.toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 35),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.013,
                ),
                Container(
                  height: h * 0.13,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("img/box2.png"), fit: BoxFit.fill),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "SUEÑO",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            Text(
                              '${(nofSleep! ~/ 60)}h ${(nofSleep! % 60).toInt()}min',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 30),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.013,
                ),
                Container(
                  height: h * 0.13,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("img/box4.png"), fit: BoxFit.fill),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "ÁREAS VERDES",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20),
                            ),
                            Text(
                              '${(nofArea! ~/ 60)}h ${nofArea! % 60}min',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 30),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
