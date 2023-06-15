import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colibri/pages/colibri_page.dart';
import 'package:colibri/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: w,
            height: h * 0.36,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("img/login.png"), fit: BoxFit.cover)),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            width: w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "HOLA DE NUEVO!",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(63, 154, 242, 1)),
                ),
                Text(
                  "Ingresa tus datos para entrar a tu cuenta",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  style: TextStyle(
                      fontSize: 17, color: Color.fromRGBO(45, 52, 54, 1)),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  controller: emailTextController,
                ),
                SizedBox(
                  height: 35,
                ),
                TextField(
                  style: TextStyle(
                      fontSize: 17, color: Color.fromRGBO(45, 52, 54, 1)),
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  controller: passwordTextController,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Olvide mi contraseña",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(129, 129, 129, 1),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
          Container(
            height: 45,
            width: 120,
            child: ElevatedButton(
              onPressed: () async {
                try {
                  final value = await FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: emailTextController.text,
                          password: passwordTextController.text);
                  final uidUser = value.user!.uid;

                  print("UID");
                  print(uidUser);
                  CollectionReference users =
                      FirebaseFirestore.instance.collection('users');
                  DocumentSnapshot documentSnapshot =
                      await users.doc(uidUser).get();
                  if (documentSnapshot.exists) {
                    dynamic userDoc = documentSnapshot.data();
                    print(userDoc.toString());
                    if (userDoc!["role"] == "user") {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }
                  } else {
                    print("Error");
                  }
                } catch (e) {
                  print("$e");
                }
              },
              child: const Text(
                ' Ingresar ',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0))),
            ),
          ),
          SizedBox(
            height: w * 0.15,
          ),
          RichText(
            text: TextSpan(
                text: "No tienes cuenta?",
                style: TextStyle(color: Colors.grey[500], fontSize: 18),
                children: [
                  TextSpan(
                      text: "  Regístrate",
                      style: TextStyle(
                          color: Colors.blue[600],
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(() => const RegisterPage())),
                ]),
          )
        ],
      ),
    );
  }
}
