import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:start/pages/auth/login.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // timer();
  }

  final dio = Dio();
  List items = [];
  List subCategories = [];
  void dioExp() async {
    items = [];
    print("response");
    final response = await dio.get(
        'https://aura.hikayapharmacy.com/api/customer/categories?language=en');

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.data['data']);
      int count = 0;
      for (var i = 0; i < response.data['data'].length; i++) {
        items.add(response.data['data'][i]);
        for (var j = 0;
            j < response.data['data'][i]['sub_category'].length;
            j++) {
          count += 1;
        }
      }
      setState(() {});
      print(count);
    }
  }


  void timer() {
    Timer(Duration(seconds: 3), () {
      Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const LoginPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset(
          "assets/images/splash.jpeg",
        ),
        ListView(
          children: [
            Text(
              "Categories",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            for (int i = 0; i < items.length; i++)
              InkWell(
                onTap: () {
                  setState(() {
                     subCategories = items[i]['sub_category'];
                  });
                 
                  print(items[i]['sub_category'].length);
                },
                child: Text(
                  items[i]['name'],
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
           SizedBox(height: 20,),
           
            for (int i = 0; i < subCategories.length; i++)
              InkWell(
                onTap: () {
                 /*  subCategories = items[i]['sub_category'];
                  print(subCategories[i]['sub_category'].length); */
                },
                child: Text(
                  subCategories[i]['name'],
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        Positioned(
          right: 200,
          top: 200,
          child: InkWell(
            onTap: () {
              dioExp();
            },
            child: Text(
              translate("DIO"), //login
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        /* Container(
          margin: EdgeInsets.only(top: 200, left: 20),
          child: 
        ), */
      ]),
    );
  }
}
