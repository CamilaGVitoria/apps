import 'package:bloco_de_notas/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Bloco de Notas',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen.shade900),
      useMaterial3: true,
    ),
    home: LoginPage(),
  ));
}

