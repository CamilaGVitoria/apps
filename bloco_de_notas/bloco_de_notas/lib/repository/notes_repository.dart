import 'package:bloco_de_notas/model/note.dart';
import 'package:get/get.dart';

class NotesRepository extends GetConnect {
  Future<List<Note>> getNotes(String token) async {
    final path = 'http://192.168.1.13:8000/notes';
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
    final path = 'http://192.168.1.13:8000/notes/add';

    final response = await post(
      path,
      note.toJson(),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.status.hasError) {
      throw Exception('Erro ao adicionar nota: ${response.statusText}');
    }

    return Note.fromJson(response.body);
  }

  Future<void> deleteNote(String noteId, String token) async {
    final path = 'http://192.168.1.13:8000/notes/delete';

    final response = await delete(
      path,
      headers: {'Authorization': 'Bearer $token'},
    );
  }
}
