import 'package:bloco_de_notas/cadastro_page.dart';
import 'package:bloco_de_notas/login_page.dart';
import 'package:bloco_de_notas/model/notes.dart';
import 'package:bloco_de_notas/visualizar_page.dart';
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
      backgroundColor: Colors.lightGreen.shade200,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            ),
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
        itemCount: _list.length,
        itemBuilder: (context, index) {
          Notes _notes = _list[index];
          return Card(
              child: ListTile(
                  title: Text(_notes.name),
                  subtitle: Text(_notes.text),
                  leading: const Image(
                    image: AssetImage('img/simbolo.png'),
                    height: 40,
                  ),
                  trailing: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.delete)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VisualizarPage(_notes)),
                    );
                  }));
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen.shade900,
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
