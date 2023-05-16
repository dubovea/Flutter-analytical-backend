import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final int id;
  final int customerId;
  final List<int> productIds;
  final double delivery;
  final double subtotal;
  final double total;
  final bool isAccepted;
  final bool isDelivered;
  final DateTime createdAt;

  const Order({
    required this.id,
    required this.customerId,
    required this.productIds,
    required this.delivery,
    required this.subtotal,
    required this.total,
    required this.isAccepted,
    required this.isDelivered,
    required this.createdAt,
  });

  @override
  Order copyWith(
      {int? id,
      int? customerId,
      List<int>? productIds,
      double? delivery,
      double? subtotal,
      double? total,
      bool? isAccepted,
      bool? isDelivered,
      DateTime? createdAt}) {
    return Order(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      productIds: productIds ?? this.productIds,
      delivery: delivery ?? this.delivery,
      subtotal: subtotal ?? this.subtotal,
      total: total ?? this.total,
      isAccepted: isAccepted ?? this.isAccepted,
      isDelivered: isDelivered ?? this.isDelivered,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'productIds': productIds,
      'delivery': delivery,
      'subtotal': subtotal,
      'total': total,
      'isAccepted': isAccepted,
      'isDelivered': isDelivered,
      'createdAt': createdAt.microsecondsSinceEpoch
    };
  }

  factory Order.fromSnapshot(DocumentSnapshot snapshot) {
    return Order(
      id: snapshot['id'],
      customerId: snapshot['customerId'],
      productIds: snapshot['productIds'],
      delivery: snapshot['delivery'],
      subtotal: snapshot['subtotal'],
      total: snapshot['total'],
      isAccepted: snapshot['isAccepted'],
      isDelivered: snapshot['isDelivered'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(snapshot['createdAt']),
    );
  }

  String toJson() => json.encode(toMap());

  List<Object?> get props => [
        id,
        customerId,
        productIds,
        delivery,
        subtotal,
        total,
        isAccepted,
        isDelivered,
        createdAt
      ];

  static List<Order> orders = [
    Order(
        id: 1,
        customerId: 234,
        productIds: [1, 2],
        delivery: 10,
        subtotal: 20,
        total: 30,
        isAccepted: true,
        isDelivered: true,
        createdAt: DateTime.now())
  ];
}
