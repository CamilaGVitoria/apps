
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 225,
              width: 225,
              padding: const EdgeInsets.only(right: 20, left: 20, top: 50),
              child: Image.asset('img/logo.png'),
            ),
            Container(
              height: 70,
              width: 340,
              padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
              child: TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide.none),
                  label: const Text(
                    "User name",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.lightGreen.shade300,
                ),
              ),
            ),
            Container(
              height: 70,
              width: 340,
              padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
              child: TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                  label: const Text(
                    "Password",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.lightGreen.shade300,
                ),
                obscureText: true,
              ),
            ),
            Container(
              height: 80,
              width: 190,
              padding: const EdgeInsets.only(top: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade700),
                onPressed: () {
                  Get.offNamed('/home');
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 15),
              child: TextButton(
                  onPressed: () {
                    Get.offNamed('/new_user');
                  },
                  child: Text(
                    'New User',
                    style: TextStyle(
                        color: Colors.lightGreen.shade200,
                        fontSize: 12,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.lightGreen.shade200),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
