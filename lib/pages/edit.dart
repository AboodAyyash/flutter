import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  Map note;
  EditPage({required this.note});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  bool hasNote = false;
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
            onPressed: () {
              if (hasNote) {
                setState(() {
                  hasNote = false;
                });
              } else {
                Map data = {
                  "title": titleController.text.toString(),
                  "body": bodyController.text.toString(),
                };

                print(titleController.text.toString());
                print(bodyController.text.toString());
                Navigator.pop(context, data);
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