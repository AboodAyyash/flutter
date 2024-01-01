import 'package:flutter/material.dart';
import 'package:flutter_slidable_panel/flutter_slidable_panel.dart';
import 'package:start/models/cart.dart';
import 'package:start/shared/shared.dart';

Widget cartProduct(Cart product, index, setState) {
  final SlideController _slideController = SlideController(
    usePreActionController: true,
    usePostActionController: true,
  );
  return SlidablePanel(
    controller: _slideController,
    preActions: [
      IconButton(
        onPressed: () {
          // _slideController.toggleAction(0);
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
        subtitle: Text(product.price.toString()),
        trailing: IconButton(
          onPressed: () {
            setState(() {
              cartController.deleteFromCart(index);
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
