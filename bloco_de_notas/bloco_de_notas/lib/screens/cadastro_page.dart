import 'package:bloco_de_notas/controllers/notes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final NotesController notesController = Get.find();
  final noteNameController = TextEditingController();
  final noteTextController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen.shade200,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              onPressed: () => _saveNote(),
              icon: const Icon(
                Icons.check,
                color: Colors.white,
              ))
        ],
        title: TextField(
          controller: noteNameController,
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
          controller: noteTextController,
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

  void _saveNote() {
    if (noteNameController.text.isEmpty) {
      String date = DateFormat('dd/MM/yyyy - kk:mm').format(DateTime.now());
      noteNameController.text = date;
    }else if(noteTextController.text.isEmpty || noteTextController.text == ""){
      Get.snackbar("Erro", "Texto da nota obrigatório",
      backgroundColor: Colors.red, colorText: Colors.white);
      
    }else{
      final noteName = noteNameController.text;
      final noteText = noteTextController.text;

      notesController.addNote(noteName, noteText).then((sucess) {
        if (sucess) {
          notesController.fetchNotes();
          Get.offNamed('/home');
        } else {
          Get.snackbar('ERRO', 'Erro ao adicionar nota!',
          backgroundColor: Colors.red, colorText: Colors.white);
        }
      });
    }

    
  }
}
