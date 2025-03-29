import 'package:flutter/material.dart';
import 'package:notes_app_supabase/models/note.dart';
import 'package:notes_app_supabase/providers/note_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context, listen: false);
    TextEditingController controller = TextEditingController();

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
                return ListTile(title: Text(data[index].content));
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Add note"),
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
                      noteProvider.addNote(Note(content: controller.text));
                      controller.clear();
                      Navigator.pop(context);
                    },
                    child: Text("Add note"),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
