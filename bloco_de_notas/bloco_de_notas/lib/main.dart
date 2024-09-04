import 'package:bloco_de_notas/controllers/notes_controller.dart';
import 'package:bloco_de_notas/screens/cadastro_page.dart';
import 'package:bloco_de_notas/screens/cadastro_user_page.dart';
import 'package:bloco_de_notas/screens/home_page.dart';
import 'package:bloco_de_notas/screens/login_page.dart';
import 'package:bloco_de_notas/model/note.dart';
import 'package:bloco_de_notas/screens/visualizar_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  Get.put(NotesController());
  GetStorage.init();
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
        GetPage(name: '/note', page: () => VisualizarPage(Get.arguments as Note)),

      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen.shade900),
        useMaterial3: true,
      ),
  );
  }
}

  