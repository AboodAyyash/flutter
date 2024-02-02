import 'package:flutter/material.dart';
import 'package:start/DB/DB-note.dart';
import 'package:start/shared/shared.dart';

class EditPage extends StatefulWidget {
  Map note;
  EditPage({required this.note});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  bool hasNote = false;
  bool isEdit = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    if (widget.note.toString() != "{}") {
      hasNote = true;
      titleController.text = widget.note['title'];
      bodyController.text = widget.note['body'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              if (hasNote) {
                setState(() {
                  hasNote = false;
                  isEdit = true;
                });
              } else {
                if (isEdit) {
                  print("Is Edit");
                  DatabaseHelperNotes helperNotes = DatabaseHelperNotes();
                  await helperNotes.init();
                  Map<String, dynamic> note = {
                    'title': titleController.text.toString(),
                    'body': bodyController.text.toString(),
                    'id': widget.note['id'],
                    'isFav': "0",
                    "time": TimeOfDay.now().toString(),
                    'userId': widget.note['userId'],
                  };

                  helperNotes.update(note).then((value) {
                    Navigator.pop(context, note);
                  });
                } else {
                  DatabaseHelperNotes helperNotes = DatabaseHelperNotes();
                  await helperNotes.init();
                  Map<String, dynamic> note = {
                    'title': titleController.text.toString(),
                    'body': bodyController.text.toString(),
                    'isFav': "0",
                    "time": TimeOfDay.now().toString(),
                    'userId': userData['id'],
                  };

                  helperNotes.insert(note).then((valueInsert) {
                    print(valueInsert);

                    helperNotes.queryAllRows().then((value) {
                      print(value);
                      Navigator.pop(context, value[value.length - 1]);
                    });
                  });
                }
              }
            },
            icon: hasNote ? Icon(Icons.edit) : Icon(Icons.save),
          ),
        ],
      ),
      body: ListView(children: [
        hasNote
            ? Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 61, 142, 240),
                    borderRadius: BorderRadius.circular(4)),
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                child: Text(
                  titleController.text.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
              )
            : TextField(
                style: const TextStyle(color: Colors.white),
                controller: titleController,
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: "Enter title",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
        const SizedBox(
          height: 20,
        ),
        hasNote
            ? Container(
                decoration: BoxDecoration(
                    color: const Color(0xFFFD99FF),
                    borderRadius: BorderRadius.circular(4)),
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                child: Text(
                  bodyController.text.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
              )
            : TextField(
                style: const TextStyle(color: Colors.white),
                controller: bodyController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: "Enter Body",
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
      ]),
    );
  }
}
