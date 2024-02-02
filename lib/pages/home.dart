import 'dart:math';

import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start/DB/DB-favorite-notes.dart';
import 'package:start/DB/DB-note.dart';
import 'package:start/pages/auth/profile.dart';
import 'package:start/pages/edit.dart';
import 'package:start/pages/favorite.dart';
import 'package:start/pages/frainds.dart';
import 'package:start/pages/my-notes.dart';
import 'package:start/shared/shared.dart';
import 'package:start/widgets/custom_dialog.dart';
import 'package:start/widgets/note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    notes = [];
    allNotes = [];
    favoriteNotes = [];
    notesSearch = [];
    allNotesSearch = [];
    sharedData();
    getNotes();
    getAllNotes();
  }

  Widget allNotesPage() {
    return ListView(
      children: [
        allNotes.isEmpty
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
                        allNotesSearch = [];
                        for (var i = 0; i < allNotes.length; i++) {
                          /*  if (notes[i]['title'].toString().toLowerCase()[0] ==
                                value.toString().toLowerCase())  */
                          if (allNotes[i]['title']
                                  .toString()
                                  .toLowerCase()
                                  .contains(value.toString().toLowerCase()) ||
                              allNotes[i]['body']
                                  .toString()
                                  .toLowerCase()
                                  .contains(value.toString().toLowerCase())) {
                            allNotesSearch.add(allNotes[i]);
                            sharedController.sink.add("event");
                          }
                        }
                      },
                    ),
                  if (isSearch)
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: allNotesSearch.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, index) {
                          return note(allNotesSearch[index], index, context);
                        }),
                  if (!isSearch)
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: allNotes.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, index) {
                          return note(allNotes[index], index, context);
                        }),
                ],
              ),
      ],
    );
  }

  getNotes() async {
    DatabaseHelperNotes helperNotes = DatabaseHelperNotes();
    await helperNotes.init();
    helperNotes.queryAllRows().then((value) {
      for (var i = 0; i < value.length; i++) {
        if (userData['id'] == value[i]['userId']) {
          notes.add(value[i]);
          sharedController.sink.add("event");
        }
      }
    });
  }

  getAllNotes() async {
    DatabaseHelperNotes helperNotes = DatabaseHelperNotes();
    await helperNotes.init();
    helperNotes.queryAllRows().then((value) {
      print("value $value");
      for (var i = 0; i < value.length; i++) {
        allNotes.add(value[i]);
        sharedController.sink.add("event");
      }
      getFavoriteNotes();
      print("allNotes $allNotes");
    });
  }

  getFavoriteNotes() async {
    DatabaseHelperFavoriteNotes helperNotes = DatabaseHelperFavoriteNotes();
    await helperNotes.init();
    helperNotes.queryAllRows().then((favNotes) {
      for (var i = 0; i < favNotes.length; i++) {
        for (var j = 0; j < allNotes.length; j++) {
          if (favNotes[i]['userId'].toString() ==
              allNotes[j]['userId'].toString()) {
            favoriteNotes.add(allNotes[j]);
            sharedController.sink.add("event");
          }
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
    return StreamBuilder(
        stream: sharedController.stream,
        builder: (BuildContext context, snapshot) {
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
                        builder: (BuildContext context) => const FriandPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.people),
                ),
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
                          isSearch = false;
                          sharedController.sink.add("event");
                        },
                        icon: const Icon(Icons.done),
                      )
                    : IconButton(
                        onPressed: () {
                          notesSearch = [];
                          isSearch = true;
                          sharedController.sink.add("event");
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
                          notes.add(value);
                          allNotes.add(value);
                          sharedController.sink.add("event");
                        }
                      });
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
            body: pageIndex == 0
                ? allNotesPage()
                : pageIndex == 1
                    ? favoriteNotesPage(context)
                    : pageIndex == 2
                        ? Center(
                            child: Text(
                              "2",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        : myNotesPage(context),
            bottomNavigationBar: SalomonBottomBar(
              currentIndex: pageIndex,
              onTap: (i) {
                pageIndex = i;
                sharedController.sink.add("event");
              },
              items: [
                /// Home
                SalomonBottomBarItem(
                  icon: Icon(Icons.home),
                  title: Text("Home"),
                  selectedColor: Colors.purple,
                  unselectedColor: Colors.white,
                ),

                /// Likes
                SalomonBottomBarItem(
                  icon: Icon(Icons.favorite_border),
                  title: Text("Favorite"),
                  selectedColor: Colors.pink,
                  unselectedColor: Colors.white,
                ),

                /// Search
                SalomonBottomBarItem(
                  icon: Icon(Icons.search),
                  title: Text("Search"),
                  selectedColor: Colors.orange,
                  unselectedColor: Colors.white,
                ),

                /// Profile
                SalomonBottomBarItem(
                  icon: Icon(Icons.person),
                  title: Text("Profile"),
                  selectedColor: Colors.teal,
                  unselectedColor: Colors.white,
                ),
              ],
            ),
          );
        });
  }
}
