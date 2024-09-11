import 'dart:convert';
import 'dart:io';
import 'package:bloco_de_notas/model/note.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NotesRepository {
  final String _url = 'http://172.20.240.1:8000';

  Future<List<Note>> fetchNotes() async {
    final preferece = await SharedPreferences.getInstance();
    final token = preferece.getString('token');

    if (token != null) {
      final response = await http.get(Uri.parse('$_url/notes'),
          headers: <String, String>{HttpHeaders.authorizationHeader: token});

        if (response.statusCode == 200) {
          Map<String, dynamic> responseBody = await jsonDecode(response.body);
          List<dynamic> notesList = responseBody['note'];
          List<Note> notes =
              notesList.map((mNote) => Note.fromJson(mNote)).toList();
          return notes;
        } else {
        throw Exception('Erro ao buscar notas: ${response.body}');
      }
    }
    return throw Exception('Erro ao buscar notas');
  }

  Future<void> addNote(String noteName, String noteText) async {
    final preferece = await SharedPreferences.getInstance();
    final token = preferece.getString('token');
    final userId = preferece.getString('userId');

    final response = await http.post(
      Uri.parse('$_url/notes/add/${userId}'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode({
        'noteName': noteName,
        'noteText': noteText,
      }),
    );
    print(response.body);

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

  Future<void> editNote(String id, String noteName, String noteText, String userId, String token) async {
    final response = await http.put(
      Uri.parse('$_url/notes/${id}'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode({
        '_id': id,
        'noteName': noteName,
        'noteText': noteText,
        'userId': userId,
      }),
    );

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Erro ao editar nota: ${response.body}');
    }
  }
}
