import 'package:flutter/material.dart';
import 'package:flutter_slidable_panel/flutter_slidable_panel.dart';
import 'package:start/controllers/cart.dart';
import 'package:start/models/cart.dart';
import 'package:start/shared/shared.dart';
import 'package:start/widgets/cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Cart> products = [];

  @override
  void initState() {
    setState(() {
      products = cartController.getCart();
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text("Cart Page"),
        backgroundColor: Colors.red,
      ),
      body: ListView(
        children: [
          for (int i = 0; i < products.length; i++)
            cartProduct(products[i], i, setState),
          if (products.isEmpty) Text("This Page Is Empty")
        ],
      ),
    );
  }
}
