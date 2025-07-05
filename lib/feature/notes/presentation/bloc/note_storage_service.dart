import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/feature/notes/data/models/note_model.dart';

class NoteStorageService {
  static const String _key = 'notes';

  static Future<List<Note>> loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_key);
    if (data == null) return [];
    final list = jsonDecode(data) as List;
    return list.map((e) => Note.fromJson(e)).toList();
  }

  static Future<void> saveNotes(List<Note> notes) async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(notes.map((e) => e.toJson()).toList());
    // debugPrint("Saving notes: $data");
    await prefs.setString(_key, data);
  }
}
