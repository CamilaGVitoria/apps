import 'package:bloco_de_notas/cadastro_page.dart';
import 'package:bloco_de_notas/cadastro_user_page.dart';
import 'package:bloco_de_notas/home_page.dart';
import 'package:bloco_de_notas/login_page.dart';
import 'package:bloco_de_notas/model/notes.dart';
import 'package:bloco_de_notas/visualizar_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bloco de Notas',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/new_user', page: () => CadastroUserPage()),
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(name: '/new_note', page: () => CadastroPage()),
        GetPage(name: '/note', page: () => VisualizarPage(Get.arguments as Notes)),

      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen.shade900),
        useMaterial3: true,
      ),
  );
  }
}

  