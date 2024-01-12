import 'package:flutter/material.dart';
import 'package:flutter_slidable_panel/flutter_slidable_panel.dart';
import 'package:start/models/product.dart';
import 'package:start/shared/shared.dart';

Widget cartProduct(Product product, index, setState) {
  final SlideController _slideController = SlideController(
    usePreActionController: true,
    usePostActionController: true,
  );
  return SlidablePanel(
    controller: _slideController,
    preActions: [
      IconButton(
        onPressed: () {
          _slideController.toggleAction(0);
          setState(() {
            cartController.deleteFromCart(index);
            total = cartController.getTotal();
          });
        },
        style: TextButton.styleFrom(
          backgroundColor: Colors.red,
          shape: const RoundedRectangleBorder(),
        ),
        icon: Icon(Icons.delete),
      ),
    ],
    child: Card(
      child: ListTile(
        leading: Image.network(
          product.img,
          width: 90,
          height: 90,
        ),
        title: Text(product.name),
        subtitle: Text("Price: ${product.price}   Qty: ${product.qty}"),
        trailing: IconButton(
          onPressed: () {
            setState(() {
              cartController.deleteFromCart(index);
              total = cartController.getTotal();
            });
          },
          icon: Icon(
            Icons.delete,
          ),
        ),
      ),
    ),
  );
}
