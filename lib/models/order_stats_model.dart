import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderStats {
  final DateTime dateTime;
  final int index;
  final int orders;
  charts.Color? barColor;

  OrderStats(
      {required this.dateTime, required this.index, required this.orders}) {
    barColor = charts.ColorUtil.fromDartColor(Colors.black);
  }

  factory OrderStats.fromSnapshot(DocumentSnapshot snapshot, int index) {
    return OrderStats(
      dateTime: snapshot['dateTime'].toDate(),
      index: index,
      orders: snapshot['orders'],
    );
  }

  static final List<OrderStats> data = [
    OrderStats(dateTime: DateTime.now(), index: 0, orders: 10),
    OrderStats(dateTime: DateTime.now(), index: 1, orders: 252),
    OrderStats(dateTime: DateTime.now(), index: 2, orders: 43),
    OrderStats(dateTime: DateTime.now(), index: 3, orders: 56),
    OrderStats(dateTime: DateTime.now(), index: 4, orders: 1),
    OrderStats(dateTime: DateTime.now(), index: 5, orders: 222),
    OrderStats(dateTime: DateTime.now(), index: 6, orders: 123),
    OrderStats(dateTime: DateTime.now(), index: 7, orders: 132),
    OrderStats(dateTime: DateTime.now(), index: 8, orders: 58),
    OrderStats(dateTime: DateTime.now(), index: 9, orders: 16),
    OrderStats(dateTime: DateTime.now(), index: 10, orders: 0),
    OrderStats(dateTime: DateTime.now(), index: 11, orders: 99),
    OrderStats(dateTime: DateTime.now(), index: 12, orders: 54),
  ];
}
