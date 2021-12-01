import 'package:flutter/material.dart';
import 'package:todolist/dialog/add_dialog.dart';
import 'package:todolist/ui/main_screen.dart';

class AppContainer extends StatelessWidget {
  const AppContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To Do List"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const AddDialog()));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: const MainScreen(),
    );
  }
}
