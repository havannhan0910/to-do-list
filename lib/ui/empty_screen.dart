import 'package:flutter/material.dart';
import 'package:todolist/dialog/add_dialog.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/image-10.jpg'),
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(1.0), BlendMode.dstATop),
              alignment: Alignment.bottomLeft,
              fit: BoxFit.cover,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
                width: 80,
              ),
              Container(
                margin: const EdgeInsets.all(40),
                height: 120,
                width: 120,
                // child: const Text(
                //   "Quay lại số cân như lúc này đi cân nặng ơi! ",
                //   style: TextStyle(
                //     fontSize: 18,
                //     color: Colors.pinkAccent,
                //   ),
                // ),
              ),
            ],
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                backgroundColor: Colors.blueGrey,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const AddDialog()));
                },
                child: const Icon(
                  Icons.add,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "Add To Do",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
