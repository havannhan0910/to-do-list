import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/provider/event.dart';

class DeleteDialog extends StatelessWidget {
  final int index;
  const DeleteDialog({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _deleteItem = Provider.of<Event>(context);

    return AlertDialog(
      title: const Text("Delete"),
      content: const Text("Are you sure ?"),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("No"),
            ),
            const SizedBox(
              width: 12,
            ),
            ElevatedButton(
              onPressed: () {
                _deleteItem.removeItem(_deleteItem.toDoItem[index]);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Deleted"),
                  duration: Duration(milliseconds: 500),
                ));
              },
              child: const Text("Yes"),
            ),
          ],
        ),
      ],
    );
  }
}
