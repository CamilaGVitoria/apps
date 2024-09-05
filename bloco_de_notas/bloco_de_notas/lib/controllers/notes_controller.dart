import 'package:bloco_de_notas/model/note.dart';
import 'package:bloco_de_notas/repository/notes_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NotesController extends GetxController {
  var notesList = <Note>[].obs;
  var isLoading = false.obs;

  final NotesRepository notesRepository = NotesRepository();
  final storage = GetStorage();

  String? get token => storage.read('token');

  Future<void> fetchNotes() async {
    if (token == null) return;

    isLoading(true);

    try {
      final userId = storage.read('userId');
      if (userId != null) {
        notesList.value = await notesRepository.getNotes(userId, token!);
      }
    } catch (e) {
      print('Erro ao buscar notas: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> addNote(Note newNote) async {
    if (token == null) return;

    isLoading(true);

    try {
      final note = await notesRepository.addNote(newNote, token!);
      if (note != null) {
        notesList.add(note);
      }
    } catch (e) {
      print('Erro ao adicionar note: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteNote(String noteId) async {
    if (token == null) return;

    isLoading(true);

    try {
      await notesRepository.deleteNote(noteId, token!);
      await fetchNotes();
    } catch (e) {
      isLoading(false);
    }
  }
}
