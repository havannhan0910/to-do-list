import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todolist/models/todo_item.dart';

class ToDoDatabase {
  // Database _database;

  Future init() async {
    Database _database = await openDatabase(
      join(await getDatabasesPath(), 'todo.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE todo(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, time INTEGER, title TEXT, description TEXT)',
        );
      },
      version: 1,
    );
    return _database;
  }

  Future<List<ToDoItem>> selectAll() async {
    Database db = await init();
    final List<Map<String, dynamic>> maps = await db.query('todo');

    return List.generate(maps.length, (index) {
      return ToDoItem.fromData(
        id: maps[index]['id'],
        time: maps[index]['time'],
        title: maps[index]['title'],
        description: maps[index]['description'],
      );
    });
  }

  Future insertToDo(ToDoItem item) async {
    Database db = await init();
    await db.insert(
      'todo',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteTodo(ToDoItem item) async {
    Database db = await init();

    await db.delete(
      'todo',
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future updateToDo(ToDoItem item) async {
    Database db = await init();

    db.update(
      'todo',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
