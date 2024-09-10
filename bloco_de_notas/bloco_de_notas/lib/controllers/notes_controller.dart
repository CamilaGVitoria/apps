import 'package:bloco_de_notas/model/note.dart';
import 'package:bloco_de_notas/repository/notes_repository.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesController extends GetxController {
  final NotesRepository _notesRepository;
  NotesController(this._notesRepository);

  var notes = <Note>[].obs;
  var hasError = false.obs;
  var isLoading = false.obs;

  Future<void> fetchNotes() async {
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token');

    if (token != null) {
      isLoading(true);

      try {
        final List<Note> getNotes = await _notesRepository.fetchNotes();
        notes.assignAll(getNotes);
        hasError(false);
      } catch (e) {
        hasError(true);
        print('Erro ao buscar notas: $e');
      } finally {
        isLoading(false);
      }
    } else {
      print('Erro ao encontrar token');
    }
  }

  Future<bool> addNote(String noteName, String noteText) async {
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token');
    final userId = preferences.getString('userId');

    if (token != null) {
      try {
        await _notesRepository.addNote(noteName, noteText);
        return true;
      } catch (e) {
        print('Erro ao adicionar note: $e');
        return false;
      }
    } else {
      print('token não encontrado!');
      return false;
    }
  }

  Future<bool> deleteNote(Note note) async {
    final preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token');

    if (token != null) {
      try {
        await _notesRepository.deleteNote(note, token);
        await fetchNotes();
        return true;
      } catch (e) {
        print('Erro ao deletar nota: $e');
        return false;
      }
    } else {
      print('Token não encontrado!');
      return false;
    }
  }
  
  Future<bool> editNote(Note note) async {
  final preferences = await SharedPreferences.getInstance();
  final token = preferences.getString('token');

  if (token != null) {
    try {
      await _notesRepository.editNote(note, token);
      await fetchNotes();
      return true;
    } catch (e) {
      print('Erro ao atualizar nota: $e');
      return false;
    } 
  } else {
    print('Token não encontado!');
    return false;
  }

}

}

