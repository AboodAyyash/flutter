import 'package:flutter/material.dart';
import 'package:start/shared/shared.dart';
import 'package:start/widgets/note.dart';

Widget myNotesPage(myContext) {
  return ListView(
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
                          notesSearch.add(notes[i]);
                          sharedController.sink.add("event");
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
                        return note(notesSearch[index], index, myContext);
                      }),
                if (!isSearch)
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: notes.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, index) {
                        return note(notes[index], index, myContext);
                      }),
              ],
            ),
    ],
  );
}
