import 'package:bloco_de_notas/cadastro_page.dart';
import 'package:bloco_de_notas/model/notes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  List<Notes> _list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notas',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 10, right: 5, left: 5),
        itemCount: _list.length,
        itemBuilder: (context, index) {
          Notes _notes = _list[index];
          return Card(
            child: ListTile(
              title: Text(_notes.name),
              subtitle: Text(_notes.text),
              leading: const Icon(Icons.notes_rounded, size: 50,),
              trailing: Icon(Icons.more_vert_rounded),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
          try {
            Notes newNote = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CadastroPage(),
              ),
            );
            setState(() {
              _list.add(newNote);
            });
          } catch (e) {
            print('Error ${e.toString()}');
          }
          ;
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
