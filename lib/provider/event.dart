import 'package:flutter/material.dart';
import 'package:todolist/db/database_helper.dart';
import 'package:todolist/models/todo_item.dart';

class Event extends ChangeNotifier {
  List<ToDoItem> toDoItem = <ToDoItem>[];
  final ToDoDatabase _toDoDatabase = ToDoDatabase();

  Future<List<ToDoItem>> getData() async {
    toDoItem = await _toDoDatabase.selectAll();
    return toDoItem;
  }

  // Event() {
  //   getData();
  // }

  Future addItem(ToDoItem item) async {
    //add to database
    await _toDoDatabase.insertToDo(item) ;
    toDoItem.add(item);
    notifyListeners();
    // _toDoDatabase.updateToDo(item);
  }

  Future removeItem(ToDoItem item) async {
    //detete from database
    await _toDoDatabase.deleteTodo(item).then((value) {
      toDoItem.remove(item);
      notifyListeners();
    });
  }

  Future editItem(int index, ToDoItem item) async {
    //edit item
    toDoItem.replaceRange(index, index+1, [item]);
    await _toDoDatabase.updateToDo(item);
    notifyListeners();
  }
}
