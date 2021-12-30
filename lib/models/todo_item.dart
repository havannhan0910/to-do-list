import 'package:intl/intl.dart';

class ToDoItem {
  int id;
  int time;
  String title;
  String description;

  ToDoItem({required this.id, required this.time, required this.title, required this.description});

  String get date {
    final date = DateTime.fromMillisecondsSinceEpoch(id);
    return DateFormat('dd/MM/yyyy, HH:mm').format(date);
  }

  String get toDoTime {
    final timed = DateTime.fromMillisecondsSinceEpoch(time);
    return DateFormat('dd/MM/yyyy, HH:mm').format(timed);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'time': time,
      'title': title,
      'description': description,
    };
  }
}
