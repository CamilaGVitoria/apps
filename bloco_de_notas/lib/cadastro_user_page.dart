import 'package:bloco_de_notas/login_page.dart';
import 'package:flutter/material.dart';

class CadastroUserPage extends StatefulWidget {
  const CadastroUserPage({super.key});

  @override
  State<CadastroUserPage> createState() => _CadastroUserPageState();
}

class _CadastroUserPageState extends State<CadastroUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen.shade900,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            ),
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
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              ),
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
}
