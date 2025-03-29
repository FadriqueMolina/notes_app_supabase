import 'package:flutter/material.dart';
import 'package:notes_app_supabase/models/note.dart';
import 'package:notes_app_supabase/providers/note_provider.dart';
import 'package:provider/provider.dart';

enum Actions { add, update, delete }

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
                      IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                      IconButton(
                        onPressed: () {
                          noteProvider.deleteNote(note);
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
          showMessageDialogWithAction(context, controller.text, Actions.add);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> showMessageDialogWithAction(
    BuildContext context,
    String message,
    Actions action,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("${action.name} note"),
          content: TextField(controller: controller),
          actions: [
            TextButton(
              onPressed: () {
                controller.clear();
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                switch (action) {
                  case Actions.add:
                    noteProvider.addNote(Note(content: controller.text));
                    break;
                  case Actions.update:
                    break;
                  case Actions.delete:
                    noteProvider.deleteNote(Note(content: controller.text));
                    break;
                }

                controller.clear();
                Navigator.pop(context);
              },
              child: Text(action.name),
            ),
          ],
        );
      },
    );
  }
}
