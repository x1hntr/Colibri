import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colibri/pages/colibri_page.dart';
import 'package:colibri/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slidable_button/slidable_button.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController usernameTextController = TextEditingController();
  final Uri _url = Uri.parse(
      'https://drive.google.com/file/d/1beetniLchTN5dGxBmnisQ8VMlP9xPq1V/view?usp=sharing');
  final Uri _url2 = Uri.parse(
      'https://drive.google.com/file/d/18Exfe4S2jUc67tN7LdnnWDNIjiqYCH0W/view?usp=sharing');

  @override
  Widget build(BuildContext context) {
    var _positionB = SlidableButtonPosition.left;

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    initState() {
      print(w.toString());
    }

    Widget cancelButton = TextButton(
      child: Text("Cancelar"),
      onPressed: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => HomePage()));
      },
    );

    Widget okButton = TextButton(
      child: Text("Si"),
      onPressed: () async {
        await FirebaseAuth.instance.signOut();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false);
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

    setData(surname) async {
      try {
        final updateSurname = {
          "surname": surname,
        };
        final value = FirebaseAuth.instance.currentUser;
        final uidUser = value!.uid;
        final datos = FirebaseFirestore.instance;
        datos.collection('users').doc(uidUser).update(updateSurname);
      } catch (e) {
        print("$e");
      }
    }
    // show the dialog

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: w * 0.025,
            ),
            Container(
              height: h * 0.155,
              width: w * 0.325,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("img/profile.png"), fit: BoxFit.fill),
              ),
            ),
            SizedBox(
              height: w * 0.025,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: w * 0.03,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: w * 0.03,
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              width: w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: w * 0.075,
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
                    height: w * 0.03,
                  ),
                  SizedBox(
                      height: h * 0.045,
                      width: w,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          launchUrl(_url2);
                          /*Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      TutorialPage()));*/
                          //launchUrl(_url);
                        },
                        label: Text(
                          ' ¿Como usar Colibri? ',
                        ),
                        icon: Icon(Icons.info),
                      )),
                  SizedBox(
                    height: w * 0.015,
                  ),
                  SizedBox(
                      height: h * 0.045,
                      width: w,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          print('Hola');
                          launchUrl(_url);
                        },
                        label: Text(
                          ' Terminos y condiciones ',
                        ),
                        icon: Icon(Icons.domain_verification_outlined),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: w * 0.03,
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
                    height: w * 0.075,
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
                    height: h * 0.045,
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
                        if (position == SlidableButtonPosition.left) {
                          setState(() {
                            position = SlidableButtonPosition.right;
                          });
                        }
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
