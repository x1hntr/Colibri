import 'package:colibri/pages/colibri_page.dart';
import 'package:flutter/material.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key});

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  int _steps = 0;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("img/background.png"), fit: BoxFit.fill),
      ),
      child: Column(children: [
        SizedBox(
          height: h * 0.12,
        ),
        Center(
          child: Stepper(
            controlsBuilder: (BuildContext context, ControlsDetails details) {
              return Row(
                children: <Widget>[
                  TextButton(
                      onPressed: () {
                        if (_steps == 0) {
                          setState(() {
                            _steps = 0;
                          });
                        } else {
                          setState(() {
                            _steps -= 1;
                          });
                        }
                      },
                      child: const Text('Anterior')),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          if (_steps == 6) {
                            setState(() {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                  (route) => false);
                            });
                          } else {
                            setState(() {
                              _steps += 1;
                            });
                          }
                        });
                      },
                      child: const Text('Siguiente')),
                ],
              );
            },
            steps: [
              Step(
                isActive: _steps == 0,
                title:
                    const Text('Paso 1', style: TextStyle(color: Colors.blue)),
                content: Image(
                    image: AssetImage("img/tutorial1.png"), fit: BoxFit.fill),
              ),
              Step(
                isActive: _steps == 1,
                title:
                    const Text('Paso 2', style: TextStyle(color: Colors.blue)),
                content: Image(
                    image: AssetImage("img/tutorial2.png"), fit: BoxFit.fill),
              ),
              Step(
                isActive: _steps == 2,
                title:
                    const Text('Paso 3', style: TextStyle(color: Colors.blue)),
                content: Image(
                    image: AssetImage("img/tutorial3.png"), fit: BoxFit.fill),
              ),
              Step(
                isActive: _steps == 3,
                title:
                    const Text('Paso 4', style: TextStyle(color: Colors.blue)),
                content: Image(
                    image: AssetImage("img/tutorial4.png"), fit: BoxFit.fill),
              ),
              Step(
                isActive: _steps == 4,
                title:
                    const Text('Paso 5', style: TextStyle(color: Colors.blue)),
                content: Image(
                    image: AssetImage("img/tutorial5.png"), fit: BoxFit.fill),
              ),
              Step(
                isActive: _steps == 4,
                title:
                    const Text('Paso 6', style: TextStyle(color: Colors.blue)),
                content: Image(
                    image: AssetImage("img/tutorial6.png"), fit: BoxFit.fill),
              ),
              Step(
                isActive: _steps == 4,
                title:
                    const Text('Paso 7', style: TextStyle(color: Colors.blue)),
                content: Image(
                    image: AssetImage("img/tutorial7.png"), fit: BoxFit.fill),
              ),
            ],
            onStepTapped: (int index) {
              setState(() {
                _steps = index;
              });
            },
            currentStep: _steps,
          ),
        )
      ]),
    ));
  }
}
