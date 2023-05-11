import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
            width: 340,
            child: Column(
              children: [
                TextField(
                  style: TextStyle(
                      fontSize: 17, color: Color.fromRGBO(45, 52, 54, 1)),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: "Username",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                SizedBox(
                  height: 35,
                ),
                TextField(
                  style: TextStyle(
                      fontSize: 17, color: Color.fromRGBO(45, 52, 54, 1)),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
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
                  onPressed: () {},
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
