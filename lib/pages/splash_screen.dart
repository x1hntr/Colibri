import 'dart:async';

import 'package:colibri/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'colibri_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Widget _rootPage = LoginPage();

  _SplashScreenState() {
    Timer(const Duration(milliseconds: 2500), () {
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => _rootPage),
            (route) => false);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRootPage().then((Widget page) {
      setState(() {
        _rootPage = page;
        print('paso');
      });
    });
  }

  Future<Widget> getRootPage() async =>
      await FirebaseAuth.instance.currentUser == null
          ? LoginPage()
          : HomePage();

  @override
  Widget build(BuildContext context) {
    return Image.asset('img/splash.png', fit: BoxFit.cover);
  }
}
