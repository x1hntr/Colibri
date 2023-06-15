import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Image.asset("img/quito.png", height: 120)],
                  )
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
                        "20000 Pasos",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Image.asset("img/huella.png", height: 70)],
                  )
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
                        "3.5 h",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Image.asset("img/dormido.png", height: 70)],
                  )
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
                        "Tiempo ",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        "En areas verdes",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        "50 min",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Image.asset("img/arbol.png", height: 70)],
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
