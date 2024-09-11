import 'package:bloco_de_notas/model/note.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VisualizarPage extends StatefulWidget {
  late Note note;

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
            IconButton(
                onPressed: () {
                  Get.toNamed('/edit_note', arguments: {
                    'noteId': widget.note.id,
                    'noteName': widget.note.noteName,
                    'noteText': widget.note.noteText,
                    'userId': widget.note.userId,
                  });
                },
                icon: const Icon(Icons.edit))
          ],
          title: Text(
            widget.note.noteName,
            style: const TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.lightGreen.shade900,
        ),
        body: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            Note _notes = widget.note;

            return Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                _notes.noteText,
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
