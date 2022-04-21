import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/orderitem.dart';

class OrderItemModel extends OrderItem {
  OrderItemModel({
    required String orderId,
    required String customerId,
    required String restaurantId,
    required DateTime orderDate,
    required double totalAmount,
    required double? ratingGiven,
    required String status,
    required List<Map<String, dynamic>> order,
    required int pincode,
    required String address,
  }) : super(
          orderId: orderId,
          customerId: customerId,
          restaurantId: restaurantId,
          orderDate: orderDate,
          totalAmount: totalAmount,
          ratingGiven: ratingGiven,
          status: status,
          order: order,
          pincode: pincode,
          address: address,
        );
  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    print(json['order']);
    print(json['order'].runtimeType);

    List<Map<String, dynamic>> order = [];
    json['order'].forEach((element) {
      order.add(element);
    });

    Timestamp a = json["orderDate"];
    print(json['totalAmount'].runtimeType);
    print(json['ratingGiven'].runtimeType);

    return OrderItemModel(
      orderId: json['orderId'],
      customerId: json['customerId'],
      restaurantId: json['restaurantId'],
      orderDate: DateTime.fromMicrosecondsSinceEpoch(a.microsecondsSinceEpoch),
      totalAmount: json['totalAmount'].toDouble(),
      ratingGiven: json['ratingGiven'].toDouble(),
      status: json['status'],
      order: order,
      pincode: json['pincode'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'customerId': customerId,
      'restaurantId': restaurantId,
      'orderDate': orderDate.toIso8601String(),
      'totalAmount': totalAmount,
      'ratingGiven': ratingGiven,
      'status': status,
      'order': order,
      'pincode': pincode,
      'address': address,
    };
  }
}
