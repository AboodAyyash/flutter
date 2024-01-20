import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start/DB/DB-user.dart';
import 'package:start/pages/auth/login.dart';
import 'package:start/pages/auth/signup.dart';
import 'package:start/pages/home.dart';
import 'package:start/services/service.dart';
import 'package:start/shared/shared.dart';

class ButtonPage extends StatefulWidget {
  const ButtonPage({super.key});

  @override
  State<ButtonPage> createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  @override
  void initState() {
    super.initState();
    checkFun();
  }

  checkFun() async {
    getUserId().then((userId) async {
      print("User ID $userId");
      if (userId != 0) {
        DatabaseHelper databaseHelper = DatabaseHelper();
        await databaseHelper.init();
        databaseHelper.queryAllRows().then((value) {
          for (var i = 0; i < value.length; i++) {
            if (userId == value[i]['id']) {
              userData = value[i];
              break;
            }
          }
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
              (Route<dynamic> route) => false);
        });
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
            (Route<dynamic> route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          onPressed: () async {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            prefs.setString("checkPage", "enter");
          },
          icon: Platform.isAndroid ? Icon(Icons.check) : Icon(Icons.alarm),
        ),
      ),
    );
  }
}
