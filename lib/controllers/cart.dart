import 'package:start/models/cart.dart';

class CartController {
  List<Cart> productsCart = [];

  List<Cart> getCart() {
    return productsCart;
  }

  void deleteFromCart(/* Cart product */ index) {
    //  productsCart.remove(product);

    productsCart.removeAt(index);
  }
}
