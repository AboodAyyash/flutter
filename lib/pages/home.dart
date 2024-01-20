import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start/DB/DB-note.dart';
import 'package:start/pages/auth/profile.dart';
import 'package:start/pages/edit.dart';
import 'package:start/shared/shared.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List notes = [];
  List notesSearch = [];
  List colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.amber,
    Colors.purple,
  ];

  bool isSearch = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedData();
    getNotes();
  }

  getNotes() async {
    DatabaseHelperNotes helperNotes = DatabaseHelperNotes();
    await helperNotes.init();
    helperNotes.queryAllRows().then((value) {
      print(value);
      for (var i = 0; i < value.length; i++) {
        if (userData['id'] == value[i]['userId']) {
          setState(() {
            notes.add(value[i]);
          });
        }
      }
    });
  }

  sharedData() async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();

// Save an integer value to 'counter' key.
    await prefs.setInt('counter', 10);
    await prefs.setInt('counter', 11);
// Save an boolean value to 'repeat' key.
    await prefs.setBool('repeat', true);
    await prefs.setBool('repeats', false);

// Save an double value to 'decimal' key.
    await prefs.setDouble('decimal', 1.5);
// Save an String value to 'action' key.
    await prefs.setString('action', 'Start');
// Save an list of strings to 'items' key.
    await prefs.setStringList('items', <String>['Earth', 'Moon', 'Sun']);
    print(prefs.getBool("repeats"));
    /*   int? x = 0;
    if (prefs.getInt("counter") != null) {
      x = prefs.getInt("counter");
    } */
  }

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
            onPressed: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const ProfilePage(),
                ),
              );
            },
            icon: const Icon(Icons.person),
          ),
          isSearch
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isSearch = false;
                    });
                  },
                  icon: const Icon(Icons.done),
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      notesSearch = [];
                      isSearch = true;
                    });
                  },
                  icon: const Icon(Icons.search),
                ),
        ],
      ),
      floatingActionButton: isSearch
          ? Container()
          : IconButton(
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
              : ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    if (isSearch)
                      TextField(
                        style: TextStyle(color: Colors.white),
                        maxLines: 2,
                        decoration: InputDecoration(
                          hintText: "Serach",
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onChanged: (value) {
                          print(value);
                          notesSearch = [];
                          for (var i = 0; i < notes.length; i++) {
                            /*  if (notes[i]['title'].toString().toLowerCase()[0] ==
                                value.toString().toLowerCase())  */
                            if (notes[i]['title']
                                    .toString()
                                    .toLowerCase()
                                    .contains(value.toString().toLowerCase()) ||
                                notes[i]['body']
                                    .toString()
                                    .toLowerCase()
                                    .contains(value.toString().toLowerCase())) {
                              setState(() {
                                notesSearch.add(notes[i]);
                              });
                            }
                          }
                        },
                      ),
                    if (isSearch)
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: notesSearch.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, index) {
                            return note(notesSearch[index], index);
                          }),
                    if (!isSearch)
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: notes.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, index) {
                            return note(notes[index], index);
                          }),
                  ],
                ),
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
        child: Column(
          children: [
            Text(
              note['title'].toString(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30,
              ),
            ),
            Text(
              note['body'].toString(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
