import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_ordering_app/features/admin/order/presentation/pages/single_order_page.dart';

import 'dart:developer' as developer;

import '../../../../admin/order/data/models/orderitem_model.dart';

// import '../../data/models/orderitem_model.dart';

class OrderCardC extends StatefulWidget {
  OrderItemModel order;
  OrderCardC({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderCardC> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCardC> {
  late CollectionReference orders;
  double totalAmount = 0;
  String? orderStatus;
  late OrderItemModel orderListing;

  @override
  void initState() {
    orders = FirebaseFirestore.instance.collection('orders');
    orderListing = widget.order;
    developer.log(orderListing.toString(), name: 'On Menu Load');
    totalAmount = 365.3;
    orderStatus = orderListing.status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map orderStatusColors = {
      'Pending': Color.fromARGB(255, 97, 97, 97),
      'Accepted': Colors.blueAccent,
      'Declined': Colors.red,
      'Ready': Colors.orange,
      'Delivered': Colors.green
    };

    Map dropDownorderStatusColors = {
      'Pending': Color.fromARGB(255, 97, 97, 97),
      'Accepted': Colors.blueAccent,
      'Ready': Colors.orange,
      'Delivered': Colors.green
    };

    return Card(
        child: ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SingleOrderPage(
                        orderItem: orderListing,
                      )));
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
              child: Row(
                children: [
                  Expanded(child: Text('ID: ${orderListing.orderId}')),
                  Text(
                      '${orderListing.orderDate.hour}:${orderListing.orderDate.minute} PM')
                ],
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color:
                          dropDownorderStatusColors['${widget.order.status}'],
                      borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Text(
                        '${widget.order.status}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: orderListing.order.length,
              itemBuilder: (context, index) {
                dynamic orderItem = orderListing.order[index];
                return ListTile(
                  visualDensity: VisualDensity(vertical: -4),
                  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  title: Text(
                      '${orderItem['quantity']} x ${orderItem['itemId'].substring(1, 4)}',
                      style: TextStyle(letterSpacing: 2)),
                );
              }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Total Bill: $totalAmount',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 20,
              ),
            ),
          ),
          if (orderStatus == 'Placed')
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  onPressed: () {
                    orders
                        .doc(orderListing.orderId)
                        .update({'status': 'Accepted'})
                        .then((value) => print("Yay"))
                        .catchError((e) => print(e));
                  },
                  child: Text('ACCEPT', style: TextStyle(letterSpacing: 1.5)),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: () {},
                  child: Text('DECLINE', style: TextStyle(letterSpacing: 1.5)),
                )
              ],
            )
          else
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text('The order has been $orderStatus')),
            )
        ],
      ),
    ));
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('Choose Order Status'),
    actions: [
      Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Accepted'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Accepted'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Accepted'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Accepted'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Accepted'),
            ),
          ],
        ),
      ),
    ],
  );
}
