import 'package:bloco_de_notas/controllers/user_controller.dart';
import 'package:bloco_de_notas/model/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CadastroUserPage extends StatefulWidget {
  const CadastroUserPage({super.key});

  @override
  State<CadastroUserPage> createState() => _CadastroUserPageState();
}

class _CadastroUserPageState extends State<CadastroUserPage> {
  final  userNameController = TextEditingController();
  final  passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final UserController userController = Get.find();

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
              controller: userNameController,
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
              controller: passwordController,
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
              controller: confirmPasswordController,
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
    final userName = userNameController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (password != confirmPassword) {
      print('Passwords do not match!');
      return;
    }

    try {
      final addUser = User(id: '', userName: userName, password: password);

      userController.addUser(addUser);
      Get.offNamed('/');
    } catch (e) {
      print('Erro ao registrar usuário: $e');
    }
  }
}
