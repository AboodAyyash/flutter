import 'package:start/controllers/cart.dart';
import 'package:start/models/cart.dart';
import 'package:start/models/product.dart';
import 'package:start/shared/shared.dart' as shared;

class ProductController {
  List<Product> products = [];

  void addProducts() {
    products.add(
      Product(
          img:
              "https://media.macphun.com/img/uploads/customer/how-to/608/15542038745ca344e267fb80.28757312.jpg?q=85&w=1340",
          name: "Milk",
          price: 12,
          qty: 2),
    );

    products.add(
      Product(
          img:
              "https://media.macphun.com/img/uploads/customer/how-to/608/15542038745ca344e267fb80.28757312.jpg?q=85&w=1340",
          name: "Water",
          price: 10,
          qty: 5),
    );

    products.add(
      Product(
          img:
              "https://media.macphun.com/img/uploads/customer/how-to/608/15542038745ca344e267fb80.28757312.jpg?q=85&w=1340",
          name: "Pepsi",
          price: 15,
          qty: 15),
    );
  }

  List<Product> getProduts() {
    return products;
  }

  void addQtyProduct(Product product) {
    product.qty += 1;
  }

  void removeQtyProduct(Product product) {
    product.qty -= 1;
  }

  void addToCart(Product product) {
    Cart cart = Cart(
        img: product.img,
        name: product.name,
        price: product.price,
        qty: product.qty);
    shared.cartController.productsCart.add(cart);
    print(shared.cartController.productsCart.length);
  }
}
