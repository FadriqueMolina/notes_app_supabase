import 'package:flutter/material.dart';
import 'package:notes_app_supabase/models/note.dart';
import 'package:notes_app_supabase/providers/note_provider.dart';

class HomePage extends StatelessWidget {
  final noteProvider = NoteProvider();
  final TextEditingController controller = TextEditingController();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notes")),
      body: Center(
        child: StreamBuilder(
          stream: noteProvider.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final note = data[index];
                return ListTile(
                  title: Text(data[index].content),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          updateNote(context, note);
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          deleteNote(context, note);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNote(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void addNote(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Add note"),
            content: TextField(controller: controller),
            actions: [
              TextButton(
                onPressed: () {
                  noteProvider.addNote(Note(content: controller.text));
                  controller.clear();
                  Navigator.pop(context);
                },
                child: Text("Add"),
              ),
              TextButton(
                onPressed: () {
                  controller.clear();
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
            ],
          ),
    );
  }

  void updateNote(BuildContext context, Note oldNote) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Update note"),
            content: TextField(controller: controller),
            actions: [
              TextButton(
                onPressed: () {
                  noteProvider.updateNote(oldNote, controller.text);
                  controller.clear();
                  Navigator.pop(context);
                },
                child: Text("Update"),
              ),
              TextButton(
                onPressed: () {
                  controller.clear();
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
            ],
          ),
    );
  }

  void deleteNote(BuildContext context, Note oldNote) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Delete note"),
            actions: [
              TextButton(
                onPressed: () {
                  noteProvider.deleteNote(oldNote);
                  controller.clear();
                  Navigator.pop(context);
                },
                child: Text("Delete"),
              ),
              TextButton(
                onPressed: () {
                  controller.clear();
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
            ],
          ),
    );
  }
}
