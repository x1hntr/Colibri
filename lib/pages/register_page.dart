import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colibri/pages/colibri_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController usernameTextController = TextEditingController();
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
                    image: AssetImage("img/register.png"), fit: BoxFit.cover)),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            width: w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "BIENVENIDO!",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(63, 154, 242, 1)),
                ),
                Text(
                  "Ingresa tus datos para crear tu cuenta",
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
                      prefixIcon: Icon(Icons.person),
                      hintText: "Username",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                  controller: usernameTextController,
                ),
                SizedBox(
                  height: 25,
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
                  height: 25,
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
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
          Container(
            width: 140,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: emailTextController.text,
                            password: passwordTextController.text)
                        .then((value) {
                      print("UID");

                      print(value.user!.uid);
                      print("Usuario");
                      print(value.user!);

                      CollectionReference users =
                          FirebaseFirestore.instance.collection('users');
                      users
                          .doc(value.user!.uid)
                          .set({
                            'name': usernameTextController.text,
                            'surname': usernameTextController.text,
                            'email': emailTextController.text,
                            'role': 'user'
                          })
                          .then((value) => print("USer Added"))
                          .catchError(
                              (error) => print("FAiled to add user: $error"));

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }).onError((error, stackTrace) {
                      print("No paso el auth ${error.toString()}");
                    });
                  },
                  child: const Text(
                    ' Registrarse ',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0))),
                ),
                Text("Registrarse con:"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
