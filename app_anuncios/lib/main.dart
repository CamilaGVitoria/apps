import 'package:flutter/material.dart';
import 'package:app_anuncios/home_page.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Anúncios",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),  
      home: HomePage(), 
    ),
  );
}
