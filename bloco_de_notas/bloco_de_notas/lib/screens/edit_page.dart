import 'package:bloco_de_notas/controllers/notes_controller.dart';
import 'package:bloco_de_notas/model/note.dart';
import 'package:bloco_de_notas/model/user.dart';
import 'package:bloco_de_notas/repository/notes_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final NotesController _notesController = Get.put(NotesController(NotesRepository()));
  late TextEditingController _noteNameController;
  late TextEditingController _noteTextController;

  @override
  void initState() {
    super.initState();
    NotesController _notesController = Get.find();
    _noteNameController = TextEditingController();
    _noteTextController = TextEditingController();
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final noteName = Get.arguments['noteName'];
    final noteText = Get.arguments['noteText'];

    _noteNameController.text = noteName;
    _noteTextController.text = noteText;

    return Scaffold(
      backgroundColor: Colors.lightGreen.shade200,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              onPressed: () => _editNote(),
              icon: const Icon(
                Icons.check,
                color: Colors.white,
              ))
        ],
        title: TextField(
          controller: _noteNameController,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            border: InputBorder.none,
            label: Text(
              'Nome da nota',
              style: TextStyle(color: Colors.grey),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen.shade900,
      ),
      body: Form(
        key: _formKey,
        child: TextFormField(
          controller: _noteTextController,
          decoration: const InputDecoration(
            border: InputBorder.none,
            label: Text('Conteúdo da nota...'),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelStyle: TextStyle(fontSize: 15, color: Colors.grey),
            contentPadding: EdgeInsets.all(10),
          ),
        ),
      ),
    );
  }

  void _editNote() {
    final noteId = Get.arguments['noteId'];
    final userId = Get.arguments['userId'];
    final noteName = _noteNameController.text;
    final noteText = _noteTextController.text;

    _notesController
        .editNote(noteId, noteName, noteText, userId)
        .then((sucess) {
      if (sucess) {
        _notesController.fetchNotes();
        Get.offNamed('/home');
      } else {
        Get.snackbar('ERRO', 'Erro ao editar nota!',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    });
  }
}
