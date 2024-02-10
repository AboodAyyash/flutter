import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:start/pages/auth/profile.dart';
import 'package:start/widgets/lang-button.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  List skills = [
    {"title": "flutter", "isSelected": false},
    {"title": "cleanCode", "isSelected": false},
    {"title": "dart", "isSelected": false},
    {"title": "frontEnd", "isSelected": false},
    {"title": "ui/ux", "isSelected": false},
    {"title": "fastCoding", "isSelected": false},
  ];
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
                translate('skillsPage'),
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
                translate('skillsDescreption'),
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              for (int i = 0; i < skills.length; i++) skill(skills[i])
            ],
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const ProfilePage(),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              color: Colors.purple,
              child: Text(
                translate('finishSiginUp'),
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

  Widget skill(skill) {
    return InkWell(
      onTap: () {
        setState(() {
          skill['isSelected'] = !skill['isSelected'];
        });
      },
      child: Container(
        color: skill['isSelected'] ? Colors.amber : Colors.grey.shade400,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        child: Text(translate(skill['title'])),
      ),
    );
  }
}
