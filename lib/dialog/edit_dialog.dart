import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/models/todo_item.dart';
import 'package:todolist/provider/event.dart';

class EditDialog extends StatefulWidget {
  final String itemTitle;
  final String itemDesc;
  final int index;

  const EditDialog(
      {Key? key,
      required this.index,
      required this.itemTitle,
      required this.itemDesc})
      : super(key: key);

  @override
  State<EditDialog> createState() =>
      _EditDialogState(index, itemTitle, itemDesc);
}

class _EditDialogState extends State<EditDialog> {
  final _txtTitle = TextEditingController();
  final _txtDesc = TextEditingController();

  final _keyTitle = GlobalKey<FormState>();
  final _keyDesc = GlobalKey<FormState>();

  final int index;
  final String itemTitle;
  final String itemDesc;

  _EditDialogState(this.index, this.itemTitle, this.itemDesc);

  @override
  void initState() {
    _txtTitle.text = itemTitle;
    _txtDesc.text = itemDesc;
    super.initState();
  }

  final int _lastUpdated = DateTime.now().millisecondsSinceEpoch;

  @override
  Widget build(BuildContext context) {
    final _editItem = Provider.of<Event>(context);

    final _id = _editItem.toDoItem[index].id;
    var _time = _editItem.toDoItem[index].time;

    return Scaffold(
      // appBar: AppBar(),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/image-7.jpg'),
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.8), BlendMode.dstATop),
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 32,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: Text(
                  "Last updated: ${_editItem.toDoItem[index].toDoTime}",
                  style: const TextStyle(
                      fontSize: 12, fontStyle: FontStyle.italic),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  // margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
                  child: Form(
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
                        hintStyle: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  // margin: const EdgeInsets.fromLTRB(24, 4, 24, 12),
                  child: Form(
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
                        backgroundColor: Color.fromRGBO(
                            12, 12, 12, 0.10196078431372549),
                      ),
                      // overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                      decoration: const InputDecoration(
                        hintText: "Enter descriptions",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            splashColor: Colors.blueAccent,
            onLongPress: () {
              _editItem.removeItem(_editItem.toDoItem[index]);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Deleted"),
                duration: Duration(milliseconds: 500),
              ));
            },
            child: FloatingActionButton(
              heroTag: null,
              backgroundColor: Colors.grey,
              onPressed: () {},
              child: const Icon(Icons.delete, color: Colors.black54),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          FloatingActionButton(
            heroTag: null,
            onPressed: () {
              setState(() {
                _time = _lastUpdated;
              });
              if (_keyTitle.currentState!.validate() &&
                  _keyDesc.currentState!.validate()) {
                _editItem.editItem(
                    index,
                    ToDoItem(
                      id: _id,
                      time: _time,
                      title: _txtTitle.text.trim(),
                      description: _txtDesc.text.trim(),
                    ));
                // print(_editItem.toDoItem[index].id);
                // print(_editItem.toDoItem[index].title);
                // print(_editItem.toDoItem[index].description);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Saved"),
                  duration: Duration(milliseconds: 500),
                ));
              }
            },
            child: const Icon(Icons.save),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _txtTitle.dispose();
    _txtDesc.dispose();
    super.dispose();
  }
}
