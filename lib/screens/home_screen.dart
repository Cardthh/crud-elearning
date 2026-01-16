import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../models/note.dart';
import 'add_edit_note.dart';
import 'note_detail.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    refreshNotes();
  }

  void refreshNotes() async {
    notes = await DBHelper.getNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: notes.isEmpty
          ? Center(
              child: Text('Belum ada catatan'),
            )
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final n = notes[index];

                return ListTile(
                  title: Text(n.title),
                  subtitle: Text(
                    n.content,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NoteDetail(note: n),
                      ),
                    );

                    if (result == true) {
                      refreshNotes();
                    }
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddEditNote(),
            ),
          );
          refreshNotes();
        },
      ),
    );
  }
}
