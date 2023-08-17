import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colibri/pages/admin_page.dart';
import 'package:colibri/pages/colibri_page.dart';
import 'package:colibri/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  String? role;

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

  Future<Widget> getRootPage() async {
    try {
      final value = FirebaseAuth.instance.currentUser;
      final uidUser = value!.uid;
      print(uidUser.toString());
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      DocumentSnapshot documentSnapshot = await users.doc(uidUser).get();
      if (documentSnapshot.exists) {
        dynamic userDoc = documentSnapshot.data();
        role = userDoc!['role'];
      } else {
        print("ErrorBDD");
      }
      if (value == null) {
        return LoginPage();
      }
      if (role == 'admin') {
        return AdminPage();
      }
      return HomePage();
    } catch (e) {
      return LoginPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset('img/splash.png', fit: BoxFit.cover);
  }
}
