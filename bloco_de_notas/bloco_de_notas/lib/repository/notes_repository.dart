import 'dart:convert';
import 'package:bloco_de_notas/model/note.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NotesRepository{
  final String _url = 'http://10.1.6.59:8000';

  Future<List<Note>> fetchNotes() async {
    final preferece = await SharedPreferences.getInstance();
    final token = preferece.getString('token');

    final response = await http.get(
      Uri.parse('$_url/notes'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((note) => Note.fromJson(note)).toList();
    } else {
      throw Exception('Erro ao buscar notas: ${response.body}');
    }
  }

  Future<void> addNote(Note note) async {
    final preferece = await SharedPreferences.getInstance();
    final token = preferece.getString('token');

    final response = await http.post(
      Uri.parse('$_url/notes/add/${note.userId}'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode({
        'noteName': note.noteName,
        'noteText': note.noteText,
        'userId': note.userId
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao adicionar nota: ${response.body}');
    }
  }

  Future<void> deleteNote(Note note, String token) async {
    final response = await http.delete(
      Uri.parse('$_url/notes/${note.id}'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao deletar nota: ${response.body}');
    }

    return;
  }

  Future<void> editNote(Note note, String token) async {
    final response = await http.put(
      Uri.parse('$_url/notes/${note.id}'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode({
        'id': note.id,
        'noteName': note.noteName,
        'noteText': note.noteText,
        'userId': note.userId,
      }),
    );

    if (response.statusCode == 201) {
      return;
    } else {
      throw Exception('Erro ao editar nota: ${response.body}');
    }
  }
}
