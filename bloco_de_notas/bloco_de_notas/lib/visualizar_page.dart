import "package:bloco_de_notas/model/notes.dart";
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class VisualizarPage extends StatefulWidget {
  late Notes note;

  VisualizarPage(this.note);

  @override
  State<VisualizarPage> createState() => _VisualizarPageState();
}

class _VisualizarPageState extends State<VisualizarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightGreen.shade200,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
          ],
          title: Text(
            widget.note.name,
            style: const TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.lightGreen.shade900,
        ),
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            Notes _notes = widget.note;

            return Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                _notes.text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            );
          },
        ));
  }
}