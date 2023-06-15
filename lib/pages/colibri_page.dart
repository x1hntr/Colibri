import 'package:colibri/components/bottom_nav.dart';
import 'package:colibri/components/routers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  BottomNavigation? myBNB;
  @override
  void initState() {
    // TODO: implement initState
    myBNB = BottomNavigation(currentIndex: (i) {
      setState(() {
        index = i;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        toolbarHeight: 60,
        centerTitle: false,
        leadingWidth: 100,
        leading: Text(DateFormat.MMMEd().format(DateTime.now())),
        actions: [
          Container(width: 90, child: Image.asset("img/IconHome.png")),
          SizedBox(
            width: 15,
            height: 10,
          ),
        ],
      ),
      bottomNavigationBar: myBNB,
      body: Routes(index: index),
    );
  }
}
