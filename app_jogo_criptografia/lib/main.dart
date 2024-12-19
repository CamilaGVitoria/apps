import 'package:flutter/material.dart';
import 'package:app_jogo_criptografia/home_page.dart';

void main() {
  runApp(MaterialApp(
    title: 'Jogo Criptografia',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrangeAccent),
      useMaterial3: false,
      primaryColor: Colors.orange,
    ),
    home: HomePage(),
  ));
}
