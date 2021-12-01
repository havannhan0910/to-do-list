import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/dialog/edit_dialog.dart';
import 'package:todolist/provider/event.dart';
import 'package:todolist/img/random_image.dart';
import 'package:todolist/dialog/delete_dialog.dart';
import 'empty_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final _newItem = Provider.of<AddEvent>(context);
  //   _newItem.getData();
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: RandomImage().mainList(),
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(1.0), BlendMode.dstATop),
              alignment: Alignment.bottomLeft,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Consumer<Event>(
          builder: (context, _newItem, child) {
            return FutureBuilder(
              future: _newItem.getData(),
              builder: (context, snapshot) {
                if (_newItem.toDoItem.isEmpty) return const EmptyScreen();
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    itemCount: _newItem.toDoItem.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15.0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                spreadRadius: 4,
                                blurRadius: 10,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              )
                            ],
                          ),
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Created: ${_newItem.toDoItem[index].date}",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  _newItem.toDoItem[index].title,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 100,
                                  child: Text(
                                    _newItem.toDoItem[index].description,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.justify,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            //Design Delete Widget
                          ),
                        ),
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return DeleteDialog(index: index);
                            },
                          );
                        },
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return EditDialog(
                              index: index,
                              itemTitle: _newItem.toDoItem[index].title,
                              itemDesc: _newItem.toDoItem[index].description,
                            );
                          }));
                        },
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
