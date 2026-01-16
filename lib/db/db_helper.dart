import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/note.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> initDb() async {
    if (_db != null) return _db!;
    String path = join(await getDatabasesPath(), 'notes.db');
    _db = await openDatabase(path, version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT)'
        );
      }
    );
    return _db!;
  }

  static Future<int> insertNote(Note note) async {
    final db = await initDb();
    return await db.insert('notes', note.toMap());
  }
  static Future<List<Note>> getNotes() async {
    final db = await initDb();
    final list = await db.query('notes');
    return list.map((e) => Note(
      id: e['id'] as int,
      title: e['title'] as String,
      content: e['content'] as String
    )).toList();
  }
  static Future<int> updateNote(Note note) async {
    final db = await initDb();
    return await db.update('notes', note.toMap(),
      where: "id=?", whereArgs: [note.id]);
  }
  static Future<int> deleteNote(int id) async {
    final db = await initDb();
    return await db.delete('notes', where: "id=?", whereArgs: [id]);
  }
}
