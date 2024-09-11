import 'package:bloco_de_notas/controllers/notes_controller.dart';
import 'package:bloco_de_notas/model/note.dart';
import 'package:bloco_de_notas/screens/visualizar_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotesTile extends StatefulWidget {
  Note notes;

  NotesTile(this.notes);

  @override
  _NotesTileState createState() => _NotesTileState();
}

class _NotesTileState extends State<NotesTile> {
  late Note _notes;
  final NotesController notesController = Get.find();

  @override
  void initState() {
    super.initState();
    _notes = widget.notes;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
            child: ListTile(
              title: Text(_notes.noteName),
              subtitle: Text(_notes.noteText),
              leading: const Image(
                image: AssetImage('img/simbolo.png'),
                height: 40,
              ),
              trailing: IconButton(
                  onPressed: () {
                    notesController.deleteNote(_notes);
                    setState(() {});
                  },
                  icon: const Icon(Icons.delete)),
              onTap: () {
                Get.to(() => VisualizarPage(_notes));
              },
            ),
          );
  }
}