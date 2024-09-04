import 'package:bloco_de_notas/controllers/notes_controller.dart';
import 'package:bloco_de_notas/model/note.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bloco_de_notas/screens/visualizar_page.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final NotesController notesController = Get.find();

  @override
  void initState() {
    super.initState();
    notesController.fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
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
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
        itemCount: notesController.notesList.length,
        itemBuilder: (context, index) {
          final note = notesController.notesList[index];
          return Card(
            child: ListTile(
              title: Text(note.noteName ?? ''),
              subtitle: Text(note.noteText ?? ''),
              leading: const Image(
                image: AssetImage('img/simbolo.png'),
                height: 40,
              ),
              trailing: IconButton(
                  onPressed: () {
                    notesController.deleteNote(note.id!);
                    setState(() {});
                  },
                  icon: const Icon(Icons.delete)),
              onTap: () {
                Get.to(() => VisualizarPage(note));
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen.shade900,
        onPressed: () async {
          try {
            final newNote = await Get.toNamed('/new_note');

            if (newNote != null && newNote is Note) {
              await notesController.addNote(newNote);
            }
            setState(() {});
          } catch (e) {
            print('Error ${e.toString()}');
          }
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
