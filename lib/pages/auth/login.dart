import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start/DB/DB-user.dart';
import 'package:start/pages/auth/signup.dart';
import 'package:start/pages/home.dart';
import 'package:start/services/service.dart';
import 'package:start/shared/shared.dart';
import 'package:start/widgets/custom_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      body: ListView(
        children: [
          TextField(
            style: const TextStyle(color: Colors.white),
            controller: nameController,
            maxLines: 2,
            decoration: const InputDecoration(
              hintText: "Enter User Name",
              hintStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            style: const TextStyle(color: Colors.white),
            controller: passwordController,
            maxLines: 2,
            decoration: const InputDecoration(
              hintText: "Enter Password",
              hintStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              if (nameController.text.toString().isEmpty ||
                  passwordController.text.toString().isEmpty) {
                print("Please Fill Data First!");

                customDialog(
                  body: "Please Fill Data First!",
                  title: "Login",
                  okButton: "OK",
                  cancelButton: "Cancel",
                  context: context,
                ).then((value) {
                  print(value);

                  if (value == "ok") {
                    customDialog(
                      body: "you need go to signup?",
                      title: "Login",
                      okButton: "Yes",
                      cancelButton: "No",
                      context: context,
                    ).then((value) {
                      if (value == "ok") {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const SignupPage(),
                          ),
                        );
                      }
                    });
                  }
                });
              } else {
                checkUser(
                        name: nameController.text.toString(),
                        password: passwordController.text.toString())
                    .then((value) {
                  if (value['mainCheck']) {
                    print("LoggedIn!");
                    saveUserId(userData['id']);
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                        (Route<dynamic> route) => false);
                  } else {
                    print("Please Signup First!");
                  }
                });
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.amber.shade300),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<Map> checkUser({name, password}) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    await databaseHelper.init();
    List users = [];
    await databaseHelper.queryAllRows().then((value) {
      print(value);
      users = value;
    });
    bool checkName = true;
    bool checkPassword = true;

    for (var i = 0; i < users.length; i++) {
      if (name == users[i]['name'] && password == users[i]['password']) {
        userData = users[i];
        return {"mainCheck": true};
      }
      if (name != users[i]['name']) {
        checkName = false;
      }
      if (password != users[i]['password']) {
        checkPassword = false;
      }
    }

    return {
      "mainCheck": false,
      "checkName": checkName,
      "checkPassword": checkPassword
    };

    /*   if (name == prefs.getString("name") &&
        password == prefs.getString("password")) {
      return {"mainCheck": true};
    } else {
      if (name != prefs.getString("name")) {
        checkName = false;
      }
      if (password != prefs.getString("password")) {
        checkPassword = false;
      }
      return {
        "mainCheck": false,
        "checkName": checkName,
        "checkPassword": checkPassword
      };
    } */
  }
}
