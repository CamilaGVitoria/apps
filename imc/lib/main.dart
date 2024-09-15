import 'package:flutter/material.dart';
import 'package:imc/main_imc.dart';

void main() {
  runApp(MaterialApp(
    title: 'Calculo IMC',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
      useMaterial3: false,
      primaryColor: const Color.fromARGB(255, 255, 162, 193),
    ),
    home: MainIMC(),
  ));
}

