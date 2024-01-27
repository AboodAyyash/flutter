import 'package:flutter/material.dart';

Future customDialog(
    {context, title, body, cancelButton = "Cancel", okButton = "OK"}) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: <Widget>[
          TextButton(
            child: Text(cancelButton.toString()),
            onPressed: () {
              Navigator.pop(context, "cancel");
            },
          ),
          TextButton(
            child: Text(okButton.toString()),
            onPressed: () {
              Navigator.pop(context, "ok");
            },
          ),
        ],
      );
    },
  );
}
