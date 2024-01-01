import 'package:flutter/material.dart';
import 'package:start/controllers/product.dart';
import 'package:start/models/product.dart';

ProductController productController = ProductController();

Widget productWidget(Product product, setState) {
  return Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(10),
    width: 220,
    decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.all(Radius.circular(4))),
    child: Column(
      children: [
        Image.network(
          product.img,
          width: 190,
          height: 190,
        ),
        Text(
          product.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          "Price: ${product.price.toString()}",
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 16,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    productController.removeQtyProduct(product);
                  });
                },
                icon: const Icon(
                  Icons.remove,
                )),
            Text(
              "QTY: ${product.qty.toString()}",
              style: const TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    productController.addQtyProduct(product);
                  });
                },
                icon: const Icon(
                  Icons.add,
                )),
          ],
        ),
        InkWell(
          onTap: () {
            productController.addToCart(product);
          },
          child: Text("Add To Cart"),
        ),
      ],
    ),
  );
}
