import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Orders extends Equatable {
  final int id;
  final int customerId;
  final List<int> productIds;
  final double delivery;
  final double subtotal;
  final double total;
  final bool isAccepted;
  final bool isCanceled;
  final bool isDelivered;
  final DateTime createdAt;

  const Orders({
    required this.id,
    required this.customerId,
    required this.productIds,
    required this.delivery,
    required this.subtotal,
    required this.total,
    required this.isAccepted,
    required this.isCanceled,
    required this.isDelivered,
    required this.createdAt,
  });

  @override
  Orders copyWith(
      {int? id,
      int? customerId,
      List<int>? productIds,
      double? delivery,
      double? subtotal,
      double? total,
      bool? isAccepted,
      bool? isCanceled,
      bool? isDelivered,
      DateTime? createdAt}) {
    return Orders(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      productIds: productIds ?? this.productIds,
      delivery: delivery ?? this.delivery,
      subtotal: subtotal ?? this.subtotal,
      total: total ?? this.total,
      isAccepted: isAccepted ?? this.isAccepted,
      isCanceled: isCanceled ?? this.isCanceled,
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
      'isCanceled': isCanceled,
      'isDelivered': isDelivered,
      'createdAt': createdAt.microsecondsSinceEpoch
    };
  }

  factory Orders.fromSnapshot(DocumentSnapshot snapshot) {
    return Orders(
      id: snapshot['id'],
      customerId: snapshot['customerId'],
      productIds: List<int>.from(snapshot['productIds']),
      delivery: snapshot['delivery'],
      subtotal: snapshot['subtotal'],
      total: snapshot['total'],
      isAccepted: snapshot['isAccepted'],
      isCanceled: snapshot['isCanceled'],
      isDelivered: snapshot['isDelivered'],
      createdAt: snapshot['createdAt'].toDate(),
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
        isCanceled,
        isDelivered,
        createdAt
      ];

  static List<Orders> orders = [
    Orders(
        id: 1,
        customerId: 234,
        productIds: [1, 2],
        delivery: 10,
        subtotal: 20,
        total: 30,
        isAccepted: true,
        isCanceled: true,
        isDelivered: true,
        createdAt: DateTime.now()),
    Orders(
        id: 2,
        customerId: 234,
        productIds: [2, 3],
        delivery: 1,
        subtotal: 2,
        total: 3,
        isAccepted: true,
        isCanceled: true,
        isDelivered: false,
        createdAt: DateTime.now())
  ];
}
