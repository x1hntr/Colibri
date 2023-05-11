import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Form(
      key: formKey,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              width: w,
              height: h,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("img/login2.png"), fit: BoxFit.cover)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 300,
                  ),
                  const Text(
                    "Email:",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Color.fromRGBO(29, 141, 246, 1)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      style: TextStyle(
                          fontSize: 17, color: Color.fromRGBO(45, 52, 54, 1)),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: "usuario@correo.com",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese el Email';
                        }
                        if (!value.contains('@')) {
                          return 'Ingrese un correo valido';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Contraseña:",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Color.fromRGBO(29, 141, 246, 1)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      style: TextStyle(
                          fontSize: 17, color: Color.fromRGBO(45, 52, 54, 1)),
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: "******************",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese la Contraseña';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextButton(
                    onPressed: () => {},
                    child: Text(
                      "Olvide mi contraseña",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromRGBO(129, 129, 129, 1),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        const SnackBar(content: Text("Procesando"));
                      }
                    },
                    child: const Text(
                      ' Ingresar ',
                      style: TextStyle(fontSize: 17),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0))),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "No tengo cuenta",
                    style: TextStyle(
                        fontSize: 15, color: Color.fromRGBO(129, 129, 129, 1)),
                  ),
                ],
              ),
            ),
            Container()
          ],
        ),
      ),
    );
  }
}
