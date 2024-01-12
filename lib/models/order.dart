import 'package:start/models/product.dart';

class Order {
  double total;
  List<Product> products;
  String time;
  String id;

  Order(
      {required this.total,
      required this.products,
      required this.time,
      required this.id});
}
