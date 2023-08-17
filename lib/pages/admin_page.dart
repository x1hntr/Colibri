import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:slidable_button/slidable_button.dart';
import 'package:weather/weather.dart';

import '../components/health.dart';
import 'login_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  dynamic? nofSleep = 1;
  dynamic? nofSteps = 1;
  dynamic? nofArea = 1;
  dynamic? nofUsers = 1;

  var clima = 'Cargando..';
  var temperatura = 0;
  var icono = '';
  String? correo = '';
  String? surname = '';
  late WeatherFactory ws;
  List<Weather> _data = [];

  Future<void> weatherData() async {
    double lat = -0.181672;
    double lon = -78.484575;
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

  Future<void> getInformation() async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('getDataAdmin');
    final results = await callable();
    print("el data: " + results.data.toString());
    nofUsers = results.data["nofUsers"];

    nofSteps = results.data["nofSteps"];
    nofSleep = results.data["nofSleep"];
    nofArea = results.data["nofAreas"];

    print('Caminar: ' + nofSteps.toString());
    print('Dormir: ' + nofSleep.toString());
    print('Areas: ' + nofArea.toString());
    print('Users: ' + nofUsers.toString());
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
        surname = userDoc!['surname'];
        correo = userDoc!['correo'];
        print('Username: ' + surname!.toString());
        print('Email: ' + correo!.toString());
      } else {
        print("ErrorBDD");
      }
    } catch (e) {
      print("$e");
    }
  }

  @override
  void initState() {
    getInformation();
    weatherData();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _positionB = SlidableButtonPosition.left;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    Widget okButton = TextButton(
      child: Text("Si"),
      onPressed: () async {
        await FirebaseAuth.instance.signOut();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false);
      },
    );

    initState() {
      print(w.toString());
    }

    Widget cancelButton = TextButton(
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => AdminPage()));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Cerrar Sesión"),
      content: Text("¿Estas seguro que quieres cerrar sesión?"),
      actions: [
        okButton,
        cancelButton,
      ],
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        toolbarHeight: 60,
        leadingWidth: 50,
        title: Text(
          DateFormat.MMMEd().format(DateTime.now()),
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        actions: [
          Container(width: 90, child: Image.asset("img/IconHome.png")),
          SizedBox(
            width: w * 0.015,
            height: h * 0.010,
          ),
        ],
      ),
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: h * 0.0055,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            width: w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: h * 0.009,
                ),
                SizedBox(
                  child: Container(
                    height: h * 0.13,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("img/profileBack.png"),
                          fit: BoxFit.fill),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            alignment: AlignmentDirectional.centerEnd,
                            margin: const EdgeInsets.only(
                                left: 10, right: 25, top: 10, bottom: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'HOLA DE NUEVO',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  surname.toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                Text(
                                  "Admin",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
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
                                  nofUsers.toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 40),
                                ),
                                Text(
                                  "Usuarios",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 25),
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
                  height: h * 0.009,
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
                  height: h * 0.01,
                ),
                SizedBox(
                  child: Container(
                    height: h * 0.13,
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
                  height: h * 0.009,
                ),
                SizedBox(
                  height: h * 0.035,
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      "LA ACTIVIDAD DE USUARIOS DE COLIBRI: ",
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
                                  color: Colors.white, fontSize: 18),
                            ),
                            Text(
                              (nofSteps.round()).toString(),
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
                  height: h * 0.01,
                ),
                Container(
                  height: h * 0.125,
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
                  height: h * 0.01,
                ),
                Container(
                  height: h * 0.125,
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
                              '${(nofArea.round()! ~/ 60)}h ${nofArea.round()! % 60}min',
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
                  height: h * 0.015,
                ),
                SlidableButton(
                  initialPosition: _positionB,
                  height: h * 0.045,
                  width: w,
                  buttonWidth: 125,
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                  buttonColor: Colors.blue,
                  dismissible: false,
                  label: Center(
                      child: Text('>>',
                          style: TextStyle(fontSize: 19, color: Colors.white))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '     ',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Text(
                          'CERRAR SESIÓN  ',
                          style: TextStyle(fontSize: 15, color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  onChanged: (position) {
                    setState(() {
                      if (position == SlidableButtonPosition.right) {
                        print('CERRAR SESIÓN');

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      }
                      if (position == SlidableButtonPosition.left) {
                        setState(() {
                          position = SlidableButtonPosition.right;
                        });
                      }
                    });
                  },
                ),

                ///AS
              ],
            ),
          ),
        ],
      )),
    );
  }
}
