import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start/pages/home.dart';

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
              } else {
                checkUser(
                        name: nameController.text.toString(),
                        password: passwordController.text.toString())
                    .then((value) {
                  print(value);
                  if (value['mainCheck']) {
                    print("LoggedIn!");
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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkName = true;
    bool checkPassword = true;
    prefs.getString("name");
    prefs.getString("password");

    if (name == prefs.getString("name") &&
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
    }
  }
}
