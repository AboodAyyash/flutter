import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:start/pages/auth/login.dart';
import 'package:start/pages/hash.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ScrollController controller = ScrollController();
  List skills = [
    {"title": "flutter", "isSelected": false},
    {"title": "cleanCode", "isSelected": false},
    {"title": "dart", "isSelected": false},
    {"title": "frontEnd", "isSelected": false},
  ];

  String skillsText = "";
  double maxScrollExtent = 0.0;
  double currentPosition = 0.0;

  int count = 0;
  @override
  void initState() {
    // TODO: implement initState
    /*  controller.addListener(() {
      maxScrollExtent = controller.position.maxScrollExtent;
      currentPosition = controller.position.pixels;
      if (maxScrollExtent == currentPosition) {
        print("Added");
        setState(() {
          skills.add(
            {"title": "lazyLoading", "isSelected": false},
          );
        });
      }
    }); */
    super.initState();
  }

  final deviceInfoPlugin = DeviceInfoPlugin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate("myProfile")),
        actions: [
          IconButton(
            onPressed: () {
              skillsText = "";
              for (var i = 0; i < skills.length; i++) {
                skillsText += skills[i]['title'] + " , ";
              }
              skillsText = skillsText.substring(0, skillsText.length - 3);
              shareButton();
            },
            icon: Icon(Icons.share),
          ),
          IconButton(
            onPressed: () async {
              DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

              String uuid = '';
              if (Platform.isAndroid) {
                AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
                print('Running on ${androidInfo.id}');
                uuid = androidInfo.id;
              } else if (Platform.isIOS) {
                IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
                print('Running on ${iosInfo.identifierForVendor}');
                uuid = iosInfo.identifierForVendor.toString();
              }
              print(uuid);
            },
            icon: Icon(Icons.phone_android),
          ),
        ],
      ),
      body: ListView(
        controller: controller,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              translate("myProfile"),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ).animate().fade(duration: 900.ms),
          ),
          CircleAvatar(
            radius: 50,
            foregroundImage: AssetImage("assets/images/splash.jpeg"),
            backgroundColor: Colors.blue,
          ),
          /*    IconButton(
            onPressed: () {
              if (count <= 3) {
                count += 1;
              } else {
                print("please try after 1 min");
                Timer(Duration(seconds: 3), () {
                  count = 0;

                  print(count);
                });
              }
              print(count);
            },
            icon: Icon(Icons.next_plan_outlined),
          ), */
          /*  Column(
            children: [
              for (int i = 0; i < skills.length; i++)
                Container(
                  margin: EdgeInsets.symmetric(vertical: 50),
                  child: Text(
                    skills[i],
                  ),
                ),
            ],
          ), */

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              translate("mySkills"),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ).animate().fade(duration: 900.ms),
          ),
          Wrap(
            alignment: WrapAlignment.center,
            children: [
              for (int i = 0; i < skills.length; i++) skill(skills[i])
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
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const HashPage(),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              color: Colors.purple,
              child: Text(
                translate('logout'),
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

  void shareButton() async {
    // prfile
    await FlutterShare.share(
        title: 'prfile share',
        text: skillsText,
        linkUrl: 'https://flutter.dev/');
  }
}
