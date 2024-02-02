import 'dart:math';

import 'package:flutter/material.dart';
import 'package:start/DB/DB-favorite-notes.dart';
import 'package:start/DB/DB-note.dart';
import 'package:start/pages/edit.dart';
import 'package:start/shared/shared.dart';
import 'package:start/widgets/custom_dialog.dart';

Widget note(note, index, context) {
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
          notes.removeAt(index);
          notes.insert(index, value);
          sharedController.sink.add("event");
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () async {
                    DatabaseHelperNotes helperNotes = DatabaseHelperNotes();
                    await helperNotes.init();

                    Map<String, dynamic> newNote = {
                      'title': note['title'].toString(),
                      'body': note['body'].toString(),
                      'id': note['id'],
                      'isFav': note['isFav'] == '1' ? "0" : '1',
                      "time": TimeOfDay.now().toString(),
                      'userId': note['userId'],
                    };
                    helperNotes.update(newNote).then((value) {
                      note['isFav'] = newNote['isFav'];
                      sharedController.sink.add("event");
                    });

                    bool hasFav = false;
                    for (var i = 0; i < favoriteNotes.length; i++) {
                      if (favoriteNotes[i]['userId'] == note['userId'] &&
                          favoriteNotes[i]['noteId'] == note['id']) {
                        hasFav = false;
                        break;
                      } else {
                        hasFav = true;
                      }
                    }
                    print("hasFav $hasFav");

                    if (hasFav) {
                      DatabaseHelperFavoriteNotes helperFavoriteNotes =
                          DatabaseHelperFavoriteNotes();
                      await helperFavoriteNotes.init();

                      Map<String, dynamic> favoriteNote = {
                        'noteId': note['id'],
                        'userId': note['userId']
                      };
                      helperFavoriteNotes.insert(favoriteNote).then((value) {
                        customDialog(
                            context: context,
                            showCancelButton: false,
                            body: "Thaks!",
                            okButton: "Ok",
                            cancelButton: "Cancel",
                            title: "Alert");
                      });
                    }
                  },
                  icon: Icon(note['isFav'] == '1'
                      ? Icons.favorite
                      : Icons.favorite_border)),
            ],
          ),
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
