import 'package:bloco_de_notas/model/note.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';


class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _textController = TextEditingController();
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
          controller: _nameController,
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
          controller: _textController,
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
    FocusScope.of(context).unfocus();

    if (_nameController.text.isEmpty && _textController.text.isEmpty) {
      Get.offNamed('/home');
      return;
    }

    if (_nameController.text.isEmpty) {
      String date = DateFormat('dd/MM/yyyy - kk:mm').format(DateTime.now());
      _nameController.text = date;
    }

    if (_textController.text.isEmpty) {
      _textController.text = '';
    }

    if (_formKey.currentState!.validate()) {
      Note newNote = Note(
        noteName: _nameController.text,
        noteText: _textController.text,
      );
      Get.back(result: newNote);
    }
  }
}
