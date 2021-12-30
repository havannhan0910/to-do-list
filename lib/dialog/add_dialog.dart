import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/todo_item.dart';
import 'package:todolist/provider/event.dart';

class AddDialog extends StatefulWidget {
  const AddDialog({Key? key}) : super(key: key);

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  int id = DateTime.now().millisecondsSinceEpoch;

  final _txtTitle = TextEditingController();
  final _txtDesc = TextEditingController();

  final _keyTitle = GlobalKey<FormState>();
  final _keyDesc = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _addItem = Provider.of<Event>(context);

    // TODO: implement build
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/image-6.jpg'),
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.7), BlendMode.dstATop),
            alignment: Alignment.topRight,
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 28,
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(12),
                // margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
                child: Form(
                  //Title
                  key: _keyTitle,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "";
                      }
                    },
                    controller: _txtTitle,
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: Colors.black,
                    cursorWidth: 2,
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(4),
                      border: OutlineInputBorder(),
                      hintText: "Enter Title",
                      hintStyle: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(12),
                // margin: const EdgeInsets.fromLTRB(24, 6, 24, 12),
                child: Form(
                  //Description
                  key: _keyDesc,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Field Cannot Empty!";
                      }
                    },
                    controller: _txtDesc,
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: Colors.black,
                    cursorWidth: 2,
                    maxLines: 2000,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.justify,
                    decoration: const InputDecoration(
                      hintText: "Enter descriptions",
                      hintStyle: TextStyle(fontSize: 16, color: Colors.white),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_keyTitle.currentState!.validate() &&
              _keyDesc.currentState!.validate()) {
            _addItem.addItem(ToDoItem.fromData(
              id: id,
              time: id,
              title: _txtTitle.text.trim(),
              description: _txtDesc.text.trim(),
            ));
            _txtTitle.clear();
            _txtDesc.clear();
            FocusScope.of(context).unfocus();
            Navigator.pop(context);
          }
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  @override
  void dispose() {
    _txtTitle.dispose();
    _txtDesc.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
