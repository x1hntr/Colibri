import 'package:flutter/material.dart';

import '../components/pedometer.dart';
import '../components/sleep.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int? _nofSteps = 0;
  double? _nofSleep = 0;
  StepData stepData = StepData();
  SleepData sleepData = SleepData();

  Future<void> myStepData() async {
    var steps = await stepData.fetchStepData();
    var sleep = await sleepData.fetchStepData();

    setState(() {
      _nofSteps = steps;
      _nofSleep = sleep;
      print('Pasos' + _nofSteps.toString());
      print('Sueno' + _nofSleep.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    myStepData();
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
          Text(
            "Bienvenido ",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Color.fromRGBO(47, 54, 64, 1.0)),
          ),
          Container(
            height: 160,
            width: w * 0.95,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("img/box.png"), fit: BoxFit.fill),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Tu actividad de hoy:",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Color.fromRGBO(47, 54, 64, 1.0)),
          ),
          Container(
            height: 110,
            width: w * 0.95,
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
                        "Step Counter",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        _nofSteps.toString(),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 110,
            width: w * 0.95,
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
                        "Tiempo de sueño",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        (_nofSleep! ~/ 60).toStringAsFixed(0) +
                            ':' +
                            (_nofSleep! % 60).toStringAsFixed(0) +
                            ' H',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 110,
            width: w * 0.95,
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
                        "En areas verdes",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        "50 min",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
