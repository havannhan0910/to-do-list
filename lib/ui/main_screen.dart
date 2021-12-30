import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/dialog/edit_dialog.dart';
import 'package:todolist/models/todo_item.dart';
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

  final _scrollController = ScrollController();

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent + 1);
    }
  }

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
            return FutureBuilder<List<ToDoItem>>(
              future: _newItem.getData(),
              builder: (context, snapshot) {
                WidgetsBinding.instance!
                    .addPostFrameCallback((_) => _scrollToBottom());

                return _newItem.toDoItem.isEmpty
                    ? const EmptyScreen()
                    : Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ListView.builder(
                          controller: _scrollController,
                          physics: const BouncingScrollPhysics(),
                          reverse: true,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(15.0),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(
                                          0, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Created: ${snapshot.data![index].date}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.white),
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        snapshot.data![index].title,
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
                                          snapshot.data![index].description,
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
                                    itemTitle: snapshot.data![index].title,
                                    itemDesc: snapshot.data![index].description,
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
