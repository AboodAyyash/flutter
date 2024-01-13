import 'dart:math';

import 'package:flutter/material.dart';
import 'package:start/pages/edit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List notes = [];
  List colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.amber,
    Colors.purple,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notes",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      floatingActionButton: IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => EditPage(
                note: {},
              ),
            ),
          ).then((value) {
            if (value.toString() != "null") {
              setState(() {
                notes.add(value);
              });
            }
          });
        },
        icon: const Icon(
          Icons.add,
          color: Colors.white,
          size: 50,
        ),
      ),
      body: ListView(
        children: [
          notes.isEmpty
              ? Center(
                  child: SizedBox(
                    height: 500,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          "https://media.macphun.com/img/uploads/customer/how-to/608/15542038745ca344e267fb80.28757312.jpg?q=85&w=1340",
                          width: 200,
                        ),
                        Text(
                          "Create your first note !",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: notes.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, index) {
                    return note(notes[index], index);
                  }),
        ],
      ),
    );
  }

  Widget note(note, index) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => EditPage(
              note: note,
            ),
          ),
        ).then((value) {
          if (value.toString() != "null") {
            setState(() {
              notes.removeAt(index);
              notes.insert(index, value);
            });
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: colors[Random().nextInt(6)],
            borderRadius: BorderRadius.circular(4)),
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        child: Text(
          note['title'].toString(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 30,
          ),
        ),
      ),
    );
  }
}
