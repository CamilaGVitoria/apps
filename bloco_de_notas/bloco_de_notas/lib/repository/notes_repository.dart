import 'package:bloco_de_notas/model/note.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NotesRepository extends GetConnect {
  Future<List<Note>> getNotes(String noteId, String token) async {
    final path = 'http://10.1.4.175:8000/notes/$noteId';
    
    final response = await get(
      path,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.status.hasError) {
      throw Exception('Erro ao buscar notas: ${response.statusText}');
    }

    final notes =
        (response.body as List).map((note) => Note.fromJson(note)).toList();

    return notes;
  }

  Future<Note?> addNote(Note note, String token) async {
    final path = 'http://10.1.4.175:8000/notes/add';

    final response = await http.post(
      Uri.parse(path),
      body: {
        'noteName' : note.noteName,
        'noteText' : note.noteText
      },
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao adicionar nota: ${response.body}');
    }
  }

  Future<void> deleteNote(String noteId, String token) async {
    final path = 'http://10.1.4.175:8000/notes/delete/$noteId';

    final response = await http.delete(
      Uri.parse(path),
      headers: {'Authorization': 'Bearer $token'},
    );
  }
}
