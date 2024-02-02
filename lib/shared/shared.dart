import 'dart:async';

import 'package:flutter/material.dart';

Map<String, dynamic> userData = {};

List favoriteNotes = [];

List colors = [
  Colors.red,
  Colors.blue,
  Colors.green,
  Colors.yellow,
  Colors.amber,
  Colors.purple,
];

List notes = [];
List allNotes = [];

List notesSearch = [];
List allNotesSearch = [];

var sharedController = StreamController.broadcast();

bool isSearch = false;
