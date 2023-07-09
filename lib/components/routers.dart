import 'package:colibri/pages/activity_page.dart';
import 'package:colibri/pages/dashboard_page.dart';
import 'package:colibri/pages/map_page.dart';
import 'package:colibri/pages/settings_page.dart';
import 'package:flutter/material.dart';

class Routes extends StatelessWidget {
  final int index;
  const Routes({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> myList = [
      const DashboardPage(),
      const MapPage(),
      const ActivityPage(),
      const SettingsPage(),
    ];
    return myList[index];
  }
}
