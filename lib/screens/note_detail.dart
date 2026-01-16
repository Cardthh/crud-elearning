import 'package:flutter/material.dart';
import '../models/note.dart';
import '../db/db_helper.dart';
import 'add_edit_note.dart';

class NoteDetail extends StatelessWidget {
  final Note note;

  NoteDetail({required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Note'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AddEditNote(note: note),
                ),
              ).then((_) => Navigator.pop(context, true));
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await DBHelper.deleteNote(note.id!);
              Navigator.pop(context, true);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              note.content,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
