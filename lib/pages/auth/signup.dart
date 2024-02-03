import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:start/pages/auth/login.dart';
import 'package:start/pages/skills.dart';
import 'package:start/widgets/lang-button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String accept = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          langButton(),
          SizedBox(
            height: 80,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                translate('signupPage'),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                translate('signupDescreption'),
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                  translate('email'),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                  translate('name'),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                  translate('password'),
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(translate("acceptTermsAndConditions")),
            leading: Radio(
                value: "1",
                groupValue: accept,
                onChanged: (value) {
                  setState(() {
                    accept = value.toString();
                  });
                }),
          ),
          /* RadioListTile(
              title: Text(translate("acceptTermsAndConditions")),
              value: "1",
              groupValue: accept,
              onChanged: (value) {
                setState(() {
                  accept = value.toString();
                });
              }), */
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Text(translate("ifYouHaveAnAccount,")),
                InkWell(
                  onTap: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const LoginPage(),
                      ),
                    );
                  },
                  child: Text(
                    translate("loginHere"),
                    style: TextStyle(color: Colors.purple),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const SkillsPage(),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              color: Colors.purple,
              child: Text(
                translate('signup'),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
