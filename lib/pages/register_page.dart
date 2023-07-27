import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:colibri/pages/login_page.dart';
import 'package:colibri/pages/tutorial_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController passwordTextController2 = TextEditingController();
  TextEditingController usernameTextController = TextEditingController();
  TextEditingController dateTextController = TextEditingController();
  bool? isCheckedAccept = false;
  final Uri _url = Uri.parse(
      'https://drive.google.com/file/d/1beetniLchTN5dGxBmnisQ8VMlP9xPq1V/view?usp=sharing');

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    int age = 0;

    bool _validate = false;
    final _text = TextEditingController();

    void _showDatePicker() {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1980),
        lastDate: DateTime.now(),
      );
    }

    Widget okButton = TextButton(
      child: Text("Ok"),
      onPressed: () async {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Error con contraseña"),
      content: Text("Las contraseñas no coinciden. ¡Inténtalo nuevamente!"),
      actions: [
        okButton,
      ],
    );

    AlertDialog termAlert = AlertDialog(
      title: Text("Términos y condiciones"),
      content: Text("¡Por favor acepta los términos y condiciones!"),
      actions: [
        okButton,
      ],
    );

    AlertDialog alertLength = AlertDialog(
      title: Text("Contraseña débil"),
      content: Text("¡La contraseña debe tener mínimo 6 caracteres!"),
      actions: [
        okButton,
      ],
    );

    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: w,
                    height: h * 0.32,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("img/register.png"),
                            fit: BoxFit.cover)),
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
                              fontSize: 28,
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
                          height: w * 0.035,
                        ),
                        SizedBox(
                          height: h * 0.055,
                          child: TextField(
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(45, 52, 54, 1)),
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                hintText: "Nombre usuario",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            controller: usernameTextController,
                          ),
                        ),
                        SizedBox(
                          height: w * 0.035,
                        ),
                        SizedBox(
                            height: h * 0.055,
                            child: TextField(
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(45, 52, 54, 1)),
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email),
                                  hintText: "Correo",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              controller: emailTextController,
                            )),
                        SizedBox(
                          height: w * 0.035,
                        ),
                        SizedBox(
                            height: h * 0.055,
                            child: TextField(
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(45, 52, 54, 1)),
                              obscureText: true,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  errorText: _validate
                                      ? 'Value Can\'t Be Empty'
                                      : null,
                                  hintText: "Contraseña",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              controller: passwordTextController,
                            )),
                        SizedBox(
                          height: w * 0.035,
                        ),
                        SizedBox(
                            height: h * 0.055,
                            child: TextField(
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(45, 52, 54, 1)),
                              obscureText: true,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  errorText: _validate
                                      ? 'Value Can\'t Be Empty'
                                      : null,
                                  hintText: "Confirmar contraseña",
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              controller: passwordTextController2,
                            )),
                        SizedBox(
                          height: w * 0.035,
                        ),
                        SizedBox(
                            height: h * 0.055,
                            child: TextField(
                              controller: dateTextController,
                              //editing controller of this TextField
                              decoration: InputDecoration(
                                icon: Icon(
                                    Icons.calendar_today), //icon of text field
                                hintText:
                                    "Fecha de nacimiento", //label text of field
                              ),
                              readOnly: true,
                              //set it true, so that user will not able to edit text
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1950),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2100));

                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2021-03-16
                                  setState(() {
                                    dateTextController.text =
                                        formattedDate; //set output date to TextField value.
                                  });
                                } else {}
                              },
                            )),
                        SizedBox(
                          height: w * 0.03,
                        ),
                        Row(
                          children: [
                            RichText(
                                text: TextSpan(
                                    text: 'Términos y condiciones',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.blue[600],
                                        fontSize: 17),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        print('Hola');
                                        launchUrl(_url);
                                      })),
                            Expanded(
                                child: Checkbox(
                                    value: isCheckedAccept,
                                    activeColor: Colors.blue,
                                    onChanged: (newBool) {
                                      setState(() {
                                        isCheckedAccept = newBool;
                                        print("estado A: " +
                                            isCheckedAccept.toString());
                                      });
                                    })),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: h * 0.015,
                  ),
                  Container(
                    width: 140,
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            print(passwordTextController.text);
                            print(passwordTextController2.text);
                            print('CONTRA' +
                                passwordTextController.text.length.toString());
                            if (passwordTextController.text.length >= 6) {
                              if (passwordTextController.text ==
                                  passwordTextController2.text) {
                                if (isCheckedAccept == true) {
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
                                        FirebaseFirestore.instance
                                            .collection('users');
                                    users
                                        .doc(value.user!.uid)
                                        .set({
                                          'arrive': '',
                                          'contando': false,
                                          'email': emailTextController.text,
                                          'role': 'user',
                                          'sleep': 1,
                                          'steps': 1,
                                          'steps_goal': 1,
                                          'surname':
                                              usernameTextController.text,
                                          'time': 1,
                                          'birthday': dateTextController.text
                                        })
                                        .then((value) => print("User Added"))
                                        .catchError((error) => print(
                                            "FAiled to add user: $error"));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TutorialPage()));
                                  }).onError((error, stackTrace) {
                                    _text.text.isEmpty
                                        ? _validate = true
                                        : _validate = false;
                                    print(
                                        "No paso el auth ${error.toString()}");
                                  });
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return termAlert;
                                    },
                                  );
                                }
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  },
                                );
                                print('Contrase;as no cohinciden');
                              }
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alertLength;
                                },
                              );
                            }
                          },
                          child: const Text(
                            ' Registrarse ',
                            style: TextStyle(fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                        ),
                        // Text("Registrarse con:"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: h * 0.013,
                  ),
                  RichText(
                    text: TextSpan(
                        text: "Ya tienes cuenta?",
                        style: TextStyle(color: Colors.grey[500], fontSize: 17),
                        children: [
                          TextSpan(
                              text: "  Ingresar",
                              style: TextStyle(
                                  color: Colors.blue[600],
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap =
                                    () => Get.to(() => const LoginPage())),
                        ]),
                  )
                ],
              ),
            )));
  }
}
