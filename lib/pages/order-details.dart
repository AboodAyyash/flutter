import 'package:flutter/material.dart';
import 'package:start/models/order.dart';
import 'package:expandable/expandable.dart';

class OrderDetails extends StatefulWidget {
  Order orderData;

  OrderDetails(this.orderData);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  late Order order;

  @override
  void initState() {
    order = widget.orderData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        title: Text("Order Details"),
        centerTitle: true,
        leading: BackButton(
          style: ButtonStyle(),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.abc))],
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Hey, Ricky",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Thank you! for shopping with us!",
                  style: TextStyle(fontSize: 16, color: Colors.grey[500]),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.grey.shade400, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ExpandableNotifier(
                    child: ExpandablePanel(
                      theme: const ExpandableThemeData(
                        iconColor: Colors.grey,
                        tapBodyToCollapse: true,
                      ),
                      header: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Order Details",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      collapsed: Container(),
                      expanded: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            orderDetailsRow("Order ID", order.id),
                            orderDetailsRow("Order Time", order.time),
                            orderDetailsRow(
                                "Order Total", order.total.toString()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.grey.shade400, width: 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text("Order order.id"),
                          ),
                        ],
                      ),
                      Divider(),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: order.products.length,
                          itemBuilder: (BuildContext context, index) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Image.network(
                                          order.products[index].img),
                                      flex: 3,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            order.products[index].name,
                                            style: TextStyle(
                                              fontSize: 22,
                                            ),
                                          ),
                                          Text(
                                            "QTY: ${order.products[index].qty.toString()}",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            order.products[index].price
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                if (index != (order.products.length - 1))
                                  Divider(),
                              ],
                            );
                          }),
                      Divider(),
                      orderDetailsRow(
                        "Total",
                        order.total.toString(),
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget orderDetailsRow(String title, String result,
      {fontSize = 14.0, FontWeight fontWeight = FontWeight.normal}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
        Text(
          result,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        ),
      ],
    );
  }
}
