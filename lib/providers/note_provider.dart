import 'package:notes_app_supabase/models/note.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NoteProvider {
  final database = Supabase.instance.client.from("notes");

  //Add to notes
  Future addNote(Note newNote) async {
    await database.insert(newNote.toMap());
  }

  //Read from notes
  final stream = Supabase.instance.client
      .from("notes")
      .stream(primaryKey: ["id"])
      .map((data) => data.map((noteMap) => Note.fromMap(noteMap)).toList());

  //Update note

  Future updateNote(Note oldNote, String newContent) async {
    await database.update({"content": newContent}).eq("id", oldNote.id!);
  }

  //Delete note

  Future deleteNote(Note note) async {
    await database.delete().eq("id", note.id!);
  }
}
