import 'package:flutter/material.dart';
import 'package:start/controllers/product.dart';
import 'package:start/models/product.dart';
import 'package:start/pages/cart.dart';
import 'package:start/widgets/product.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int x = 10;
  int z = 0;

  ProductController productController = ProductController();
  List<Product> products = [];

  @override
  void initState() {
    // TODO: implement initState
    productController.addProducts();
    setState(() {
      products = productController.getProduts();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          "App",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const CartPage(),
                ),
              );
            },
            icon: const Icon(
              Icons.shopping_bag,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                x += 1;
              });
              print(x);
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                x -= 1;
              });
              print(x);
            },
            icon: const Icon(
              Icons.remove,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: ListView(
          children: [
            Column(
              children: [
                for (int i = 0; i < products.length; i++)
                  productWidget(products[i], setState),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    customContainer("Ahmad"),
                    customContainer("Omar"),
                    customContainer("Khaled"),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 5,
                      child: TextField(
                        onChanged: (String value) {
                          print(value);
                          setState(() {
                            z = int.parse(value);
                          });
                        },
                        decoration: const InputDecoration(
                          label: Text("Add Z Value"),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 5,
                      child: TextField(
                        onChanged: (String value) {
                          print(value);
                          setState(() {
                            x = int.parse(value);
                          });
                        },
                        onTap: () {
                          print("Tapped X");
                        },
                        decoration: const InputDecoration(
                          label: Text("Add X Value"),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text((z + x).toString()),
                const SizedBox(
                  height: 20,
                ),
                row2(),
                row2(),
                row2(),
                InkWell(
                  onTap: () {
                    print("Image");
                  },
                  child: Image.asset("assets/images/image.png"),
                ),
                Image.network(
                  "https://media.macphun.com/img/uploads/customer/how-to/608/15542038745ca344e267fb80.28757312.jpg?q=85&w=1340",
                  width: 60,
                  height: 60,
                ),
                Image.asset("assets/images2/5.png"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget customContainer(String name) {
    return InkWell(
      onTap: () {
        print(name);
      },
      onDoubleTap: () {
        print(name + " Double");
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.all(10),
        child: Text(name),
      ),
    );
  }

  Widget row2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        customContainer('Hello'),
        customContainer('Print'),
        customContainer('Text'),
      ],
    );
  }
}
