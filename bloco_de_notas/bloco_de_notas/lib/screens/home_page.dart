import 'package:bloco_de_notas/controllers/notes_controller.dart';
import 'package:bloco_de_notas/model/note.dart';
import 'package:bloco_de_notas/repository/notes_repository.dart';
import 'package:bloco_de_notas/widgets/notes_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bloco_de_notas/screens/visualizar_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final NotesController notesController = Get.put(
      NotesController(NotesRepository()),
    );

    notesController.fetchNotes();

    return Scaffold(
      backgroundColor: Colors.lightGreen.shade200,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Get.offNamed('/');
            },
            icon: const Icon(
              Icons.exit_to_app_rounded,
              color: Colors.white,
            ),
          ),
        ],
        title: const Text(
          'Notes',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightGreen.shade900,
      ),
      body: Obx(() {
        if (notesController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white, 
            ),
          );
        }

        if (notesController.notes.isEmpty) {
          return const Center(
            child: Text(
              'Sem notas!',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
          itemCount: notesController.notes.length,
          itemBuilder: (context, index) {
            Note note = notesController.notes[index];
            return NotesTile(note);
          },
        );
      }),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.lightGreen.shade900,
        onPressed: () async => Get.toNamed('/new_note'),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),

      ),
    );
  }
}
