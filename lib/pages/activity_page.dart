import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../components/health.dart';
import '../components/number_picker.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  int? _nofSteps = 0;
  double? _nofSleep = 0;
  double? _calories = 0;
  TextEditingController stepsTextController = TextEditingController();
  StepData stepData = StepData();
  SleepData sleepData = SleepData();
  CalData caloriesData = CalData();
  int porcentaje = 0;
  int _currentValue = 3;
  var age = 25;
  int? steps_goal = 100;
  String goal = '';
  String percent = '';

  Future<void> myStepData() async {
    var requested = (await stepData.initRequest());
    var steps = (await stepData.fetchStepData(requested))!;
    var sleep = (await sleepData.fetchStepData(requested))!;
    var calories = (await caloriesData.fetchStepData(requested))!;

    setState(() {
      _nofSteps = steps;
      _nofSleep = sleep;
      _calories = calories;

      print('Sueno:' + _nofSleep.toString());
      print('Pasos:' + _nofSteps.toString());
      setData(_nofSteps, _nofSleep);
      print((_nofSteps).toString());
      if (_nofSteps! / steps_goal! < 1) {
        setState(() {
          percent = ((_nofSteps! / steps_goal!) * 100).round().toString() + '%';
        });
      } else {
        percent = 'Completado';
      }
    });
  }

  setData(nofSteps, nofSleep) async {
    try {
      final arrive = {
        "sleep": nofSleep,
        "steps": nofSteps,
      };
      final value = FirebaseAuth.instance.currentUser;
      final uidUser = value!.uid;
      final datos = FirebaseFirestore.instance;
      datos.collection('users').doc(uidUser).update(arrive);
    } catch (e) {
      print("$e");
    }
  }

  setSteps(steps_goal) async {
    try {
      final arrive = {
        "steps_goal": steps_goal!,
      };
      final value = FirebaseAuth.instance.currentUser;
      final uidUser = value!.uid;
      final datos = FirebaseFirestore.instance;
      datos.collection('users').doc(uidUser).update(arrive);
    } catch (e) {
      print("$e");
    }
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
        steps_goal = userDoc!['steps_goal'];
        print('HOLAAAA');
        goal = steps_goal.toString();

        setState(() {});
      } else {
        print("ErrorBDD");
      }
    } catch (e) {
      print("$e");
    }
  }

  @override
  void initState() {
    super.initState();
    myStepData();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(children: [
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          width: w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 30,
                child: Container(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    "ACTIVIDAD FÍSICA",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue[600],
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[200],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                child: Container(
                  height: 220,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("img/box5.png"), fit: BoxFit.fill),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 185,
                        child: SfRadialGauge(
                          axes: <RadialAxis>[
                            RadialAxis(
                                showLabels: false,
                                showTicks: false,
                                startAngle: 270,
                                endAngle: 270,
                                radiusFactor: 0.8,
                                axisLineStyle: const AxisLineStyle(
                                    thicknessUnit: GaugeSizeUnit.factor,
                                    thickness: 0.15),
                                annotations: <GaugeAnnotation>[
                                  GaugeAnnotation(
                                      angle: 180,
                                      widget: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          /* Image.asset("img/colibri.png"),*/
                                          Text(
                                            _nofSteps.toString(),
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(' / 10000',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      )),
                                ],
                                pointers: <GaugePointer>[
                                  RangePointer(
                                      value:
                                          100 * (_nofSteps!.toDouble() / 10000),
                                      enableAnimation: true,
                                      animationDuration: 1200,
                                      sizeUnit: GaugeSizeUnit.factor,
                                      gradient: SweepGradient(colors: <Color>[
                                        Colors.white,
                                        Colors.white,
                                      ], stops: <double>[
                                        0.25,
                                        0.75
                                      ]),
                                      color: /*Color(0xFF00A8B5),*/ Colors.blue,
                                      width: 0.15),
                                ]),
                          ],
                        ),
                      ),
                      Text(
                        'PASOS',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 30,
                child: Container(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    "MIS OBJETIVOS",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.blue[600],
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[200],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 110,
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
                            "Contador de pasos",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            goal,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            percent,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      child: ElevatedButton.icon(
                    onPressed: () {
                      showMaterialNumberPicker(
                        context: context,
                        title: 'Escoge tu objetivo',
                        maxNumber: 10000,
                        minNumber: 100,
                        selectedNumber: _currentValue,
                        onChanged: (value) =>
                            setState(() => _currentValue = value),
                        onConfirmed: () {
                          print(_currentValue.toString());
                          setSteps(_currentValue);
                          setState(() {
                            goal = _currentValue.toString();
                          });
                          if (_nofSteps! / _currentValue < 1) {
                            setState(() {
                              percent = ((_nofSteps! / _currentValue) * 100)
                                      .round()
                                      .toString() +
                                  '%';
                            });
                          } else {
                            percent = 'Completado';
                          }
                        },
                      );
                    },
                    label: Text(
                      'EDITAR',
                    ),
                    icon: Icon(Icons.edit_document),
                  )),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 110,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("img/box3.png"), fit: BoxFit.fill),
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
                            "Contador de calorias",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
                          ),
                          Text(
                            _calories!.round().toString() + ' Cal',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20),
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
        SizedBox(
          height: 5,
        ),
      ])),
    );
  }
}
