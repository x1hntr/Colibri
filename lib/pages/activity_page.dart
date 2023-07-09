import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../components/pedometer.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  int? _nofSteps = 0;
  StepData stepData = StepData();
  int steps = 0;
  Future<void> myStepData() async {
    steps = (await stepData.fetchStepData())!;
    setState(() {
      _nofSteps = steps;
    });
  }

  @override
  void initState() {
    super.initState();
    myStepData();
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 10,
        ),
        Text(
          "Actividad Fisica",
          style: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(99, 110, 114, 1.0),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: SfLinearGauge(
            showTicks: false,
            showLabels: false,
            animateAxis: true,
            axisTrackStyle: LinearAxisTrackStyle(
              thickness: 22,
              edgeStyle: LinearEdgeStyle.bothCurve,
              borderWidth: 1,
              borderColor: brightness == Brightness.dark
                  ? const Color(0xff898989)
                  : Colors.grey[350],
              color: brightness == Brightness.dark
                  ? Colors.transparent
                  : Colors.grey[350],
            ),
            barPointers: <LinearBarPointer>[
              LinearBarPointer(
                  value: 100 * (_nofSteps!.toDouble() / 10000),
                  thickness: 20,
                  edgeStyle: LinearEdgeStyle.bothCurve,
                  color: Colors.blue),
            ],
          ),
        ),
        Container(
          height: 150,
          width: w * 0.95,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("img/box5.png"), fit: BoxFit.fill),
          ),
          child: SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                  showLabels: false,
                  showTicks: false,
                  startAngle: 270,
                  endAngle: 270,
                  radiusFactor: 0.8,
                  axisLineStyle: const AxisLineStyle(
                      thicknessUnit: GaugeSizeUnit.factor, thickness: 0.15),
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
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(' / 10000',
                                style: TextStyle(
                                    fontFamily: 'Times', color: Colors.white)),
                          ],
                        )),
                  ],
                  pointers: <GaugePointer>[
                    RangePointer(
                        value: 100 * (_nofSteps!.toDouble() / 10000),
                        enableAnimation: true,
                        animationDuration: 1200,
                        sizeUnit: GaugeSizeUnit.factor,
                        gradient: SweepGradient(colors: <Color>[
                          Colors.white,
                          Colors.white,

                          /*  Color(0xFF6A6EF6),
                          Color(0xFFDB82F5)*/
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
        SizedBox(
          height: 5,
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
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      "20000 Pasos",
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
