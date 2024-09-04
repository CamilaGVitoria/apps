import 'package:bloco_de_notas/controllers/user_controller.dart';
import 'package:bloco_de_notas/model/user.dart';
import 'package:bloco_de_notas/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CadastroUserPage extends StatefulWidget {
  const CadastroUserPage({super.key});

  @override
  State<CadastroUserPage> createState() => _CadastroUserPageState();
}

class _CadastroUserPageState extends State<CadastroUserPage> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  final UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen.shade900,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.offNamed('/'),
            icon: const Icon(
              Icons.exit_to_app_rounded,
              color: Colors.white,
              size: 35,
            ),
          ),
        ],
        backgroundColor: Colors.lightGreen.shade900,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: const Text(
              'NEW USER',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: TextField(
              controller: _userNameController,
              decoration: InputDecoration(
                label: const Text(
                  'User name',
                  style: TextStyle(color: Colors.grey),
                ),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                filled: true,
                fillColor: Colors.lightGreen.shade300,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                  label: const Text(
                    'Password',
                    style: TextStyle(color: Colors.grey),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  filled: true,
                  fillColor: Colors.lightGreen.shade300),
                  obscureText: true,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                  label: const Text(
                    'Confirm Password',
                    style: TextStyle(color: Colors.grey),
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  filled: true,
                  fillColor: Colors.lightGreen.shade300),
                  obscureText: true,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 30),
            height: 80,
            width: 150,
            child: ElevatedButton(
              onPressed: _registerUser,
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen.shade700),
              child: const Text('Cadastrar',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  void _registerUser() async {
    String userName = _userNameController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword) {
      print('Passwords do not match!');
      return;
    }

    User newUser = User(userName: userName, password: password);

    try {
      await _userController.register(newUser);
      Get.offNamed('/');
    } catch (e) {
      print('Erro ao registrar usuário: $e');
    }
  }
}
