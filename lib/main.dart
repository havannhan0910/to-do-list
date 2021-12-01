import 'package:flutter/material.dart';
import 'package:todolist/provider/event.dart';
import 'package:todolist/ui/app_container.dart';
import 'package:provider/provider.dart';
import 'db/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ToDoDatabase().init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => Event()),
    ],
    child: const MaterialApp(
      title: "To Do List",
      debugShowCheckedModeBanner: false,
      home: AppContainer(),
    ),
  ));
}

