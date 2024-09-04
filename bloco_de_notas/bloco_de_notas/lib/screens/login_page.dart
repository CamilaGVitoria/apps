import 'package:bloco_de_notas/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final UserRepository userRepository = UserRepository();

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
                controller: _userNameController,
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
                controller: _passwordController,
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
                  _login();
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

  Future<void> _login() async {
    String userName = _userNameController.text;
    String password = _passwordController.text;

    try {
      final token = await userRepository.loginUser(userName, password);

      if (token != null) {
        final storage = GetStorage();
        storage.write('token', token);

        Get.offNamed('/home');
      } else {
        Get.snackbar(
          'Erro',
          'Falha ao fazer login',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Erro ao fazer login:',
        '${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      print('Erro ao fazer login: $e');
    }
  }
}
