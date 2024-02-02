import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:start/shared/shared.dart';

class FriandPage extends StatefulWidget {
  const FriandPage({super.key});

  @override
  State<FriandPage> createState() => _FriandPageState();
}

class _FriandPageState extends State<FriandPage> {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  CarouselController controller = CarouselController();

  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      print(scrollController.offset);
    });
  }

  int x = 0;
  List allData = [0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Friands"),
        actions: [
          IconButton(
            onPressed: () {
              x += 1;
              allData.add(x);
              //print(x);
              sharedController.sink.add("event");
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
              onPressed: () {
                controller.animateToPage(4);
              },
              icon: Icon(Icons.next_plan))
        ],
      ),
      body: StreamBuilder(
          stream: sharedController.stream,
          builder: (BuildContext context, snapshot) {
            print(snapshot.data);
            return ListView(
              controller: scrollController,
              children: [
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (int i = 0; i < allData.length; i++)
                          Container(
                            margin: EdgeInsets.all(10),
                            child: Text(
                              x.toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                CarouselSlider(
                    carouselController: controller,
                    options: CarouselOptions(
                      disableCenter: true,
                    ),
                    items: imgList
                        .map((item) => Container(
                              child: Image.network(item.toString()),
                              color: Colors.green,
                            ))
                        .toList()),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    for (int i = 0; i < allData.length; i++)
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          x.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    for (int i = 0; i < allData.length; i++)
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          x.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    for (int i = 0; i < allData.length; i++)
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          x.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    for (int i = 0; i < allData.length; i++)
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          x.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    for (int i = 0; i < allData.length; i++)
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          x.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    for (int i = 0; i < allData.length; i++)
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          x.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    for (int i = 0; i < allData.length; i++)
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          x.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    for (int i = 0; i < allData.length; i++)
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          x.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                  ],
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    for (int i = 0; i < allData.length; i++)
                      Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          x.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            );
          }),
    );
  }
}
