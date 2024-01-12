import 'package:flutter/material.dart';
import 'package:flutter_slidable_panel/flutter_slidable_panel.dart';
import 'package:start/controllers/cart.dart';
import 'package:start/models/cart.dart';
import 'package:start/models/product.dart';
import 'package:start/shared/shared.dart';
import 'package:start/widgets/cart.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Cart> products = []; // id qty

  @override
  void initState() {
    setState(() {
      products = cartController.getCart();
    });
    cartController.cartProducts = [];
    for (var i = 0; i < products.length; i++) {
      print(cartController.getCartFromAllProducts(products[i]).id);
      if (cartController.getCartFromAllProducts(products[i]).id != 0) {
        cartController.cartProducts
            .add(cartController.getCartFromAllProducts(products[i]));
      }
    }

    setState(() {
      total = cartController.getTotal();
    });

    print(cartController.cartProducts);
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
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  cartController.deleteAll();
                  total = cartController.getTotal();
                });
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Total:",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                total.toString(),
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cartController.cartProducts.length,
              itemBuilder: (BuildContext context, index) {
                return cartProduct(
                    cartController.cartProducts[index], index, setState);
              }),
          /*   for (int i = 0; i < cartController.cartProducts.length; i++)
            cartProduct(cartController.cartProducts[i], i, setState),
          if (cartController.cartProducts.isEmpty) Text("This Page Is Empty"),
          */
          InkWell(
            onTap: () {
              setState(() {
                cartController.addOrder();
                total = 0;
              });

              print(orderController.order.length);
            },
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.amber,
              ),
              alignment: Alignment.center,
              child: const Text(
                "Checkout",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
