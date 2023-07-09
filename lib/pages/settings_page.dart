import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colibri/pages/colibri_page.dart';
import 'package:colibri/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slidable_button/slidable_button.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController usernameTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var _positionB = SlidableButtonPosition.left;

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    Widget okButton = TextButton(
      child: Text("Si"),
      onPressed: () async {
        await FirebaseAuth.instance.signOut();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false);
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => HomePage()));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Cerrar Sesión"),
      content: Text("¿Estas seguro que quieres cerrar sesión?"),
      actions: [
        okButton,
        cancelButton,
      ],
    );

    // show the dialog

    _logout() async {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false);
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        "MI RANKING DE HOY:",
                        style: TextStyle(color: Colors.blue[600]),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[200],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    child: Container(
                      child: Image.asset("img/ColibriOne.png"),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 30,
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        "EDITAR INFORMACIÓN BÁSICA",
                        style: TextStyle(color: Colors.blue[600]),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[200],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                      height: 45,
                      child: TextField(
                        style: TextStyle(
                            fontSize: 17, color: Color.fromRGBO(45, 52, 54, 1)),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: "Username",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        controller: usernameTextController,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 45,
                    child: TextField(
                      style: TextStyle(
                          fontSize: 15, color: Color.fromRGBO(45, 52, 54, 1)),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      controller: emailTextController,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                      height: 45,
                      child: TextField(
                        style: TextStyle(
                            fontSize: 17, color: Color.fromRGBO(45, 52, 54, 1)),
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            hintText: "Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                        controller: passwordTextController,
                      )),
                  SizedBox(
                    height: 5,
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

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      }).onError((error, stackTrace) {
                        print("No paso el auth ${error.toString()}");
                      });
                    },
                    child: const Text(
                      ' GUARDAR ',
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        "INFORMACIÓN GENERAL",
                        style: TextStyle(color: Colors.blue[600]),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[200],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  SizedBox(
                      height: 45,
                      width: w,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        label: Text(
                          ' ¿Como usar Colibri? ',
                        ),
                        icon: Icon(Icons.info),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 30,
                    child: Container(
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        "PREFERENCIAS",
                        style: TextStyle(color: Colors.blue[600]),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[200],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SlidableButton(
                    initialPosition: _positionB,
                    height: 45,
                    width: w,
                    buttonWidth: 125,
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    buttonColor: Colors.blue,
                    dismissible: false,
                    label: Center(
                        child: Text('>>',
                            style:
                                TextStyle(fontSize: 19, color: Colors.white))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '     ',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          Text(
                            'CERRAR SESIÓN  ',
                            style: TextStyle(fontSize: 15, color: Colors.blue),
                          ),
                        ],
                      ),
                    ),
                    onChanged: (position) {
                      setState(() {
                        if (position == SlidableButtonPosition.right) {
                          print('CERRAR SESIÓN');

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        }
                        if (position == SlidableButtonPosition.left) {}
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        )));
  }
}
