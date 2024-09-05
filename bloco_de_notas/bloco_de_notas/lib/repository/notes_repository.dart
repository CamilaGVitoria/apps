import 'dart:convert';
import 'package:bloco_de_notas/model/note.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NotesRepository extends GetConnect {
  Future<List<Note>> getNotes(String userId, String token) async {
    final path = 'http://10.1.6.129:8000/notes';

    final response = await http.get(
      Uri.parse(path),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao buscar notas: ${response.body}');
    }

    final List<dynamic> jsonData = json.decode(response.body);
    final notes = jsonData.map((note) => Note.fromJson(note)).toList();

    return notes.cast<Note>();
  }

  Future<Note?> addNote(Note note, String token) async {
    final path = 'http://10.1.6.129:8000/notes/add';

    final response = await http.post(
      Uri.parse(path),
      body: {
        'noteName': note.noteName,
        'noteText': note.noteText,
        'userId': note.userId
      },
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao adicionar nota: ${response.body}');
    }

    final noteJson = json.decode(response.body);
    return Note.fromJson(noteJson);
  }

  Future<void> deleteNote(String noteId, String token) async {
    final path = 'http://10.1.6.129:8000/notes/delete/$noteId';

    final response = await http.delete(
      Uri.parse(path),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao deletar nota: ${response.body}');
    }
  }
}
