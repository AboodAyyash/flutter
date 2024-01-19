import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:start/pages/auth/login.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Signup",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          TextField(
            style: const TextStyle(color: Colors.white),
            controller: emailController,
            maxLines: 2,
            decoration: const InputDecoration(
              hintText: "Enter Email",
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
              if (emailController.text.toString().isEmpty ||
                  nameController.text.toString().isEmpty ||
                  passwordController.text.toString().isEmpty) {
                print("Please Add All Data!");
              } else {
                signupUser(
                    email: emailController.text.toString(),
                    name: nameController.text.toString(),
                    password: passwordController.text.toString());
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const LoginPage(),
                  ),
                );
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.amber.shade300),
                  child: Text(
                    "Signup",
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

  signupUser({email, name, password}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email);
    prefs.setString("name", name);
    prefs.setString("password", password);
  }
}
