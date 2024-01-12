import 'dart:math';

import 'package:start/models/cart.dart';
import 'package:start/models/order.dart';
import 'package:start/models/product.dart';
import 'package:start/shared/shared.dart';

class CartController {
  List<Cart> productsCart = [];
  List<Product> cartProducts = [];
  List<Cart> getCart() {
    return productsCart;
  }

  void deleteFromCart(/* Cart product */ index) {
    //  productsCart.remove(product);

    productsCart.removeAt(index);
    cartProducts.removeAt(index);
  }

  void resetData() {
    cartProducts = [];
  }

  void deleteAll() {
    cartProducts = [];
    productsCart = [];
  }

  Product getCartFromAllProducts(Cart product) {
    Product newProduct = Product(img: "", id: 0, name: "", price: 0, qty: 0);
    productController.addProducts();
    for (var i = 0; i < productController.getProduts().length; i++) {
      print("${product.id} == ${productController.getProduts()[i].id}");
      if (product.id == productController.getProduts()[i].id) {
        newProduct = Product(
            id: productController.getProduts()[i].id,
            img: productController.getProduts()[i].img,
            name: productController.getProduts()[i].name,
            price: productController.getProduts()[i].price,
            qty: product.qty);
        return newProduct;
      }
    }
    return newProduct;
  }

  double getTotal() {
    double total = 0;
    for (var i = 0; i < cartProducts.length; i++) {
      total += cartProducts[i].price * cartProducts[i].qty;
    }
    return total;
  }

  void addOrder() {
    String id = Random().nextInt(9999).toString(); // 1536 + 7-19-60-39
    String time = DateTime.now().toString();
    Order order =
        Order(products: cartProducts, total: getTotal(), id: id, time: time);
    orderController.order.add(order);
    deleteAll();
  }
}
