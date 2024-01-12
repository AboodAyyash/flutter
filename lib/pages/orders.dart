import 'package:flutter/material.dart';
import 'package:start/models/order.dart';
import 'package:start/pages/order-details.dart';
import 'package:start/shared/shared.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  List<Order> orders = [];
  @override
  void initState() {
    setState(() {
      orders = orderController.getOrders();
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        title: Text("Orders"),
      ),
      body: ListView(children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: orders.length,
            itemBuilder: (BuildContext context, index) {
              return orderData(orders[index]);
            }),
      ]),
    );
  }

  Widget orderData(Order order) {
    return InkWell(
      onTap: () {
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => OrderDetails(order),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[400],
        ),
        child: Column(
          children: [
            orderDetailsRow("ID:", order.id),
            orderDetailsRow("Time:", order.time),
            orderDetailsRow("Total:", order.total.toString())
          ],
        ),
      ),
    );
  }

  Widget orderDetailsRow(String title, String result) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(result),
      ],
    );
  }
}
