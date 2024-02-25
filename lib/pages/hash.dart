import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';

class Product {
  String name;
  String price;
  String size;

  Product({required this.name, required this.price, required this.size});
}

class HashPage extends StatefulWidget {
  const HashPage({super.key});

  @override
  State<HashPage> createState() => _HashPageState();
}

class _HashPageState extends State<HashPage> {
  double containerHeight = 200.0;
  Color containerColor = Colors.red;
  double borderRadius = 10;

  TextEditingController firstPassword = TextEditingController();
  TextEditingController secoundPassword = TextEditingController();

  String firstHash = "";
  String secoundHash = "";

  String needHash = "12345";

  List serverData = [
    {"product_name": "Milk", "product_price": "10", "product_size": "L"},
    {"product_name": "Water", "product_price": "5", "product_size": "S"},
    {"product_name": "Chips", "product_price": "25", "product_size": "M"},
    {"product_name": "Chock", "product_price": "15", "product_size": "XL"},
  ];

  List servertitle = [
    {
      "title_name": "Name",
    },
    {
      "title_name": "Price",
    },
    {
      "title_name": "Size",
    },
  ];
  /* 
 
  
   */

  Map products = {};

/*  "titles": ['Name', "price", "Size"],
    "products": [
      {"name": "Milk", "price": "10", "size": "L"},
      {"name": "Water", "price": "5", "size": "S"},
      {"name": "Chips", "price": "25", "size": "M"},
      {"name": "Chock", "price": "15", "size": "XL"},
    ] */

  //Md5 base64 hmac
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate("hashPage")),
        actions: [
          IconButton(
              onPressed: () {
                checkGoals();
                // getData();
              },
              icon: Icon(Icons.data_array)),
          IconButton(
            onPressed: () {
              setState(() {
                containerHeight = 300.0;
                containerColor = Colors.blue;
                borderRadius = 50;
              });
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              // 123456 => md5 => hmac => (result)
              // md5 = e10adc3949ba59abbe56e057f20f883e
              // hamc after md5 = 0fa557a74476442b073e1c0b8330d3c60bb512383566e437973ed2fc559b7da5
              print(hash(generateMd5(needHash)));
              // 12345
              // md5 827ccb0eea8a706c4c34a16891f84e7b
              // hmac cc79ac5a18ab54a1b6cb2abef02960d4890ffc7d503b64877c2a3bc7d1f6e57c
            },
            icon: Icon(Icons.lock),
          ),
        ],
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(),
              AnimatedContainer(
                duration: Duration(milliseconds: 400),
                width: 200,
                height: containerHeight,
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              Container(),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: firstPassword,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                  translate('first password'),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              firstHash = hash(generateMd5(firstPassword.text.toString()));
              print(firstHash);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              color: Colors.purple,
              child: Text(
                translate('Hash First'),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: secoundPassword,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                  translate('secound password'),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              secoundHash = hash(generateMd5(secoundPassword.text.toString()));

              print(secoundHash);
              if (firstHash == secoundHash) {
                print("Done");
              } else {
                print("Incorrect Password");
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              color: Colors.purple,
              child: Text(
                translate('check Hash'),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          if (products.isNotEmpty)
            Column(
              children: [
                Row(
                  children: [
                    for (int i = 0; i < products['titles'].length; i++)
                      Expanded(
                        child: Text(
                          products['titles'][i],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                  ],
                ),
                Divider(),
                for (int i = 0; i < products['products'].length; i++)
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              products['products'][i].name,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              products['products'][i].price,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              products['products'][i].size,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                    ],
                  ),

                /* 
               
                 for (int i = 0; i < products['products'].length; i++)
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              products['products'][i]['name'],
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              products['products'][i]['price'],
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              products['products'][i]['size'],
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                    ],
                  ),
                 */
                SizedBox(
                  height: 50,
                ),
              ],
            )
        ],
      ),
    );
  }

  String hash(data) {
    var key = utf8.encode(data);
    var bytes = utf8.encode("foobar");

    var hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    var digest = hmacSha256.convert(bytes);
    print("HMAC digest as bytes: ${digest.bytes}");
    print("HMAC digest as hex string: $digest");
    return digest.toString();
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  void getData() {
    List titles = [];

    List productList = [];
    for (var i = 0; i < serverData.length; i++) {
      Product product = Product(
          name: serverData[i]['product_name'],
          price: serverData[i]['product_price'],
          size: serverData[i]['product_size']);
      /*  Map product = {
        "name": serverData[i]['product_name'],
        "price": serverData[i]['product_price'],
        "size": serverData[i]['product_size'],
      }; */

      productList.add(product);
    }

    for (var i = 0; i < servertitle.length; i++) {
      titles.add(servertitle[i]['title_name']);
    }
    setState(() {
      products['products'] = productList;
      products['titles'] = titles;
    });

    print(products);
  }
}

void checkGoals() {
  var allPoints = 25;
  List goals = [
    {"playerName": "b", "location": "4"},
    {"playerName": "c", "location": "2"},
    {"playerName": "d", "location": "2"},
    {"playerName": "f", "location": "1"},
  ];

  List teamAFull = [
    {'name': "a", 'age': '20', 'hight': "190","team":'a'}
  ];
  
  List teamA = ["a", "b", "c", "d", "e", "k"];
  List teamB = ["f", "g", "h", "j", "u", "q"];
  int goalsA = 0;
  int goalsB = 0;
  for (var i = 0; i < goals.length; i++) {
    if (teamA.contains(goals[i]['playerName'])) {
      goalsA += 1;
    }
    if (teamB.contains(goals[i]['playerName'])) {
      goalsB += 1;
    }
  }
  if (goalsA == (goalsB + 2)) {
    print("Team A is Win");
  }
  if (goalsB == (goalsA + 2)) {
    print("Team B is Win");
  }
  print("goalsA $goalsA");
  print("goalsB $goalsB");
}
