import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../models/note.dart';

class AddEditNote extends StatefulWidget {
  final Note? note;
  AddEditNote({this.note});

  @override
  _AddEditNoteState createState() => _AddEditNoteState();
}

class _AddEditNoteState extends State<AddEditNote> {
  final titleCtrl = TextEditingController();
  final contentCtrl = TextEditingController();

  @override
  void initState() {
    if (widget.note != null) {
      titleCtrl.text = widget.note!.title;
      contentCtrl.text = widget.note!.content;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Add Note' : 'Edit Note'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: titleCtrl, decoration: InputDecoration(labelText: 'Title')),
            TextField(controller: contentCtrl, decoration: InputDecoration(labelText: 'Content')),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () async {
                if (widget.note == null) {
                  await DBHelper.insertNote(
                    Note(title: titleCtrl.text, content: contentCtrl.text)
                  );
                } else {
                  await DBHelper.updateNote(
                    Note(id: widget.note!.id, title: titleCtrl.text, content: contentCtrl.text)
                  );
                }
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
