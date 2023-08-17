import 'package:colibri/pages/login_page.dart';
import 'package:colibri/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    String? value;
    // set up the AlertDialog
    Widget okButton = TextButton(
      child: Text("Ok"),
      onPressed: () async {
        FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailTextController.text);
        Navigator.of(context).pop();

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Recuperar contraseña"),
      content: Text(
          "Procedeceremos a enviar un enlace de recuperacion de contraseña a tu correo electrónico, revisa tu bandeja de entrada"),
      actions: [
        okButton,
      ],
    );

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: w,
                height: h * 0.36,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("img/reset.png"), fit: BoxFit.cover)),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                width: w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Olvidaste tu contraseña",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(63, 154, 242, 1)),
                    ),
                    Text(
                      "Por favor ingresa el correo con el cual te registraste",
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Text is empty';
                        }
                        return null;
                      },
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
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(),
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
                width: 140,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    } catch (e) {
                      print("Aqui va el error $e");
                    }
                  },
                  child: const Text(
                    ' Restablecer',
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
        ));
  }
}
